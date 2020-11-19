<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Account Creation</title>
<link rel="stylesheet" href="login.css">
</head>

<body>
	<h1 class="title">
		Train Reservation System
	</h1>
	<div class="loginForm">
	  <form method="post" action="checkLoginDetails.jsp">
	  <h2>
	  	Employee Account 
	  	<br/>
	  	Creation
	  </h2>
      <p>
        Please fill out the form and click SIGN UP to create your employee account!
      </p>
      <label for="firstName">First Name</label>
      <input class="passwordForm" name="firstName" id="firstName" placeholder="First Name" maxlength="20" required/>
      <label for="lastName">Last Name</label>
      <input class="passwordForm" name="lastName" id="lastName" placeholder="Last Name" maxlength="20"  required/>
      <label for="username">Username</label>
      <input class ="usernameForm" name="username" id="username" placeholder="Username" maxlength="20"  required autofocus/>
      <label for="password">Password</label>
      <input type="password" class="passwordForm" name="password"  id="password" placeholder="Password" maxlength="20"  required/>
      <label for="ssn">SSN</label>
      <input class="passwordForm" name="ssn"  id="ssn" placeholder="XXXXXXXXX" maxlength="9" required/>
      <input style="display: none;" type="radio" name="employee" checked/>
			<div class="submitButton">
        	<button type="submit" name="create">
					Sign up
			</button>
			</div>
			To create or login to an employee account: please go <a href="employeeLogin.jsp">here</a>.
		</form>
		
	</div>
</body>
</html>