<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stations Log</title>
<link rel="stylesheet" href="home.css">
</head>

<body>

		
<%

	ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		ResultSet result;
		
		String stationID = request.getParameter("stationID") + "";
		if(!stationID.matches("-?\\d+(\\.\\d+)?")){
			%>
			<div class="errorMessage">
			The Station ID has to be a number, <a href="home.jsp">try</a> again. 
		    </div>
			<% 
		}
		else{
		result = st.executeQuery("select * from Schedule where originStationID= '"+stationID+ "' or destinationStationID= '"+stationID+"'  ");
		if(!result.isBeforeFirst()){
			%>
			<div class="errorMessage">
			There exist no schedules for this station ID, <a href="home.jsp">try</a> again. 
		    </div>
			<% 
			result.close();
		}
		else{
		%>
		<table class="fancyTable">	
		<caption> Schedules</caption>
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
				<th>Arrival Time</th>
				<th>Departure Time</th>
				<th>Trip Type</th>
				<th>Fare</th>
			</tr>
		</thead>
		<tbody>
		<% 
		while(result.next()){ %>
				<tr>
					<td> <%= result.getString(1) %></td>
					<td> <%= result.getString(2) %></td>
					<td> <%= result.getString(3) %></td>
					<td> <%= result.getString(4) %></td>
					<td> <%= result.getString(5) %></td>
					<td> <%= result.getString(6) %></td>
					<td> <%= result.getString(7) %></td>
					<td> <%= result.getString(8) %></td>
				</tr>
	<%	}%>
		</tbody>
		</table> <% 
		result.close();
		con.close();
		 %>
		 <a href="home.jsp"> Refer back to the Customer Home Page</a>
		 <% 
		
			}
		
		}
		
		
%>

</body>
</html>