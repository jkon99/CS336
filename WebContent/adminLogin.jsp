<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Login Page</title>
<link rel="stylesheet" href="login.css">
</head>

<body>
	<h1 class="title">
		Train Reservation System
	</h1>
	<div class="loginForm">
	  <form method="post" action="checkLoginDetails.jsp">
	  <h2>
	  	Admin Login
	  </h2>
      <h2>
        One Account. <br/>
        All the Train Data.
      </h2>
      <p>
        Login to access your account. <br/>
        If you would like to create an admin account, please use the Database.
      </p>
      
      <label for="username">Username</label>
      <input class ="usernameForm" name="username" id="username" placeholder="Username" required autofocus/>
      <label for="password">Password</label>
      <input type="password" class="passwordForm" name="password"  id="password" placeholder="Password" required/>
			<div class="submitButton">
				<button type="submit" name="login" >
					Login
				</button> 
			</div>
			<input style="display: none;" type="radio" name="admin" checked/>
			To create or login to an customer account: please go <a href="login.jsp">here</a>.
			<br/>
			To create or login to an employee account: please go <a href="employeeLogin.jsp">here</a>.
		</form>
		
	</div>
</body>
</html>