<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

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
	<%
	try{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(username.isEmpty() || password.isEmpty()){
			out.println("<div class=\"errorMessage\"> Please enter a non-empty username and password, redirecting to login page in 5 seconds </div>");
			response.setHeader("Refresh", "5;url=login.jsp");
			return;
		}
		
		//Login into database
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		System.out.println("Successfully connected to database");
		
		if(request.getParameter("create") != null){
			System.out.println("Create Button Pressed");
			// Should probably hash the password and salt it for security 
			System.out.println("Inserting " + username + " with password " + password);
			String insertString = "insert into user values (?, ?, ?);";
			PreparedStatement insertUser = con.prepareStatement(insertString);
			insertUser.setString(1, username);
			insertUser.setString(2, password);
			insertUser.setString(3, "default");
			try{
				insertUser.executeUpdate();
			}catch(Exception e){
				System.out.println("Error inserting the user");
				System.out.println(e);
				out.println("<div class=\"errorMessage\"> Username is already taken or some error occurred, redirecting back to login page </div>");
				response.setHeader("Refresh", "5;url=login.jsp");
				insertUser.close();
				con.close();
				System.out.println("Disconnected from database");
				return;
			}
			// Better practice would be to store an SESSIONID as part of the session 
			out.println("<div class=\"successMessage\"> Successfully created your account, click <a href='login.jsp'>here</a> to go back to login form, automatically redirecting in 5 seconds </div>");
			response.setHeader("Refresh", "5;url=login.jsp");
			insertUser.close();
		}else if(request.getParameter("login") != null){
			System.out.println("Login Button Pressed");
			
			Statement stmt = con.createStatement(); 
			String getUser = "select * from user where username = '" + username + "' and password = '" + password + "';";
			ResultSet users = stmt.executeQuery(getUser);
			if(users.next()){
				System.out.println("Succesfully found a user for this: redirecting to home page");
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				response.sendRedirect("home.jsp");
			}else{
				System.out.println("No user found for the details entered, redirecting to login page");
				out.println("<div class=\"errorMessage\"> Invalid Credentials, redirecting back to login page </div>");
				response.setHeader("Refresh", "5;url=login.jsp");
			}
			System.out.println("Reached after login");
			users.close();
			stmt.close();
		}else{
			out.println("ERROR: please click <a href='login.jsp'> here </a> to go back to login form.");
		}
		con.close();
		System.out.println("Closed connection with database");
	}catch(Exception e){
		out.print(e);
		System.out.print("Failed to connect to database");
	}
	%>
</body>
</html>