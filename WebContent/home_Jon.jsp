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
				<form method="post" action="searchSchedule.jsp">
					<label for="originStation" > Origin Station ID</label>
					<input id="originStation" name="originStationID" required/>
					<label for="destinationStation" > Destination Station ID</label>
					<input id="destinationStation" name="destinationStationID" required/>
					<label for="travelDate" > Date of Travel</label>
					<input id="travelDate" name="travelDatetime" placeholder="YYYY-MM-DD hh:mm:ss" required/>
					<br/>
					<button type="submit"> Search</button>
				</form>
			</div>
			<div>
				<h2>
					Create Reservation
				</h2>
					To create a reservation, please click <a href="createReservation.jsp">here</a>.
			</div>
			<div>
				<h2>
					View Reservations
				</h2>
					To view your reservations, please click <a href="viewReservation.jsp">here</a>.
			</div>
			<div>
				<h2>
					Cancel Reservations
				</h2>
				<form method="post" action="deleteReservation.jsp">
					<label for="resID"> Reservation IDs (comma separated)</label>
					<input id="resID" name="resID" required/>
					<button type="submit"> Delete </button>
				</form>
			</div>
			
			
			
			
			<div>
				<h2>
					Send a Question
				</h2>
					<form method="post" action="questionSubmit.jsp">
					<label for="Question">Enter your question here: </label>
					<input id="question" name="question" required/>
					<br/>
					<button type="submit"> Submit </button>
				</form>

				<form method="post" action="questionBrowse.jsp">
					<label for="browse">To browse questions/answers by keywords, type them in the form. If you want to browse all questions/answers, leave it blank: </label>
					<input id="browse" name="browse"/>
					<br/>
					<button type="submit"> Search </button>
				</form>
			</div>
			
			
			

		<% }else if(((String) session.getAttribute("role")).toLowerCase().equals("employee") || ((String) session.getAttribute("role")).toLowerCase().equals("admin")) { %>
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
				<div>
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
						<label for="arrivalTime">Arrival Time</label>
						<input id="arrivalTime" name="arrivalTime" placeholder="YYYY-MM-DD hh:mm:ss" required/>
						<label for="departTime">Depart Time</label>
						<input id="departTime" name="departTime" placeholder="YYYY-MM-DD hh:mm:ss" required/>
						<label for="tripType">Trip Type</label>
						<input id="tripType" name="tripType" required/>
						<label for="fixedFare">fixedFare</label>
						<input id="fixedFare" name="fixedFare" required/>
						</br>
						<button type="submit"> Create </button>
					</form>
				</div>
				<div>
					<h2>
						Create Stops
					</h2>
					<form method="post" action="createStop.jsp">
						<label for="stopStationID">Stop Station ID</label>
						<input id="stopStationID" name="stopStationID" required/>
						<label for="transitLineName">Transit Line Name</label>
						<input id="transitLineName" name="transitLineName" required/>
						<label for="trainID">Train ID</label>
						<input id="trainID" name="trainID" required/>
						<label for="originStationID">Origin Station ID</label>
						<input id="originStationID" name="originStationID" required/>
						<label for="destinationStationID">Destination Station ID</label>
						<input id="destinationStationID" name="destinationStationID" required/>
						<label for="arrivalTime">Arrival Time</label>
						<input id="arrivalTime" name="arrivalTime" placeholder="hh:mm:ss" required/>
						<label for="departTime">Depart Time</label>
						<input id="departTime" name="departTime" placeholder="hh:mm:ss" required/>
						<label for="stopNumber">Stop Number</label>
						<input id="stopNumber" name="stopNumber" required/>
						<label for="fare">Fare</label>
						<input id="fare" name="fare" required/>
						<br/>
						<button type="submit"> Create </button>
					</form>
				</div>
				
				<div>
				<h2>
					Answer a Question
				</h2>
				<form method="post" action="questionAnswer.jsp">
					<label for="question" > Type question here: </label>
					<input id="question" name="question" required/>
					<label for="answer" > Type your answer here: </label>
					<input id="answer" name="answer" required/>
					<button type="submit"> Submit</button>
				</form>
				
				To browse questions/answers, please click <a href="questionBrowse.jsp">here</a>.
				</div>

			</div>
			
			
		<% }else{ // Admin
			
		} %>
	
</body>
</html>