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
		String email = request.getParameter("email");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String ssn = request.getParameter("ssn");
		boolean isEmployee = false;
		
		if(request.getParameter("employee") == null){
			System.out.println("Not Employee");
			isEmployee = false;
		}else{
			System.out.println("Employee");
			isEmployee = true;
		}
		
		boolean isAdmin = false;
		if(request.getParameter("admin") == null){
			System.out.println("Not admin");
			isAdmin = false;
		}else{
			System.out.println("Admin");
			isAdmin = true;
		}
		
		if(username.isEmpty() || password.isEmpty()){
			out.println("<div class=\"errorMessage\"> Please enter a non-empty username and password, redirecting to login page in 5 seconds </div>");
			if(isEmployee){
				response.setHeader("Refresh", "5;url=employeeLogin.jsp");
			}else{
				response.setHeader("Refresh", "5;url=login.jsp");
			}
			return;
		}
		
		//Login into database
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		System.out.println("Successfully connected to database");
		
		if(isEmployee){
			if(request.getParameter("create") != null){
				System.out.println("Create Button Pressed");
				System.out.println("Inserting " + username + " with password " + password);
				String insertString = "insert into Employee values (?, ?, ?, ?, ?);";
				System.out.println(insertString);
				PreparedStatement insertUser = con.prepareStatement(insertString);
				insertUser.setString(1, username);
				insertUser.setString(2, password);
				insertUser.setString(3, firstName);
				insertUser.setString(4, lastName);
				insertUser.setString(5, ssn);
				try{
					insertUser.executeUpdate();
				}catch(Exception e){
					System.out.println("ERROR: could not insert the new Customer into the customer table");
					System.out.println(e);
					out.println("<div class=\"errorMessage\"> Username is already taken or some error occurred, redirecting back to login page </div>");
					response.setHeader("Refresh", "5;url=employeeLogin.jsp");
					insertUser.close();
					con.close();
					System.out.println("Disconnected from database");
					return;
				}
				// Better practice would be to store an SESSIONID as part of the session 
				out.println("<div class=\"successMessage\"> Successfully created your account! click <a href='employeeLogin.jsp'>here</a> to go back to login form, automatically redirecting in 5 seconds </div>");
				response.setHeader("Refresh", "5;url=employeeLogin.jsp");
				insertUser.close();
			}else if(request.getParameter("login") != null){
				System.out.println("Login Button Pressed");
				
				Statement stmt = con.createStatement(); 
				String getUser = "select * from Employee where username = '" + username + "' and password = '" + password + "';";
				System.out.println(getUser);
				ResultSet users = stmt.executeQuery(getUser);
				if(users.next()){
					System.out.println("Succesfully found a user for this: redirecting to home page");
					session.setAttribute("username", username);
					session.setAttribute("password", password);
					session.setAttribute("role", "employee");
					response.sendRedirect("home.jsp");
				}else{
					System.out.println("No user found for the details entered, redirecting to login page");
					out.println("<div class=\"errorMessage\"> Invalid Credentials! Redirecting back to login page </div>");
					response.setHeader("Refresh", "5;url=employeeLogin.jsp");
				}
				System.out.println("Reached after login");
				users.close();
				stmt.close();
			}else{
				out.println("ERROR: please click <a href='employeeLogin.jsp'> here </a> to go back to login form.");
			}
		}else if(isAdmin == false){
			if(request.getParameter("create") != null){
				System.out.println("Create Button Pressed");
				System.out.println("Inserting " + username + " with password " + password);
				String insertString = "insert into Customer values (?, ?, ?, ?, ?);";
				System.out.println(insertString);
				PreparedStatement insertUser = con.prepareStatement(insertString);
				insertUser.setString(1, username);
				insertUser.setString(2, password);
				insertUser.setString(3, email);
				insertUser.setString(4, firstName);
				insertUser.setString(5, lastName);
				try{
					insertUser.executeUpdate();
				}catch(Exception e){
					System.out.println("ERROR: could not insert the new Customer into the customer table");
					System.out.println(e);
					out.println("<div class=\"errorMessage\"> Username is already taken or some error occurred, redirecting back to login page </div>");
					response.setHeader("Refresh", "5;url=login.jsp");
					insertUser.close();
					con.close();
					System.out.println("Disconnected from database");
					return;
				}
				// Better practice would be to store an SESSIONID as part of the session 
				out.println("<div class=\"successMessage\"> Successfully created your account! Click <a href='login.jsp'>here</a> to go back to login form, automatically redirecting in 5 seconds </div>");
				response.setHeader("Refresh", "5;url=login.jsp");
				insertUser.close();
			}else if(request.getParameter("login") != null){
				System.out.println("Login Button Pressed");
				
				Statement stmt = con.createStatement(); 
				String getUser = "select * from Customer where username = '" + username + "' and password = '" + password + "';";
				System.out.println(getUser);
				ResultSet users = stmt.executeQuery(getUser);
				if(users.next()){
					System.out.println("Succesfully found a user for this: redirecting to home page");
					session.setAttribute("username", username);
					session.setAttribute("password", password);
					session.setAttribute("role", "customer");
					response.sendRedirect("home.jsp");
				}else{
					System.out.println("No user found for the details entered, redirecting to login page");
					out.println("<div class=\"errorMessage\"> Invalid Credentials! Redirecting back to login page </div>");
					response.setHeader("Refresh", "5;url=login.jsp");
				}
				System.out.println("Reached after login");
				users.close();
				stmt.close();
			}else{
				out.println("ERROR: please click <a href='login.jsp'> here </a> to go back to login form.");
			}
		}else{
			System.out.println("Admin Login");
			Statement stmt = con.createStatement(); 
			String getUser = "select * from admin where username = '" + username + "' and password = '" + password + "';";
			System.out.println(getUser);
			ResultSet users = stmt.executeQuery(getUser);
			if(users.next()){
				System.out.println("Succesfully found a user for this: redirecting to home page");
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				session.setAttribute("role", "admin");
				response.sendRedirect("home.jsp");
			}else{
				System.out.println("No user found for the details entered, redirecting to login page");
				out.println("<div class=\"errorMessage\"> Invalid Credentials! Redirecting back to login page </div>");
				response.setHeader("Refresh", "5;url=adminLogin.jsp");
			}
			System.out.println("Reached after login");
			users.close();
			stmt.close();
		}

		con.close();
		System.out.println("Closed connection with database");
		
	}catch(Exception e){
		out.print(e);
		System.out.println("Failed to connect to database");
	}
	%>
</body>
</html>