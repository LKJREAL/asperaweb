<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.aspera.web.vo.itemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<!--	<head>
		<title>ASPERA</title>
		<meta charset="utf-8">
   	 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="resources/reset.css">
-->    	
		
<!--  </head>
-->	
<!-- <body>  
-->	
    
	
<!-- <form action="<%=request.getContextPath() %>/login-send" method="POST" id="loginForm">
-->
<!-- <div style="background-image: url('resources/image/traffic_light_1920.jpg'); width: 100vw; height: 100vh; display:flex; justify-content:center; align-items: center;">
-->
<!-- 	<div style="background-image: url('resources/image/login_background.jpg'); border: 1px solid black; width: 100vw; height: 100vh;"> -->
		
		
		
<head>
  <title>로그인</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="resources/loginBtn.css">
  <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
</head>
<body>
  <div class="login-form">
    <form action="<%=request.getContextPath() %>/login-send" method="POST" id="loginForm">
    
      <input type="text" name="id" id="id" class="text-field" placeholder="아이디">         
      <input name="id" id="id" class="text-field" placeholder="아이디">
      
      <input type="password" name="password" class="text-field" placeholder="비밀번호">
<!--  <input type="button" id="submitButton" value="로그인" class="submit-btn"> 
 -->
      <input type="submit" id="submitButton" value="로그인" class="submit-btn">
      
    </form>
 
 <!-- <div class="links">
      <a href="#">비밀번호를 잊어버리셨나요?</a>
    </div>
 -->
    </div>
</body>
		
<!-- 			<div style="border:1px solid black;width: 450px; height: 220px; background-color: #B2C7D9; display:flex; justify-content:center; align-items: center;">
				<div style="">
					<div style="margin:5px;">
						<span>id:</span>
						<input name="id" id="id"></input>
					</div>
					<div style="margin:5px;">
						<span>password:</span>
						<input id="password" name="password" type="password"></input>
					</div>
					<div style="margin:5px;">
						<button type="button" id="submitButton">Login</button>
					</div>
				</div>
			</div> 
-->
			
	
<!-- </div>
 -->
<!--  	</form>
 -->
	
<!--  </body>
-->	
	
</html>

<script>

document.addEventListener("DOMContentLoaded", function(event) {
	
	setTimeout(() => {
		  console.log("Delayed for 1 second.");
		  
		    // Your code to run since DOM is loaded and ready
		    let loginResult = <%= request.getAttribute("result") %>
			if( loginResult === -1 ) {
				alert("Password Error!. Please login Again.");
			}
			
		}, "1000");
		

});

document.getElementById("submitButton").addEventListener("click", function(event){
	  event.preventDefault();
	  if( document.getElementById("id").value === "" ||  document.getElementById("password").value === "" ) {
		  alert("please enter id or password");
		  return false;
	  } else {
		  document.getElementById("loginForm").submit();
	  }
	  
});





</script>