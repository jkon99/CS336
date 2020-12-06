<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reservation Creation</title>
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
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String query = "select * from Schedule order by tripType;";
		Statement stmt = con.createStatement(); 
		try{
			ResultSet result = stmt.executeQuery(query); 
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
			System.out.println("Query Failed!");
			System.out.println(e);
			out.println("Query Failed! Please retry");
		}
		%>
		<div>
			<h2>
				Active Reservations
			</h2>
		<%
			query = "select * from Reservation where active=true and username='" + session.getAttribute("username") + "';";
			System.out.println(query);
			try{
				ResultSet result = stmt.executeQuery(query);
				%>
				<table class="fancyTable">	
				<caption>Active Reservations</caption>
				<colgroup>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
				</colgroup>
				<thead>
					<tr>
						<th>Reservation ID</th>
						<th>Reservation Date</th>
						<th>Username</th>
						<th>Transit Line Name</th>
						<th>Train ID</th>
						<th>Origin Station ID</th>
						<th>Destination Station ID</th>
						<th>Depart Time</th>
						<th>Depart Date</th>
						<th>Total Fare</th>
						<th>Active</th>
					</tr>
				</thead>
				<tbody>
				<% 
				while(result.next()){ %>
						<tr>
							<td> <%= result.getString("reservationNumber") %></td>
							<td> <%= result.getString("reservationDate") %></td>
							<td> <%= result.getString("username") %></td>
							<td> <%= result.getString("transitLineName") %></td>
							<td> <%= result.getString("trainID") %></td>
							<td> <%= result.getString("originStationID") %></td>
							<td> <%= result.getString("destinationStationID") %></td>
							<td> <%= result.getString("departureTime") %></td>
							<td> <%= result.getString("departureDate") %></td>
							<td> <%= result.getString("totalFare") %></td>
							<td> <%= result.getString("active") %></td>
						</tr>
			<%	}%>
				</tbody>
				</table> <% 
				result.close();
			}catch(Exception e){
				System.out.println(e);
				System.out.println("Query Failed");
				out.println("Query failed! Please try again");
			}
		%>
		</div>
		<% 
		stmt.close();
		System.out.println("Disconnecting from database");
		con.close();
	}catch(Exception e){
		System.out.println("Could not connect to database");
		System.out.println(e);
		out.println("Could not connect to database");
	}
	
	%>
	<div>
		<h2>
			Create Reservation
		</h2>
		<form method="post" action="createReservationHelper.jsp">
			<div class="flex-container">
				<span>
					<label for="transitName">Transit Line Name</label>
					<input id="transitName" name="transitName" required/>
				</span>
				<span>
					<label for="trainID">Train ID</label>
					<input id="trainID" name="trainID" required/>
				</span>
				<span>
					<label for="originStationID">Origin Station ID</label>
					<input id="originStationID" name="originStationID" required/>
				</span>
				<span>
					<label for="destinationStationID">Destination Station ID</label>
					<input id="destinationStationID" name="destinationStationID" required/>
				</span>
				<span>
					<label for="disabled"> None </label>
					<input id="disabled" type="radio" name="discount" value="none" checked/>
				</span>
				<span>
					<label for="child"> Senior</label>
					<input id="child" type="radio" name="discount" value="senior"/>
				</span>
				<span>
					<label for="child"> Child </label>
					<input id="child" type="radio" name="discount" value="child"/>
				</span>
				<span>
					<label for="disabled"> Disabled</label>
					<input id="disabled" type="radio" name="discount" value="disable"/>
				</span>
				<button type="submit"> Create </button>
			</div>
		</form>
	</div>
	<div>
		<h2>
			Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
