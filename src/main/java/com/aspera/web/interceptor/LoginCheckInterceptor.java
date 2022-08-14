package com.aspera.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
    Logger log = LoggerFactory.getLogger(this.getClass().getName());
	
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { 
	  String uri = request.getRequestURI().toString().trim();
      // uri.startWith(request.getContextPath()+"/resources")
	  if (uri.indexOf("/login") > -1 || uri.indexOf("/resources") > -1){
          return true; // bypass
      } 
	  
      HttpSession session  = request.getSession(false);
      if(session == null) {
          log.info("=============== session is null!!! ===========");
          response.sendRedirect(request.getContextPath()+"/login");
          return false;
      }

      String userid = (String)session.getAttribute("userid");
      if (userid == null) {
          log.info("=============== user id is null!!! ===========");
          response.sendRedirect(request.getContextPath()+"/login");
          return false;
      }
      return true;  
  }
  
}