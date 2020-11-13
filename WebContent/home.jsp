<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Train Reservation Home Page</title>
<link rel="stylesheet" href="home.css">
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
		<form action="logout.jsp" method="post">
			<button class="logout">Logout</button>
		</form>
		<p class="loggedin">
		Logged in as <%= session.getAttribute("username")%>
		</p>
	</div>
		<% if(((String) session.getAttribute("username")).toLowerCase().equals("admin")){ %>
			<p>Fetching all username and passwords for ADMIN</p>
			<%
			try{
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				String getAllLogins = "select * from user;";
				Statement stmt = con.createStatement();
				ResultSet users = stmt.executeQuery(getAllLogins); %>
				<table class="fancyTable">	
						<caption>Login details of all users</caption>
						<colgroup>
							<col>
							<col>
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>Username</th>
								<th>Password</th>
								<th>Access Level</th>
							</tr>
						</thead>
						<tbody>
						<% 
				while(users.next()){ %>
						<tr>
							<td class="username"> <%= users.getString("username") %></td>
							<td class="password"> <%= users.getString("password") %></td>
							<td> <%= users.getString("role") %></td>
						</tr>
			<%	}%>
				</tbody>
				</table> <% 
				System.out.println("Closing all connections to db");
				users.close();
				stmt.close();
				con.close();
			}catch(Exception e){
				System.out.println("Connection Failed or some error occurred while fetching all users");
				System.out.println(e);
			}
			%>
			
		<% }else{
			
		} %> 
	
</body>
</html>