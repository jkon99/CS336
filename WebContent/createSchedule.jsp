<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedule Creation</title>
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
	/*
	<label for="transitLineName">Transit Line Name</label>
	<input id="transitLineName" name="transitLineName" required/>
	<label for="trainID">Train ID</label>
	<input id="trainID" name="trainID" required/>
	<label for="originStationID">Origin Station ID</label>
	<input id="originStationID" name="originStationID" required/>
	<label for="destinationStationID">Destination Station ID</label>
	<input id="destinationStationID" name="destinationStationID" required/>
	<label for="departTime">Depart Time</label>
	<input id="departTime" name="departTime" required/>
	<label for="arrivalTime">Arrival Time</label>
	<input id="arrivalTime" name="arrivalTime" required/>
	<label for="tripType">Trip Type</label>
	<input id="tripType" name="tripType" required/>
	<label for="fixedFare">fixedFare</label>
	<input id="fixedFare" name="fixedFare" required/>
					*/
	
	String transitLineNames = (String) request.getParameter("transitLineName");
	String trainIDs = (String) request.getParameter("trainID");
	String originStationIDs = (String) request.getParameter("originStationID");
	String destinationStationIDs = (String) request.getParameter("destinationStationID");
	String departTimes = (String) request.getParameter("departTime");
	String arrivalTimes = (String) request.getParameter("arrivalTime");
	String tripTypes = (String) request.getParameter("tripType");
	String fixedFares = (String) request.getParameter("fixedFare");
	
	String[] transitLineName = transitLineNames.split(",");
	String[] trainID = trainIDs.split(",");
	String[] originStationID = originStationIDs.split(",");
	String[] destinationStationID = destinationStationIDs.split(",");
	String[] departTime = departTimes.split(",");
	String[] arrivalTime = arrivalTimes.split(",");
	String[] tripType = tripTypes.split(",");
	String[] fixedFare = fixedFares.split(",");
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String insert = "insert into Schedule values (?, ?, ?, ?, ?, ?, ?, ?);";
		PreparedStatement insertUser = con.prepareStatement(insert);
		
		for(int i = 0; i < transitLineName.length; i++){
			insertUser.setString(1, transitLineName[i]);
			insertUser.setInt(2, Integer.valueOf(trainID[i]));
			insertUser.setInt(3, Integer.valueOf(originStationID[i]));
			insertUser.setInt(4, Integer.valueOf(destinationStationID[i]));
			insertUser.setString(5, arrivalTime[i]);
			insertUser.setString(6, departTime[i]);
			insertUser.setString(7, tripType[i]);
			insertUser.setDouble(8, Double.valueOf(fixedFare[i]));
			System.out.println(insertUser);
			try{
				insertUser.executeUpdate();
			}catch(Exception e){
				System.out.println("Failed to insert " + transitLineName[i] + " " + trainID[i] + " " + originStationID[i] + " " + destinationStationID[i] + " " + arrivalTime[i] + " " + departTime[i] + " " + tripType[i] + " " + fixedFare[i]);
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
			Successfully inserted all the schedule data! Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
