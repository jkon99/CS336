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
		<% if(((String) session.getAttribute("role")).toLowerCase().equals("customer")){ %>
			<div>
				<h2>
					Search the Train Schedules
				</h2>
				<form>
					<label for="originStation" > Origin Station</label>
					<input id="originStation"/>
					<label for="destinationStation" > Destination Station</label>
					<input id="destinationStation" name="destinationStation"/>
					<label for="travelDate" > Date of Travel</label>
					<input id="travelDate"/>
				</form>
			</div>
		<% }else if(((String) session.getAttribute("role")).toLowerCase().equals("employee")) { %>
			<div>
				<h2>
					Create Trains
				</h2>
				<form method="post" action="createTrain.jsp">
					<label for="trains">Train ID</label>
					<input id="trainID" name="trainID" required/>
					<br/>
					<button type="submit"> Create </button>
				</form>
				<h2>
					Create Stations
				</h2>
				<form method="post" action="createStation.jsp">
					<label for="stationID">Station ID</label>
					<input id="stationID" name="stationID" required/>
					<label for="stationName">Station Name</label>
					<input id="stationName" name="stationName" required/>
					<label for="state">State</label>
					<input id="state" name="state" required/>
					<label for="city">City</label>
					<input id="city" name="city" required/>
					</br>
					<button type="submit"> Create </button>
				</form>
				<h2>
					Create Schedules
				</h2>
				<form method="post" action="createSchedule.jsp">
					<label for="transitLineName">Transit Line Name</label>
					<input id="transitLineName" name="transitLineName" required/>
					<label for="trainID">Train ID</label>
					<input id="trainID" name="trainID" required/>
					<label for="originStationID">Origin Station ID</label>
					<input id="originStationID" name="originStationID" required/>
					<label for="destinationStationID">Destination Station ID</label>
					<input id="destinationStationID" name="destinationStationID" required/>
					<label for="departTime">Depart Time</label>
					<input id="departTime" name="departTime" placeholder="HH:MM:SS" required/>
					<label for="arrivalTime">Arrival Time</label>
					<input id="arrivalTime" name="arrivalTime" placeholder="HH:MM:SS" required/>
					<label for="tripType">Trip Type</label>
					<input id="tripType" name="tripType" required/>
					<label for="fixedFare">fixedFare</label>
					<input id="fixedFare" name="fixedFare" required/>
					</br>
					<button type="submit"> Create </button>
				</form>
			</div>
		<% }else{ // Admin
			
		} %>
	
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