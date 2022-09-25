<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.aspera.web.vo.itemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
    	<head>
		<title>ASPERA</title>
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1">


            <!--<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstraplogin.css" type="text/css"> -->
     <!--   <link rel="stylesheet" href="/resources/bootstraplogin.css" > -->
<!--        <script type="text/javascript" src="/resources/lib/bootstrap.bundle.min.js"></script> -->
<!--            <script src="${pageContext.request.contextPath}/resources/lib/bootstrap.bundle.min.js"  integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/bootstraplogin.css" >
-->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/bootstraplogin.css" >


        </head>
	
<body>  

    
	
 <!--<form action="<%=request.getContextPath() %>/login-send" method="POST" id="loginForm">-->


     <section class="h-100 gradient-form" style="background-color: #eee;">
         <div class="container py-5 h-100">
             <div class="row d-flex justify-content-center align-items-center h-100">
                 <div class="col-xl-10">
                     <div class="card rounded-3 text-black">
                         <div class="row g-0">
                             <div class="col-lg-6">
                                 <div class="card-body p-md-5 mx-md-4">

                                     <div class="text-center">
                                         <img src="/resources/image/asperalogo.png"
                                              style="width: 300px;" alt="logo">

                                         <!--<img src="/resources/image/asperalogo.png"
                                              style="width: 185px height: 250px;" alt="logo">
-->


                                         <h4 class="mt-1 mb-5 pb-1">Welcome to IBM Aspera world</h4>
                                     </div>

                                     <form action="<%=request.getContextPath() %>/login-send" method="POST" id="loginForm">
                                         <p>Please login to your account</p>

                                         <div class="form-outline mb-4">
<!--                                             <input type="email" id="form2Example11" class="form-control"
                                                    placeholder="Phone number or email address" />
-->
                                             <input type="text" name="id" id="id" class="form-control"
                                                    placeholder="name for Aspera" />


                                             <label class="form-label" for="form2Example11">Username</label>
                                         </div>

                                         <div class="form-outline mb-4">
                                         <!--<input type="password" id="form2Example22" class="form-control" /> -->

                                             <input type="password" name="password" id="password" class="form-control"
                                                    placeholder="password for Aspera" />

                                             <label class="form-label" for="form2Example22">Password</label>
                                         </div>

                                         <div class="text-center pt-1 mb-5 pb-1">
<!--                                             <button class="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3" type="button">Log
                                                 in</button>
-->
                                             <input class="btn btn-success form-control btn-block fa-lg gradient-custom-2 mb-3"
                                                    type="submit" id="submitButton" value="LOG IN">
                                                 Click</input>

<!--                                             <input class="submit-btn" type="submit" id="submitButton" value=""LOG IN" aria-label="LOG_IN">Click</input>
-->


                                             <a class="text-muted" href="#!">Forgot password?</a>
                                         </div>

                                         <div class="d-flex align-items-center justify-content-center pb-4">
                                             <p class="mb-0 me-2">Don't have an account? Send email!</p>
                                             <button type="button" class="btn btn-outline-danger">lkjreal@gmail.com</button>
                                         </div>

                                     </form>

                                 </div>
                             </div>
                             <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                                 <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                                     <h4 class="mb-4">We are more than just Tech Guys</h4>
                                     <p class="small mb-0">Wherever we took upon this earth,
                                         the opportunities take shape within the problems.
                                         You are what you repeatedly do.
                                         Excellence is not an event it is a habit.</p>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </section>


<!--</form>-->

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