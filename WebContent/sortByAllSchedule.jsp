<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sort Schedules</title>
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
		try{
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			%>
			<div>
				<h2>
					Schedules:
				</h2>
			</div>
			<%
			String query = "select * from Schedule";
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
			if(query.equals("select * from Schedule")){
				query += ";";
			}else{
				query = query.substring(0, query.length() - 1) + ";";
			}
			System.out.println(query);
			PreparedStatement sortBy = con.prepareStatement(query);
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