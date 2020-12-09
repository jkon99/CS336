<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sorted Schedules and Stops</title>
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
	</div>
	<%
		String stopsInfo = (String) request.getParameter("stopNames");
		String schedulesInfo = (String) request.getParameter("scheduleNames");
		System.out.println(stopsInfo);
		String[] stopMetaData = stopsInfo.split(";");
		String[] stopTrainID = stopMetaData[0].split(",");
		String[] stopTransitName = stopMetaData[1].split(",");
		String[] scheduleMetaData = schedulesInfo.split(",");
		
		System.out.println(schedulesInfo);
		try{
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			if(((String) request.getParameter("schedule")) != null){
				System.out.println("Sorting the Schedules!");
			%>
			<div>
				<h2>
					Schedules:
				</h2>
			</div>
			<%
				ArrayList<String> orderBy = new ArrayList<String>();
				ArrayList<String> orderByMeta = new ArrayList<String>();
				orderBy.add(request.getParameter("transit"));
				orderBy.add(request.getParameter("train"));
				orderBy.add(request.getParameter("originStation"));
				orderBy.add(request.getParameter("destinationStation"));
				orderBy.add(request.getParameter("arrivalDatetime"));
				orderBy.add(request.getParameter("departDatetime"));
				orderBy.add(request.getParameter("tripType"));
				orderBy.add(request.getParameter("fare"));
				
				orderByMeta.add(request.getParameter("transitOrderby"));
				orderByMeta.add(request.getParameter("trainOrderby"));
				orderByMeta.add(request.getParameter("originStationOrderby"));
				orderByMeta.add(request.getParameter("destinationStationOrderby"));
				orderByMeta.add(request.getParameter("arrivalDatetimeOrderby"));
				orderByMeta.add(request.getParameter("departDatetimeOrderby"));
				orderByMeta.add(request.getParameter("tripTypeOrderby"));
				orderByMeta.add(request.getParameter("fareOrderby"));
			
				String query = ""; 
				System.out.println(scheduleMetaData[3]);
				if(Integer.valueOf(scheduleMetaData[3]) == 0){
					query = "select * from Schedule where originStationID = ? and destinationStationID = ? and departDatetime = ?";
				}else if(Integer.valueOf(scheduleMetaData[3]) == 1){
					query = "select * from Schedule where originStationID = ? and destinationStationID = ? and DATE(departDatetime) = ?";
				}else{
					query = "select * from Schedule where originStationID = ? and destinationStationID = ? and TIME(departDatetime) = ?";
				}
				for(String s : orderBy){
					if(s != null){
						query += " order by";
						break;
					}
				}
				for(int i = 0; i < orderBy.size(); i++){
					if(orderBy.get(i) != null){
						query += " " + orderBy.get(i) + " " + orderByMeta.get(i) + ",";
					}					
				}
				if(query.charAt(query.length() - 1) != ','){
					query += ";";
				}else{
					query = query.substring(0, query.length() - 1) + ";";
				}
				System.out.println(query);
				PreparedStatement sortBy = con.prepareStatement(query);
				sortBy.setInt(1, Integer.valueOf(scheduleMetaData[0]));
				sortBy.setInt(2, Integer.valueOf(scheduleMetaData[1]));
				sortBy.setString(3, scheduleMetaData[2]);
				System.out.println(sortBy);
				try{
					ResultSet result = sortBy.executeQuery(); 
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
				
				sortBy.close();
			}
			if(((String) request.getParameter("stop")) != null){
				System.out.println("Sorting the Stops!");
				%>
				<div>
					<h2>
						Stops:
					</h2>
				</div>
				<%
				ArrayList<String> orderBy = new ArrayList<String>();
				ArrayList<String> orderByMeta = new ArrayList<String>();
				orderBy.add(request.getParameter("stopStation"));
				orderBy.add(request.getParameter("stopTransit"));
				orderBy.add(request.getParameter("stopTrain"));
				orderBy.add(request.getParameter("stopOriginStation"));
				orderBy.add(request.getParameter("stopDestinationStation"));
				orderBy.add(request.getParameter("stopArrivalTime"));
				orderBy.add(request.getParameter("stopDepartTime"));
				orderBy.add(request.getParameter("stopNumber"));
				orderBy.add(request.getParameter("stopFare"));
				
				orderByMeta.add(request.getParameter("stopStationOrderby"));
				orderByMeta.add(request.getParameter("stopTransitOrderby"));
				orderByMeta.add(request.getParameter("stopTrainOrderby"));
				orderByMeta.add(request.getParameter("stopOriginStationOrderby"));
				orderByMeta.add(request.getParameter("stopDestinationStationOrderby"));
				orderByMeta.add(request.getParameter("stopArrivalTimeOrderby"));
				orderByMeta.add(request.getParameter("stopDepartTimeOrderby"));
				orderByMeta.add(request.getParameter("stopNumberOrderby"));
				orderByMeta.add(request.getParameter("stopFareOrderby"));
				
				String query = "select * from Stop where originStationID = ? and destinationStationID = ? and transitLineName = ? and trainID = ?";
				
				for(String s : orderBy){
					if(s != null){
						query += " order by";
						break;
					}
				}
				for(int i = 0; i < orderBy.size(); i++){
					if(orderBy.get(i) != null){
						query += " " + orderBy.get(i) + " " + orderByMeta.get(i) + ",";
					}					
				}
				if(query.equals("select * from Stop where originStationID = ? and destinationStationID = ? and transitLineName = ? and trainID = ?")){
					query += ";";
				}else{
					query = query.substring(0, query.length() - 1) + ";";
				}
				System.out.println(query);
				PreparedStatement sortBy = con.prepareStatement(query);
				sortBy.setInt(1, Integer.valueOf(scheduleMetaData[0]));
				sortBy.setInt(2, Integer.valueOf(scheduleMetaData[1]));
				for(int i = 0; i < stopTransitName.length; i++){
					sortBy.setString(3, stopTransitName[i]);
					sortBy.setInt(4, Integer.valueOf(stopTrainID[i]));
					System.out.println(sortBy);
					try{
						ResultSet result = sortBy.executeQuery();
						%>
						<table class="fancyTable">	
						<caption> <%= stopTransitName[i] %></caption>
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
						System.out.println("Query Failed!");
						System.out.println(e);
						out.println("Sorry the query failed, please try again!");
						
					}
				}
				sortBy.close();
			}
			
			System.out.println("Disconnecting from database!");
			con.close();
		}catch(Exception e){
			System.out.println("Failed to connect to the database!");
			System.out.println(e);
			out.println("Failed to connect to the database, please retry!");
		}
		
	%>
	<div>
		<h2>
			Successfully sorted all the schedule/stop data! Please go back to <a href="home.jsp">home</a> or use the back button to go back to the searching schedule.
		</h2>
	</div>
</body>
</html>