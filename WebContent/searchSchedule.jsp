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
		%>
		<h2>
			Showing all the stops associated with each schedule:
		</h2>
		<%
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
		%> 
			<div>
				<h2>
					Sort by: 
				</h2>
				<form>
					<fieldset>
						<legend>
							Pick Schedules or Stops or Both!
						</legend>
						<label for="schedule"> Schedule</label>
						<input id="schedule" value="schedule" type="checkbox" name="schedule"/>
						<label for="stop"> Stop</label>
						<input id="stop" value="stop" type="checkbox" name="stop"/>
					</fieldset>
					<fieldset>
						<legend> Sort By </legend>
						<fieldset>
							<legend>
								Stop [Sort By]
							</legend>
							<span>
								<input id="stopStation" type="checkbox" name="stopStation" value="DESC" />
								<label for="stopStation">Stop Station ID</label>
								<input id="stopStationDES" type="radio" name="stopStationOrderby" value="DESC" checked />
								<label for="stopStationDES">Descending </label>
								<input id="stopStationASC" type="radio" name="stopStationOrderby" value="ASC" />
								<label for="stopStationASC">Ascending</label>
							</span>
							<br/>
							<span>
								<label for="stopTransit">Transit Line Name</label>
								<input id="stopTransit" type="checkbox" name="stopTransit" value="DESC" />
								<label for="stopTransitDES">Descending </label>
								<input id="stopTransitDES" type="radio" name="stopTransitOrderby" value="DESC" checked />
								<label for="stopTransitASC">Ascending</label>
								<input id="stopTransitASC" type="radio" name="stopTransitOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopTrain">Train ID</label>
								<input id="stopTrain" type="checkbox" name="stopTrain" value="DESC" />
								<label for="stopTrainDES">Descending </label>
								<input id="stopTrainDES" type="radio" name="stopTrainOrderby" value="DESC" checked />
								<label for="stopTrainASC">Ascending</label>
								<input id="stopTrainASC" type="radio" name="stopTrainOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopOriginStation">Origin Station ID</label>
								<input id="stopOriginStation" type="checkbox" name="stopOriginStation" value="DESC" />
								<label for="stopOriginStationDES">Descending </label>
								<input id="stopOriginStationDES" type="radio" name="stopOriginStationOrderby" value="DESC" checked />
								<label for="stopOriginStationASC">Ascending</label>
								<input id="stopOriginStationASC" type="radio" name="stopOriginStationOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopDestinationStation">Destination Station ID</label>
								<input id="stopDestinationStation" type="checkbox" name="stopDestinationStation" value="DESC" />
								<label for="stopDestinationStationDES">Descending </label>
								<input id="stopDestinationStationDES" type="radio" name="stopDestinationStationOrderby" value="DESC" checked />
								<label for="stopDestinationStationASC">Ascending</label>
								<input id="stopDestinationStationASC" type="radio" name="stopDestinationStationOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopArrivalTime">Arrival Time</label>
								<input id="stopArrivalTime" type="checkbox" name="stopArrivalTime" value="DESC" />
								<label for="stopArrivalTimeDES">Descending </label>
								<input id="stopArrivalTimeDES" type="radio" name="stopArrivalTimeOrderby" value="DESC" checked />
								<label for="stopArrivalTimeASC">Ascending</label>
								<input id="stopArrivalTimeASC" type="radio" name="stopArrivalTimeOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopDepartTime">Departure Time</label>
								<input id="stopDepartTime" type="checkbox" name="stopDepartTime" value="DESC" />
								<label for="stopDepartTimeDES">Descending </label>
								<input id="stopDepartTimeDES" type="radio" name="stopDepartTimeOrderby" value="DESC" checked />
								<label for="stopDepartTimeASC">Ascending</label>
								<input id="stopDepartTimeASC" type="radio" name="stopDepartTimeOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopNumber">Stop Number</label>
								<input id="stopNumber" type="checkbox" name="stopNumber" value="DESC" />
								<label for="stopNumberDES">Descending </label>
								<input id="stopNumberDES" type="radio" name="stopNumberOrderby" value="DESC" checked />
								<label for="stopNumberASC">Ascending</label>
								<input id="stopNumberASC" type="radio" name="stopNumberOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="stopFare">Stop Number</label>
								<input id="stopFare" type="checkbox" name="stopFare" value="DESC" />
								<label for="stopFareDES">Descending </label>
								<input id="stopFareDES" type="radio" name="stopFareOrderby" value="DESC" checked />
								<label for="stopFareASC">Ascending</label>
								<input id="stopFareASC" type="radio" name="stopFareOrderby" value="ASC" />
							</span>
						</fieldset>
						<fieldset>
							<legend>Schedule [Sort By]</legend>
							<span>
								<label for="transit">Transit Line Name</label>
								<input id="transit" type="checkbox" name="transit" value="DESC" />
								<label for="transitDES">Descending </label>
								<input id="transitDES" type="radio" name="transitOrderby" value="DESC" checked />
								<label for="transitASC">Ascending</label>
								<input id="transitASC" type="radio" name="transitOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="train">Train ID</label>
								<input id="train" type="checkbox" name="train" value="DESC" />
								<label for="trainDES">Descending </label>
								<input id="trainDES" type="radio" name="trainOrderby" value="DESC" checked />
								<label for="trainASC">Ascending</label>
								<input id="trainASC" type="radio" name="trainOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="originStation">Origin Station ID</label>
								<input id="originStation" type="checkbox" name="originStation" value="DESC" />
								<label for="originStationDES">Descending </label>
								<input id="originStationDES" type="radio" name="originStationOrderby" value="DESC" checked />
								<label for="originStationASC">Ascending</label>
								<input id="originStationASC" type="radio" name="originStationOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="destinationStation">Destination Station ID</label>
								<input id="destinationStation" type="checkbox" name="destinationStation" value="DESC" />
								<label for="destinationStationDES">Descending </label>
								<input id="destinationStationDES" type="radio" name="destinationStationOrderby" value="DESC" checked />
								<label for="destinationStationASC">Ascending</label>
								<input id="destinationStationASC" type="radio" name="destinationStationOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="arrivalDatetime">Arrival Time</label>
								<input id="arrivalDatetime" type="checkbox" name="arrivalDatetime" value="DESC" />
								<label for="arrivalDatetimeDES">Descending </label>
								<input id="arrivalDatetimeDES" type="radio" name="arrivalDatetimeOrderby" value="DESC" checked />
								<label for="arrivalDatetimeASC">Ascending</label>
								<input id="arrivalDatetimeASC" type="radio" name="arrivalDatetimeOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="departDatetime">Departure Time</label>
								<input id="departDatetime" type="checkbox" name="departDatetime" value="DESC" />
								<label for="departDatetimeDES">Descending </label>
								<input id="departDatetimeDES" type="radio" name="departDatetimeOrderby" value="DESC" checked />
								<label for="departDatetimeASC">Ascending</label>
								<input id="departDatetimeASC" type="radio" name="departDatetimeOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="tripType">Stop Number</label>
								<input id="tripType" type="checkbox" name="tripType" value="DESC" />
								<label for="tripTypeDES">Descending </label>
								<input id="tripTypeDES" type="radio" name="tripTypeOrderby" value="DESC" checked />
								<label for="tripTypeASC">Ascending</label>
								<input id="tripTypeASC" type="radio" name="tripTypeOrderby" value="ASC" />
							</span>
							<br/>
							<span>
								<label for="fare">Stop Number</label>
								<input id="fare" type="checkbox" name="fare" value="DESC" />
								<label for="fareDES">Descending </label>
								<input id="fareDES" type="radio" name="fareOrderby" value="DESC" checked />
								<label for="fareASC">Ascending</label>
								<input id="fareASC" type="radio" name="fareOrderby" value="ASC" />
							</span>
						</fieldset>
					</fieldset>
					<button type="submit"> Submit </button>
				</form>
			</div>
		<%
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
