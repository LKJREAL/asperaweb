<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.aspera.web.vo.itemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
	<head>
		<title>ASPERA by KJLEE</title>
		<meta charset="utf-8">
   	 	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="resources/reset.css">
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
		<script type="text/javascript" src="//d3gcli72yxqn2z.cloudfront.net/connect/v4/asperaweb-4.min.js"></script>
		<script type="text/javascript" src="//d3gcli72yxqn2z.cloudfront.net/connect/v4/connectinstaller-4.min.js"></script>
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/style.css" type="text/css">
	
		
	</head>

	<body>
		
		<div style="position:absolute;top:30%;left:50%;transform:translate(-50%, -50%); width: 550px; height: 300px; border: 1px solid black;display:flex;flex-direction:column; ">
			<div id="header" style="height:30px;background-color:#6C6CAA;"></div>
			<div id="body" style="flex:1; background-color:white;">
				<div id="inner" style="padding:5px 10px;border: 1px solid black;height: 100%; display:flex;flex-direction:column;">
					<div style="height: 30px; margin:5px;border: 1px solid black; display:flex;">
						<div style="width: 90px; height:30px;border: 1px solid black;line-height:30px;text-align:center;">전체 전송</div>
						<div style="flex: 1;"></div>
					</div>
					<div style="height: 60px;margin:5px;border: 1px solid black;"></div>
					<div style="flex: 1;margin:5px;border: 1px solid black;"></div>
				</div>
			</div>
			<div id="bottom" style="height:30px;border: 1px solid black; background-color:white;"></div>
			
		</div>
	</body>
</html>

<script>


</script>


