<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Station Creation</title>
<link rel="stylesheet" href="home.css">
</head>
<body>
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
					Your session has expired, please <a href="employeeLogin.jsp">login</a> again. 
				</div>
			<% 	
				return;
			}
		%>
	</div>
	
	<h1 class="title">
		Train Reservation System
	</h1>
	<%
	String stationIds = (String) request.getParameter("stationID");
	String stationNames = (String) request.getParameter("stationName");
	String states = (String) request.getParameter("state");
	String cities = (String) request.getParameter("city");
	String[] stationId = stationIds.split(",");
	String[] stationName = stationNames.split(",");
	String[] state = states.split(",");
	String[] city = cities.split(",");
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String insert = "insert into Station values (?, ?, ?, ?);";
		PreparedStatement insertUser = con.prepareStatement(insert);
		
		for(int i = 0; i < stationId.length; i++){
			insertUser.setInt(1, Integer.valueOf(stationId[i]));
			insertUser.setString(2, stationName[i]);
			insertUser.setString(3, state[i]);
			insertUser.setString(4, city[i]);
			System.out.println(insertUser);
			try{
				insertUser.executeUpdate();
			}catch(Exception e){
				System.out.println("Failed to insert " + stationId[i] + " " + stationName[i] + " " + state[i] + " " + city[i]);
				System.out.println(e);
			}
		}
		System.out.println("Disconnecting from database");
		insertUser.close();
		con.close();
	}catch(Exception e){
		out.println("<div class=\"errorMessage\"> Could not connect to the database </div>");
		System.out.println(e);
	}%>
	<div>
		<h2>
			Successfully inserted all the station data! Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
