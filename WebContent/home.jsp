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
				  <div class="flex-container">
				    <span>
				      <label for="originStation" > Origin Station ID</label>
				      <input id="originStation" name="originStationID" required/>
				    </span>
				    <span>
				      <label for="destinationStation" > Destination Station ID</label>
				      <input id="destinationStation" name="destinationStationID" required/>
				    </span>
				    <span>
				      <label for="travelDate" > Date of Travel</label>
				      <input id="travelDate" name="travelDatetime" placeholder="YYYY-MM-DD hh:mm:ss" required/>
				    </span>
				  </div>
				  <button type="submit"> Search</button>
				</form>
				
				<form method="post" action="sortByAllSchedule.jsp">
					<fieldset>
						<legend>All Schedule [Sort By]</legend>
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
						<button type="submit"> Submit </button>
					</fieldset>
					
				</form>
			</div>
			<div>
				<h2>
					View Stations
				</h2>
					To view all the stations, please click <a href="viewStation.jsp">here</a>.
			</div>
			
			<div>
				<h2>
					View Stops
				</h2>
					To view all the stops, please click <a href="viewStop.jsp">here</a>.
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
					<div class="flex-container">
						<span>
							<label for="resID"> Reservation IDs (comma separated)</label>
							<input id="resID" name="resID" required/>
						</span>
						<button type="submit"> Cancel </button>
					</div>
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
			
		<% }else if(((String) session.getAttribute("role")).toLowerCase().equals("employee")){ %>
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
				
				<div>
					<h2>
						Schedule Logs and User Reservations
					</h2>
					<form method="post" action="stationSchedules.jsp">
						<div class="flex-container">
							<span>
								<label for="stationID"> Find schedules for Station ID: </label>
								<input id="stationID" name="stationID" required/>
							</span>
							<button type="submit"> Search </button>
						</div>
					</form>
		
					<form method="post" action="transitlineList.jsp">
						<div class="flex-container">
							<span>
								<label for="transitlineID">Transit Line Name: </label>
								<input id="transitlineID" name="transitlineID" required/>
							</span>
							<span>
								<label for="reservationDate">Reservation Date: </label>
								<input id="reservationDate" name="reservationDate" placeholder="YYYY-MM-DD" required/>
							</span>
							<button type="submit"> Search</button>
						</div>
					</form>
				</div>
				
				
				<div>
					<h2> Edit Train Schedule Information </h2>
					<form method="post" action="HandleEditTrainInfo.jsp">
						<div class="flex-container">
							<span>
								<label for="transitLineName"> transit line name: </label>
								<input id="transitLineName" name="transitLineName" required/>
							</span>
							<span>
								<label for="trainID"> Train ID:</label>
								<input id="trainID" name="trainID" required/>
							</span>
							<span>
								<label for="originStationID"> Origin Station ID: </label>
								<input id="originStationID" name="originStationID" required/>
							</span>
							<span>
								<label for="destinationStationID" > Destination Station ID: </label>
								<input id="destinationStationID" name="destinationStationID" required/>
							</span>
							<button type="submit"> Edit </button>
						</div>
					</form>
				</div>
				<div>
					<h2>
						Delete Schedules
					</h2>				
					<form method ="post" action="DeleteScheduleInfo.jsp">
						<div class="flex-container">
							<span>
								<label for="transitLineName"> transit line name: </label>
								<input id="transitLineName" name="transitLineName" required/>
							</span>
							<span>
								<label for="trainID"> Train ID:</label>
								<input id="trainID" name="trainID" required/>
							</span>
							<span>
								<label for="originStationID"> Origin Station ID: </label>
								<input id="originStationID" name="originStationID" required/>
							</span>
							<span>
								<label for="destinationStationID" > Destination Station ID: </label>
								<input id="destinationStationID" name="destinationStationID" required/>
							</span>
							<button type="submit">Delete</button>
						</div>
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
					
					To browse questions/answers, please click <a href="viewQuestion.jsp">here</a>.
				</div>
				
				<div>
					Click <a href="betterCreate.jsp">here</a> for better create.
				</div>
				

		</div>
			
			
		<% }else{ // Admin %>
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
			<div>
				Click <a href="betterCreate.jsp">here</a> for better create.
			</div>
			
			<div>
				<h2> Get Reservation List per Customer Name</h2>
				<form method ="post" action ="ReservationCustomerName.jsp">
					<div class="flex-container"> 
						<span>
							<label for="customername"> Customer Name </label>
							<input id= "customername" name= "customername" required/>
						</span>
						<button type = "submit"> Search </button>
					</div>
				</form>
			</div>
			<div>
				<h2> Get Reservation List per Transit Line</h2>
				<form method ="post" action="ReservationTransitName.jsp">
					<div class="flex-container">
						<span>
							<label for ="transitname"> Transit Line Name </label>
							<input id = "transitname" name ="transitname" required/>
						</span>
						<button type = "submit"> Search </button>
					</div>
				</form>
			</div>
			<div>
				<h2> Revenue List per Customer Name</h2>
				<form method= "post" action="RevenueCustomerName.jsp">
					<div class="flex-container">
						<span>
							<label for="customername"> Revenue by Customer Name:</label>
							<input id="customername" name="customername" required/>
						</span>
						<button type ="submit"> Search </button>
					</div>
				</form>
			</div>
			<div>
				<h2> Revenue List per Transit Line</h2>
				<form method ="post" action="RevenueListTransitName.jsp">
					<div class="flex-container">	
						<span>
							<label for="transitname"> Revenue by Transit Line Name: </label>
							<input id="transitname" name="transitname" required/>
						</span>
						<button type = "submit"> Search </button>
					</div>
				</form>
			</div>
			
			
			<div>
				<h2>
					Check for Revenue
				</h2>
				<form method="post" action="adminSalesReport.jsp">
					<div class="flex-container">
						<span>
							<label for="month"> Find sales report for: </label>
							<input id="month" name="month" placeholder="MM as 01:Jan...12:Dec" required/>
						</span>
						<button type="submit"> Search </button>	
					</div>				
				</form>
			</div>
				
			
			<div>
				<h2>
					Update Employee Information
				</h2>
			 		<form method="post" action="addInfoCustomerRep.jsp">
			 			<button type="submit">Add</button>
			 		</form>
			 		
					<form method="post" action="editInfoCustomerRep.jsp">			
						<div class="flex-container">
							<span>
								<label for="ssn"> Employee's SSN: </label>
								<input id="ssn" name="ssn" placeholder="xxxxxxxxx" maxLength="9" required>
							</span>
							<button type="submit">Edit</button>
						</div>
					</form>
			  		
			  		<form method="post" action="deleteInfoCustomerRep.jsp">
			  			<div class="flex-container">
			  				<span>
			  					<label for="ssn"> Employee's SSN: </label>
								<input id="ssn" name="ssn" placeholder="xxxxxxxxx" maxLength="9" required>
			  				</span>
			  				<button type="submit">Delete</button>
			  			</div>
					</form>
			</div>
			
			<div>
				Click <a href="BestCustomer.jsp">here</a> for the best customer.
			</div>
			<div>
				Click <a href="ActiveTransitLines.jsp">here</a> for the best 5 most active transit lines.
			</div>
		</div>
		<% } %>
	
</body>
</html>
