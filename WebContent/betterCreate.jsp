<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Better Create</title>
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
		String query = "select * from Train;";
		PreparedStatement insertUser = con.prepareStatement(query);
		try{
			ResultSet result = insertUser.executeQuery();
			%>
			<table class="fancyTable">	
			<caption> <%= "Trains" %></caption>
			<colgroup>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>TrainID</th>
				</tr>
			</thead>
			<tbody>
			<% 
			while(result.next()){ %>
					<tr>
						<td> <%= result.getString("trainID") %></td>
					</tr>
		<%	}%>
			</tbody>
			</table> <% 
			result.close();
		}catch(Exception e){
			System.out.println("Something went wrong with the Train query");
			System.out.println(e);
		}
		
		query = "select * from Station;";
		insertUser = con.prepareStatement(query);
		try{
			ResultSet result = insertUser.executeQuery();
				%>
				<table class="fancyTable">	
				<caption> <%= "Stations" %></caption>
				<colgroup>
					<col>
					<col>
					<col>
					<col>
				</colgroup>
				<thead>
					<tr>
						<th>Station ID</th>
						<th>Station Name</th>
						<th>State</th>
						<th>City</th>
					</tr>
				</thead>
				<tbody>
				<% 
				while(result.next()){ %>
						<tr>
							<td> <%= result.getString("stationID") %></td>
							<td> <%= result.getString("stationName") %></td>
							<td> <%= result.getString("state") %></td>
							<td> <%= result.getString("city") %></td>
						</tr>
			<%	}%>
				</tbody>
				</table> <% 
				result.close();
		}catch(Exception e){
			System.out.println("Something went wrong with the Station query");
			System.out.println(e);
		}
		query = "select * from Schedule;";
		insertUser = con.prepareStatement(query);
		try{ 
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
			System.out.println("Something went wrong with the Schedule query");
			System.out.println(e);
		}
		query = "select * from Stop order by stopNumber ASC, stopStationID ASC, transitLineName, trainID ASC, originStationID ASC, destinationStationID ASC;";
		insertUser = con.prepareStatement(query);
		try{
			ResultSet result = insertUser.executeQuery();
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
			System.out.println("Something went wrong with the Stop query");
			System.out.println(e);
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
			Create Trains
		</h2>
		<form method="post" action="createTrain.jsp">
			<div class="flex-container">
				<span>
					<label for="trains">Train ID</label>
					<input id="trainID" name="trainID" required/>
				</span>
				<button type="submit"> Create </button>
			</div>
		</form>
		<h2>
			Create Stations
		</h2>
		<form method="post" action="createStation.jsp">
			<div class="flex-container">
				<span>
					<label for="stationID">Station ID</label>
					<input id="stationID" name="stationID" required/>
				</span>
				<span>
					<label for="stationName">Station Name</label>
					<input id="stationName" name="stationName" required/>
				</span>
				<span>
					<label for="state">State</label>
					<input id="state" name="state" required/>
				</span>
				<span>
					<label for="city">City</label>
					<input id="city" name="city" required/>
				</span>
				<button type="submit"> Create </button>
			</div>
		</form>
		<div>
			<h2>
			Create Schedules
			</h2>
			<form method="post" action="createSchedule.jsp">
				<div class="flex-container">
					<span>
						<label for="transitLineName">Transit Line Name</label>
						<input id="transitLineName" name="transitLineName" required/>
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
						<label for="arrivalTime">Arrival Time</label>
						<input id="arrivalTime" name="arrivalTime" placeholder="YYYY-MM-DD hh:mm:ss" required/>
					</span>
					<span>
						<label for="departTime">Depart Time</label>
						<input id="departTime" name="departTime" placeholder="YYYY-MM-DD hh:mm:ss" required/>
					</span>
					<span>
						<label for="tripType">Trip Type</label>
						<input id="tripType" name="tripType" required/>
					</span>
					<span>
						<label for="fixedFare">fixedFare</label>
						<input id="fixedFare" name="fixedFare" required/>
					</span>
					<button type="submit"> Create </button>
				</div>
			</form>
		</div>
		<div>
			<h2>
				Create Stops
			</h2>
			<form method="post" action="createStop.jsp">
				<div class="flex-container">
					<span>
						<label for="stopStationID">Stop Station ID</label>
						<input id="stopStationID" name="stopStationID" required/>
					</span>
					<span>
						<label for="transitLineName">Transit Line Name</label>
						<input id="transitLineName" name="transitLineName" required/>
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
						<label for="arrivalTime">Arrival Time</label>
						<input id="arrivalTime" name="arrivalTime" placeholder="hh:mm:ss" required/>
					</span>
					<span>
						<label for="departTime">Depart Time</label>
						<input id="departTime" name="departTime" placeholder="hh:mm:ss" required/>
					</span>
					<span>
						<label for="stopNumber">Stop Number</label>
						<input id="stopNumber" name="stopNumber" required/>
					</span>
					<span>						
						<label for="fare">Fare</label>
						<input id="fare" name="fare" required/>
					</span>
					<button type="submit"> Create </button>
				</div>
				
			</form>
		</div>
	</div>
	<div>
		<h2>
			Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
