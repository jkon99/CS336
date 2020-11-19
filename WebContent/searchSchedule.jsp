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
	String originStationID = (String) request.getParameter("originStationID");
	String destinationStationID = (String) request.getParameter("destinationStationID");
	String departTime = (String) request.getParameter("travelDatetime");

	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String insert = "select * from Schedule where originStationID = ? and destinationStationID = ? and departDatetime = ?;";
		PreparedStatement insertUser = con.prepareStatement(insert);
		ArrayList<String> transitLineNames = new ArrayList<String>();
		try{
			insertUser.setString(1, originStationID);
			insertUser.setString(2, destinationStationID);
			insertUser.setString(3, departTime);
			ResultSet result = insertUser.executeQuery(); 
			%>
			<table class="fancyTable">	
			<caption>Train Schedules</caption>
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>Transit Line Name</th>
					<th>Train ID</th>
					<th>Origin Station ID</th>
					<th>Destination Station ID</th>
					<th>Arrival Datetime</th>
					<th>Departure Datetime</th>
					<th>Trip Type</th>
					<th>Total Fare</th>
				</tr>
			</thead>
			<tbody>
			<% 
			while(result.next()){ %>
					<% transitLineNames.add(result.getString("transitLineName")); %>
					<tr>
						<td> <%= result.getString("transitLineName") %></td>
						<td> <%= result.getString("trainID") %></td>
						<td> <%= result.getString("originStationID") %></td>
						<td> <%= result.getString("destinationStationID") %></td>
						<td> <%= result.getString("arrivalDatetime") %></td>
						<td> <%= result.getString("departDatetime") %></td>
						<td> <%= result.getString("tripType") %></td>
						<td> <%= result.getString("fixedFare") %></td>
					</tr>
		<%	}%>
			</tbody>
			</table> <% 
			result.close();
		}catch(Exception e){
			System.out.println("Something went wrong with the query");
			System.out.println(e);
		}
		insert = "select * from Stop where originStationID = ? and destinationStationID = ? and transitLineName = ?;";
		insertUser = con.prepareStatement(insert);
		for(String transitLineName : transitLineNames){
			insertUser.setString(1, originStationID);
			insertUser.setString(2, destinationStationID);
			insertUser.setString(3, transitLineName);
			try{
				ResultSet result = insertUser.executeQuery();
				%>
				<table class="fancyTable">	
				<caption> <%= transitLineName %></caption>
				<colgroup>
					<col>
					<col>
					<col>
				</colgroup>
				<thead>
					<tr>
						<th>Stop Station ID</th>
						<th>Transit Line Name</th>
						<th>Train ID</th>
						<th>Origin Station ID</th>
						<th>Destination Station ID</th>
						<th>Arrival Time</th>
						<th>Departure Time</th>
						<th>Stop number</th>
						<th>Fare</th>
					</tr>
				</thead>
				<tbody>
				<% 
				while(result.next()){ %>
						<tr>
							<td> <%= result.getString("stopStationID") %></td>
							<td> <%= result.getString("transitLineName") %></td>
							<td> <%= result.getString("trainID") %></td>
							<td> <%= result.getString("originStationID") %></td>
							<td> <%= result.getString("destinationStationID") %></td>
							<td> <%= result.getString("arrivalTime") %></td>
							<td> <%= result.getString("departTime") %></td>
							<td> <%= result.getString("stopNumber") %></td>
							<td> <%= result.getString("fare") %></td>
						</tr>
			<%	}%>
				</tbody>
				</table> <% 
				result.close();
			}catch(Exception e){
				System.out.println("Something went wrong with the query");
				System.out.println(e);
			}
		}
		
		insertUser.close();
		System.out.println("Disconnecting from database");
		con.close();
	}catch(Exception e){
		out.println("<div class=\"errorMessage\"> Could not connect to the database </div>");
		System.out.println(e);
	}%>
	<div>
		<h2>
			Successfully retrieved all the schedule data! Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
