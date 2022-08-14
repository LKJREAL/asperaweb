package com.aspera.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;
//
@Data
@AllArgsConstructor
public class itemVO {
	private String path;
	private String basename;
	private String type;
	private long size;
	private String mtime;

//	public itemVO(String path, String basename, String type, long size, String mtime) {
//		this.path = path;
//		this.basename = basename;
//		this.type = type;
//		this.mtime = mtime;
//		this.size = size;
//	}
//
//	public String getPath() {
//		return path;
//	}
//
//	public void setPath(String path) {
//		this.path = path;
//	}
//
//	public String getBasename() {
//		return basename;
//	}
//
//	public void setBasename(String basename) {
//		this.basename = basename;
//	}
//
//	public String getType() {
//		return type;
//	}
//
//	public void setType(String type) {
//		this.type = type;
//	}
//
//	public String getMtime() {
//		return mtime;
//	}
//
//	public void setMtime(String mtime) {
//		this.mtime = mtime;
//	}
//
//	public long getSize() {
//		return size;
//	}
//
//	public void setSize(long size) {
//		this.size = size;
//	}
//
//	@Override
//	public String toString() {
//		return "itemVO [path=" + path + ", basename=" + basename + ", type=" + type + ", mtime=" + mtime + ", size="
//				+ size + "]";
//	}
	
	
}
