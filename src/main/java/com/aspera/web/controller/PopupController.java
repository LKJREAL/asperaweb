package com.aspera.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
public class PopupController {

	
	@RequestMapping(value = "/transfer-popup", method = RequestMethod.GET)
	public String transferPopup(Model model, HttpSession session) {
		

		return "transfer-popup";
	}
	
}
