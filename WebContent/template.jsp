<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Train Creation</title>
<link rel="stylesheet" href="login.css">
</head>
<body>
	<h1 class="title">
		Train Reservation System
	</h1>
	<%
		String stopsInfo = (String) request.getParameter("stopNames");
		String schedulesInfo = (String) request.getParameter("stopNames");
	%>
</body>
</html>