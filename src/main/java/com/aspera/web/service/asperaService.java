package com.aspera.web.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.aspera.web.vo.itemVO;

@Service
public class asperaService {
	// browse 寃곌낵 媛� parsing
	public List<itemVO> browseParse(String str) {
		List<itemVO> list = new ArrayList<itemVO>();

		try {
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(str);
			JSONObject jobj = (JSONObject) obj;
			HashMap map = (HashMap) jobj.get("self");
			Calendar cal = Calendar.getInstance();

			SimpleDateFormat in = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
			DateFormat out = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date data = in.parse((String) map.get("mtime"));
			cal.setTime(data);
			cal.add(Calendar.HOUR, +9);

			itemVO self = new itemVO((String) map.get("path"), (String) map.get("basename"), (String) map.get("type"),
					(long) map.get("size"), out.format(cal.getTime()));

			list.add(self);

			JSONArray jsonArray = (JSONArray) jobj.get("items");

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jtemp = (JSONObject) jsonArray.get(i);

				data = in.parse((String) jtemp.get("mtime"));
				cal.setTime(data);
				cal.add(Calendar.HOUR, +9);

				list.add(new itemVO((String) jtemp.get("path"), (String) jtemp.get("basename"),
						(String) jtemp.get("type"), (long) jtemp.get("size"), out.format(cal.getTime())));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// files api 泥섎━
	public StringBuilder files(String api, String current, String[] target) {
		try {
 			URL url = new URL("https://115.71.42.22:9092/files/" + api);
//			URL url = new URL("https://localhost:9092/files/" + api);

			 ignoreSSL(); // SSL �씤利앸갑�떇 鍮꾪솢�꽦�솕�빐�빞�븳�떎

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setConnectTimeout(5000);
			con.setReadTimeout(5000);

//			String name = "node_asperatest";
//			String password = "Passw0rd!";
 			String name = "admin";
			String password = "rootroot";

			String authString = name + ":" + password;
			Encoder encoder = Base64.getEncoder();
			byte[] authEncBytes = encoder.encode(authString.getBytes());
			String authStringEnc = new String(authEncBytes);
			con.setRequestProperty("Authorization", "Basic " + authStringEnc); // http 湲곕낯�씤利�

			con.setRequestMethod("POST");

			// json�쑝濡� message瑜� �쟾�떖�븯怨좎옄 �븷 �븣
			con.setRequestProperty("Content-Type", "application/json");
			con.setDoInput(true);
			con.setDoOutput(true); // POST �뜲�씠�꽣瑜� OutputStream�쑝濡� �꽆寃� 二쇨쿋�떎�뒗 �꽕�젙
			con.setUseCaches(false);
			con.setDefaultUseCaches(false);

			String json = null;

			switch (api) {
			case "browse":
				if (target == null) {
					json = "{\"path\":\"" + current + "\",\"sort\": \"type_a\"}";
				} else if(target[0].equals("") && !target[1].equals("")){
					json = "{\"path\":\"" + current + "\",\"sort\": \"" + target[1] + "\"}";
				} else{
					json = "{\"path\":\"" + current + "/" + target[0] + "\",\"sort\": \"type_a\"}";
				}
				break;
			case "create":
				json = "{\"paths\":[{\"path\":\"" + current + "/" + target[0] + "\",\"type\":\"directory\"}]}";
				break;
			case "delete":
				json = "{\"paths\":[";
				for (int i = 0; i < target.length; i++) {
					json += "{\"path\":\"" + current + "/" + target[i] + "\"}";
					if (i + 1 < target.length)
						json += ",";
				}
				json += "]}";
				break;
			case "rename":
				json = "{\"paths\":[{\"path\":\"" + current + "\",\"source\":\"" + target[0] + "\",\"destination\":\""
						+ target[1] + "\"}]}";
				break;
			}

			OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
			wr.write(json); // json �삎�떇�쓽 message �쟾�떖
			wr.flush();

			/////////////////////////////////////////////////////////////////////////////////////////

			StringBuilder sb = new StringBuilder();
			if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line).append("\n");
				}
				br.close();
			} else {
				System.out.println(con.getResponseMessage());
			}

			return sb;
		} catch (Exception e) {
			System.err.println(e.toString());
			return null;
		}
	}

	public void ignoreSSL() throws Exception {
		HostnameVerifier hv = new HostnameVerifier() {
			public boolean verify(String urlHostName, SSLSession session) {
				return true;
			}
		};

		TrustManager[] trustAllCerts = new TrustManager[1];
		TrustManager tm = new miTM();
		trustAllCerts[0] = tm;
		SSLContext sc = SSLContext.getInstance("SSL");
		sc.init(null, trustAllCerts, null);
		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

		HttpsURLConnection.setDefaultHostnameVerifier(hv);

	}

	static class miTM implements TrustManager, X509TrustManager {
		public X509Certificate[] getAcceptedIssuers() {
			return null;
		}

		public boolean isServerTrusted(X509Certificate[] certs) {
			return true;
		}

		public boolean isClientTrusted(X509Certificate[] certs) {
			return true;
		}

		public void checkServerTrusted(X509Certificate[] certs, String authType) throws CertificateException {
			return;
		}

		public void checkClientTrusted(X509Certificate[] certs, String authType) throws CertificateException {
			return;
		}
	}
}