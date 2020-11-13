<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Train Reservation Login Page</title>
<link rel="stylesheet" href="login.css">
</head>

<body>
	<h1 class="title">
		Train Reservation System
	</h1>
	<div class="loginForm">
	  <form method="post" action="checkLoginDetails.jsp">
      <h2>
        One Account. <br/>
        All the Train Data.
      </h2>
      <p>
        Login to access your account or create your account by filling out the form and selecting SIGN UP.
      </p>
      Username 
      <br/>
      <input class ="usernameForm" name="username" placeholder="Username" required autofocus/>
	  <br/>
	  Password
      <br/>
      <input type="password" class="passwordForm" name="password" placeholder="Password" required/>
			<br/>
			<div class="submitButton">
				<button type="submit" name="login" >
					Login
				</button> 
        <button type="submit" name="create">
					Sign up
				</button>
			</div>
		</form>
	</div>
</body>
</html>