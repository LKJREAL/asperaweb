package com.aspera.web.controller;

import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aspera.web.service.asperaService;
import com.aspera.web.vo.itemVO;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	@Autowired
	private asperaService asperaService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {
		// login check
//		if( session.getAttribute("userid") == null ) {
//			return "login";
//		}
		StringBuilder sb = null;
		if(request.getParameter("current") != null) {
			String current = request.getParameter("current");
			log.warn("current:"+current);
			sb = asperaService.files("browse", current, null);
		} else {
			sb = asperaService.files("browse", "/", null); // aspera file server post call
		}
		
		List<itemVO> list = asperaService.browseParse(sb.toString());
		itemVO self = list.remove(0);
		model.addAttribute("self", self);
		model.addAttribute("list", list);
//		String transferSpec =
//				"{ \"direction\": \"receive\", \"remote_host\": \"115.71.42.22\", \"remote_user\": \"asperatest\", \"remote_password\": \"rootroot\", \"cipher\": \"none\", \"http_fallback\": \"true\", \"http_fallback_port\": 8080, \"rate_policy\": \"fair\", \"fasp_port\": 33001, \"ssh_port\": 33001, \"lock_min_rate\": \"false\", \"lock_policy\": \"false\", \"lock_target_rate\": \"false\", \"min_rate_kbps\": 0, \"target_rate_kbps\": 1000000 }";
//		model.addAttribute("transferSpec", transferSpec);
		return "home";
	}

	// later we can change way of AJAX by call AJAX way (or entire call as below)

	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String homeForPost(Model model, HttpServletRequest request, RedirectAttributes rttr) {
		String api = null;
		String current = null;
		String target = null;
		StringBuilder sb = null;
		String [] temp = null;
		
		if(request.getParameter("api") != null) {
			api = (String)request.getParameter("api");
			if(request.getParameter("current") != null) {
				current = (String)request.getParameter("current");
			}
			if(request.getParameter("target") != null) {
				target = (String)request.getParameter("target");
				temp = target.split(",");
			}
			sb = asperaService.files(api, current, temp);
		} else {
			sb = asperaService.files("browse", "/", null);
			api = "browse";
		}
		
		if(!api.equals("browse")) {
			sb = asperaService.files("browse", current, null);
		}else {
			List<itemVO> list = asperaService.browseParse(sb.toString());
			itemVO self = list.remove(0);
			model.addAttribute("self", self);
			model.addAttribute("list", list);
		}

//		String transferSpec =
//				"{ \"direction\": \"receive\", \"remote_host\": \"115.71.42.22\", \"remote_user\": \"asperatest\", \"remote_password\": \"rootroot\", \"cipher\": \"none\", \"http_fallback\": \"true\", \"http_fallback_port\": 8080, \"rate_policy\": \"fair\", \"fasp_port\": 33001, \"ssh_port\": 33001, \"lock_min_rate\": \"false\", \"lock_policy\": \"false\", \"lock_target_rate\": \"false\", \"min_rate_kbps\": 0, \"target_rate_kbps\": 1000000 }";
//		model.addAttribute("transferSpec", transferSpec);

		//System.out.println("self:"+self);
		//System.out.println("list:"+list);

		//rttr.addAttribute("self", self);
		//rttr.addAttribute("list", list);


//		return "home";
//		if(api.equals("browse")) {
//			return "redirect:/?current=" + current + target;
//		} else{
//			return "redirect:/?current=" + current;
//		}
		if(!api.equals("browse")) {
			return "redirect:/?current=" + current;
		} else {
			return "home";
		}
		//return "forward:/";
		//return new ModelAndView("redirect:/");
	}
	
}
