package com.aspera.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aspera.web.service.asperaService;
import com.aspera.web.vo.itemVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
//	@Autowired
//	private asperaService asperaService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginPage(Model model) {	
//		model.addAttribute("self", self);
//		model.addAttribute("list", list);

		return "login";
	}
	
	@RequestMapping(value = "/login-send", method = RequestMethod.POST)
	public String login(Model model, HttpServletRequest request, HttpServletResponse response) {
		String id = (String)request.getParameter("id");
		String password = (String)request.getParameter("password");
		//
		if( "aspera".equals(id) && "1".equals(password)) {
//			StringBuilder sb = asperaService.files("browse", "/", null);
//			
//			List<itemVO> list = asperaService.browseParse(sb.toString());
//			itemVO self = list.remove(0);
//			model.addAttribute("self", self);
//			model.addAttribute("list", list);
//			
//			return "home";
			
		
//				request.getRequestDispatcher("aspera").forward(request, response);

			HttpSession session = request.getSession();
			session.setAttribute("userid", id);
			
			//return "redirect:/";
			return "forward:/";

		} else {
			model.addAttribute("result", -1); // -1 : password error, -2: user not found
			return "login";

		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "/login";
	}
	
}
