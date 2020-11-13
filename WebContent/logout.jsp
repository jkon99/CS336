<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logout</title>
<link rel="stylesheet" href="logout.css">
</head>
<body>
	<%
		System.out.println("Invaliding the session for this user (FROM SERVER)");
		session.invalidate();
		response.setHeader("Refresh", "5;url=login.jsp");
	%>
	<h1 class="title">
	    Train Reservation System
	</h1>
	<div class="successMessage">
	    Successfully logged out, automatically redirecting to login page in 5 seconds! 
	</div>
	<p>
	  Login again <a href='login.jsp'>here</a>.
  	</p>
</body>
</html>