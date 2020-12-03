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
	<h1 class="title">
	    Train Reservation System
	</h1>
	<div>
		<% 
		try{
			System.out.println("Testing Session");
			session.getAttribute("username").equals("");
			}catch(Exception e){ 
				System.out.println("Invalid Session");
				System.out.println(e);
			%>	
				<div class="errorMessage">
					Your session has expired, please <a href="login.jsp">login</a> again. 
				</div>
			<% 	
				return;
			}
		%>
	</div>
	<%
		System.out.println("Invaliding the session for this user (FROM SERVER)");
		String role = (String) session.getAttribute("role");
		session.invalidate();
		if(role.equals("employee")){
			response.setHeader("Refresh", "5;url=employeeLogin.jsp");
		}else if(role.equals("admin")){
			response.setHeader("Refresh", "5;url=adminLogin.jsp");
		}else{
			response.setHeader("Refresh", "5;url=login.jsp");
		}
		
	%>
	<div class="successMessage">
	    Successfully logged out, automatically redirecting to login page in 5 seconds! 
	</div>
	<p>
	  Customer Login <a href='login.jsp'>here</a>.
  	</p>
  	<p>
  	  Employee Login <a href='employeeLogin.jsp'>here</a>.
  	</p>
  	<p>
  	 Admin Login <a href='adminLogin.jsp'>here</a>.
  	</p>
</body>
</html>