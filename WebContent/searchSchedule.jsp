<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Schedule</title>
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
	boolean date = false;
	if(departTime.contains("-")){
		date = true;
		System.out.println("Entered date");
	}
	boolean time = false;
	if(departTime.contains(":")){
		time = true;
		System.out.println("Entered Time");
	}
	String enteredDateTime = "";
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String insert = "";
		if(time && date){
			insert = "select * from Schedule where originStationID = ? and destinationStationID = ? and departDatetime = ?;";
			enteredDateTime = "0";
		}else if(date){
			insert = "select * from Schedule where originStationID = ? and destinationStationID = ? and DATE(departDatetime) = ?;";
			enteredDateTime = "1";
		}else{
			insert = "select * from Schedule where originStationID = ? and destinationStationID = ? and TIME(departDatetime) = ?;";
			enteredDateTime = "2";
		}
		
		PreparedStatement insertUser = con.prepareStatement(insert);
		ArrayList<String> transitLineNames = new ArrayList<String>();
		ArrayList<String> trainIDs = new ArrayList<String>();
		try{
			insertUser.setInt(1, Integer.valueOf(originStationID));
			insertUser.setInt(2, Integer.valueOf(destinationStationID));
			insertUser.setString(3, departTime);
			System.out.println(insertUser);
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
					<% transitLineNames.add(result.getString("transitLineName")); 
					   trainIDs.add(result.getString("trainID")); %>
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
		insert = "select * from Stop where originStationID = ? and destinationStationID = ? and transitLineName = ? and trainID = ?;";
		insertUser = con.prepareStatement(insert);
		for(int i = 0; i < transitLineNames.size(); i++){
			insertUser.setInt(1, Integer.valueOf(originStationID));
			insertUser.setInt(2, Integer.valueOf(destinationStationID));
			insertUser.setString(3, transitLineNames.get(i));
			insertUser.setInt(4,  Integer.valueOf(trainIDs.get(i)));
			System.out.println(insertUser);
			try{
				ResultSet result = insertUser.executeQuery();
				%>
				<table class="fancyTable">	
				<caption> <%= transitLineNames.get(i) %></caption>
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
		String stringifyTrainIDs = String.join(",", trainIDs);
		String stringifyTransitNames = String.join(",", transitLineNames);
		System.out.println(stringifyTrainIDs);
		System.out.println(stringifyTransitNames);
		
		request.setAttribute("stopInformation", stringifyTrainIDs + ";" + stringifyTransitNames);
		insertUser.close();
		System.out.println("Disconnecting from database");
		con.close();
	}catch(Exception e){
		out.println("<div class=\"errorMessage\"> Could not connect to the database </div>");
		System.out.println(e);
	}%>
		<div>
		<h2>
			Sort by: 
		</h2>
		<form method="post" action="sortBySchedule.jsp">
			<input type="hidden" name="stopNames" value="<%= request.getAttribute("stopInformation") %>"/>
			<input type="hidden" name="scheduleNames" value="<%=((String) request.getParameter("originStationID")) + "," + ((String) request.getParameter("destinationStationID")) + "," + ((String) request.getParameter("travelDatetime")) + "," + ((String) enteredDateTime) %>" />
			<fieldset>
				<legend>
					Pick Schedules or Stops or Both!
				</legend>
			<div class="flex-container">
				<span>
					<label for="stop"> Stop</label>
					<input id="stop" value="stop" type="checkbox" name="stop"/>
				</span>
				<span>
					<label for="schedule"> Schedule</label>
					<input id="schedule" value="schedule" type="checkbox" name="schedule"/>
				</span>
			</div>
				
				
			<fieldset>
				<legend> Stop [Sort By]</legend>
					<span>
						<input id="stopStation" type="checkbox" name="stopStation" value="stopStationID" />
						<label for="stopStation">Stop Station ID</label>
						
						<input id="stopStationDES" type="radio" name="stopStationOrderby" value="DESC" checked />
						<label for="stopStationDES">Descending </label>
						
						<input id="stopStationASC" type="radio" name="stopStationOrderby" value="ASC" />
						<label for="stopStationASC">Ascending</label>
					</span>

					<span>
						<input id="stopTransit" type="checkbox" name="stopTransit" value="transitLineName" />
						<label for="stopTransit">Transit Line Name</label>
						
						<input id="stopTransitDES" type="radio" name="stopTransitOrderby" value="DESC" checked />
						<label for="stopTransitDES">Descending </label>
						
						<input id="stopTransitASC" type="radio" name="stopTransitOrderby" value="ASC" />
						<label for="stopTransitASC">Ascending</label>
						
					</span>

					<span>
						<input id="stopTrain" type="checkbox" name="stopTrain" value="trainID" />
						<label for="stopTrain">Train ID</label>
						
						<input id="stopTrainDES" type="radio" name="stopTrainOrderby" value="DESC" checked />
						<label for="stopTrainDES">Descending </label>
						
						<input id="stopTrainASC" type="radio" name="stopTrainOrderby" value="ASC" />
						<label for="stopTrainASC">Ascending</label>

					</span>
					<span>
						<input id="stopOriginStation" type="checkbox" name="stopOriginStation" value="originStationID" />
						<label for="stopOriginStation">Origin Station ID</label>
						<input id="stopOriginStationDES" type="radio" name="stopOriginStationOrderby" value="DESC" checked />
						<label for="stopOriginStationDES">Descending </label>
						<input id="stopOriginStationASC" type="radio" name="stopOriginStationOrderby" value="ASC" />
						<label for="stopOriginStationASC">Ascending</label>
					</span>
					<span>
						<input id="stopDestinationStation" type="checkbox" name="stopDestinationStation" value="destinationStationID" />
						<label for="stopDestinationStation">Destination Station ID</label>
						<input id="stopDestinationStationDES" type="radio" name="stopDestinationStationOrderby" value="DESC" checked />
						<label for="stopDestinationStationDES">Descending </label>
						<input id="stopDestinationStationASC" type="radio" name="stopDestinationStationOrderby" value="ASC" />
						<label for="stopDestinationStationASC">Ascending</label>	
					</span>
					<span>
						<input id="stopArrivalTime" type="checkbox" name="stopArrivalTime" value="arrivalTime" />
						<label for="stopArrivalTime">Arrival Time</label>
						
						<input id="stopArrivalTimeDES" type="radio" name="stopArrivalTimeOrderby" value="DESC" checked />
						<label for="stopArrivalTimeDES">Descending </label>
						
						<input id="stopArrivalTimeASC" type="radio" name="stopArrivalTimeOrderby" value="ASC" />
						<label for="stopArrivalTimeASC">Ascending</label>		
					</span>
					<span>
						<input id="stopDepartTime" type="checkbox" name="stopDepartTime" value="departTime" />
						<label for="stopDepartTime">Departure Time</label>
						
						<input id="stopDepartTimeDES" type="radio" name="stopDepartTimeOrderby" value="DESC" checked />
						<label for="stopDepartTimeDES">Descending </label>
						
						<input id="stopDepartTimeASC" type="radio" name="stopDepartTimeOrderby" value="ASC" />
						<label for="stopDepartTimeASC">Ascending</label>
						
					</span>
					<span>
						<input id="stopNumber" type="checkbox" name="stopNumber" value="stopNumber" />
						<label for="stopNumber">Stop Number</label>
						
						<input id="stopNumberDES" type="radio" name="stopNumberOrderby" value="DESC" checked />
						<label for="stopNumberDES">Descending </label>
						
						<input id="stopNumberASC" type="radio" name="stopNumberOrderby" value="ASC" />
						<label for="stopNumberASC">Ascending</label>
						
					</span>
					<span>
						<input id="stopFare" type="checkbox" name="stopFare" value="fare" />
						<label for="stopFare">Fare</label>
						
						<input id="stopFareDES" type="radio" name="stopFareOrderby" value="DESC" checked />
						<label for="stopFareDES">Descending </label>
						
						<input id="stopFareASC" type="radio" name="stopFareOrderby" value="ASC" />
						<label for="stopFareASC">Ascending</label>
					</span>
				</fieldset>
				<fieldset>
					<legend>Schedule [Sort By]</legend>
					<span>
						<input id="transit" type="checkbox" name="transit" value="transitLineName" />
						<label for="transit">Transit Line Name</label>
						
						<input id="transitDES" type="radio" name="transitOrderby" value="DESC" checked />
						<label for="transitDES">Descending </label>
						
						<input id="transitASC" type="radio" name="transitOrderby" value="ASC" />
						<label for="transitASC">Ascending</label>
						
					</span>
					<span>
						<input id="train" type="checkbox" name="train" value="trainID" />
						<label for="train">Train ID</label>
						
						<input id="trainDES" type="radio" name="trainOrderby" value="DESC" checked />
						<label for="trainDES">Descending </label>
						
						<input id="trainASC" type="radio" name="trainOrderby" value="ASC" />
						<label for="trainASC">Ascending</label>
						
					</span>
					<span>
						<input id="originStation" type="checkbox" name="originStation" value="originStationID" />
						<label for="originStation">Origin Station ID</label>
						
						<input id="originStationDES" type="radio" name="originStationOrderby" value="DESC" checked />
						<label for="originStationDES">Descending </label>
						
						<input id="originStationASC" type="radio" name="originStationOrderby" value="ASC" />
						<label for="originStationASC">Ascending</label>
						
					</span>
					<span>
						<input id="destinationStation" type="checkbox" name="destinationStation" value="destinationStationID" />
						<label for="destinationStation">Destination Station ID</label>
						
						<input id="destinationStationDES" type="radio" name="destinationStationOrderby" value="DESC" checked />
						<label for="destinationStationDES">Descending </label>
						
						<input id="destinationStationASC" type="radio" name="destinationStationOrderby" value="ASC" />
						<label for="destinationStationASC">Ascending</label>
					</span>
					<span>
						<input id="arrivalDatetime" type="checkbox" name="arrivalDatetime" value="arrivalDatetime" />
						<label for="arrivalDatetime">Arrival Time</label>
						
						<input id="arrivalDatetimeDES" type="radio" name="arrivalDatetimeOrderby" value="DESC" checked />
						<label for="arrivalDatetimeDES">Descending </label>
						
						<input id="arrivalDatetimeASC" type="radio" name="arrivalDatetimeOrderby" value="ASC" />
						<label for="arrivalDatetimeASC">Ascending</label>
					</span>
					<span>
						<input id="departDatetime" type="checkbox" name="departDatetime" value="departDatetime" />
						<label for="departDatetime">Departure Time</label>
						
						<input id="departDatetimeDES" type="radio" name="departDatetimeOrderby" value="DESC" checked />
						<label for="departDatetimeDES">Descending </label>
						
						<input id="departDatetimeASC" type="radio" name="departDatetimeOrderby" value="ASC" />
						<label for="departDatetimeASC">Ascending</label>
					</span>
					<span>
						<input id="tripType" type="checkbox" name="tripType" value="tripType" />
						<label for="tripType">Trip Type</label>
						
						<input id="tripTypeDES" type="radio" name="tripTypeOrderby" value="DESC" checked />
						<label for="tripTypeDES">Descending </label>
						
						<input id="tripTypeASC" type="radio" name="tripTypeOrderby" value="ASC" />
						<label for="tripTypeASC">Ascending</label>
						
					</span>
					<span>
						<input id="fare" type="checkbox" name="fare" value="fixedFare" />
						<label for="fare">Fare</label>
						
						<input id="fareDES" type="radio" name="fareOrderby" value="DESC" checked />
						<label for="fareDES">Descending </label>
						
						<input id="fareASC" type="radio" name="fareOrderby" value="ASC" />
						<label for="fareASC">Ascending</label>
						
					</span>
				</fieldset>
			<button type="submit"> Submit </button>
			</fieldset>
		</form>
	</div>
	
	<div>
		<h2>
			Successfully retrieved all the schedule data! Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
