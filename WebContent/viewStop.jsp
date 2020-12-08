<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Stops</title>
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
					Your session has expired, please <a href="employeeLogin.jsp">login</a> again. 
				</div>
			<% 	
				return;
			}
		%>
	</div>
	<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String query = "select * from Stop order by transitLineName DESC, trainID DESC;";
		PreparedStatement sortBy = con.prepareStatement(query);
		System.out.println(sortBy);
		try{
			ResultSet result = sortBy.executeQuery();
			%>
			<table class="fancyTable">	
			<caption> Stops </caption>
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>Stop number</th>
					<th>Stop Station ID</th>
					<th>Transit Line Name</th>
					<th>Train ID</th>
					<th>Origin Station ID</th>
					<th>Destination Station ID</th>
					<th>Arrival Time</th>
					<th>Departure Time</th>
					<th>Fare</th>
				</tr>
			</thead>
			<tbody>
			<% 
			while(result.next()){ %>
					<tr>
						<td> <%= result.getString("stopNumber") %></td>
						<td> <%= result.getString("stopStationID") %></td>
						<td> <%= result.getString("transitLineName") %></td>
						<td> <%= result.getString("trainID") %></td>
						<td> <%= result.getString("originStationID") %></td>
						<td> <%= result.getString("destinationStationID") %></td>
						<td> <%= result.getString("arrivalTime") %></td>
						<td> <%= result.getString("departTime") %></td>
						<td> <%= result.getString("fare") %></td>
					</tr>
		<%	}%>
			</tbody>
			</table> <% 
			result.close();
		}catch(Exception e){
			System.out.println("Query Failed!");
			System.out.println(e);
			out.println("Query Failed! Please retry");
		}
		System.out.println("Disconnecting from database");
		con.close();
	}catch(Exception e){
		System.out.println("Failed to connect to the database!");
		System.out.println(e);
		out.println("Failed to connect to the database, please retry!");
	}
	
	%>
	<div>
		<h2>
			Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>