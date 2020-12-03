<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.format.DateTimeFormatter,java.time.LocalDateTime"%>
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
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	LocalDateTime now = LocalDateTime.now();
	String dateOfCreation = dtf.format(now);
	String username = (String) session.getAttribute("username");
	System.out.println(username);
	System.out.println(dateOfCreation); 
	
	String transitNames = request.getParameter("transitName");
	String trainIDs = request.getParameter("trainID");
	String originStationIDs = request.getParameter("originStationID");
	String destinationStationIDs = request.getParameter("destinationStationID");
	
	String[] transitName = transitNames.split(",");
	String[] trainID = trainIDs.split(",");
	String[] originStationID = originStationIDs.split(",");
	String[] destinationStationID = destinationStationIDs.split(",");
	
	String value = request.getParameter("discount");
	System.out.println(value);
	
	ArrayList<Double> fare = new ArrayList<Double>();
	ArrayList<String> departDate = new ArrayList<String>();
	ArrayList<String> departTime = new ArrayList<String>();
	
	int totalRes = 0;
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String query = "select fixedFare, departDatetime from Schedule where transitLineName = ? and trainID = ? and originStationID = ? and destinationStationID = ?;";
		PreparedStatement pstmt = con.prepareStatement(query);
		for(int i = 0; i < transitName.length; i++){
			pstmt.setString(1, transitName[i]);
			pstmt.setInt(2, Integer.valueOf(trainID[i]));
			pstmt.setInt(3, Integer.valueOf(originStationID[i]));
			pstmt.setInt(4, Integer.valueOf(destinationStationID[i]));
			try{
				ResultSet result = pstmt.executeQuery();
				while(result.next()){
					double totalFare = result.getDouble("fixedFare");
					if(value.equals("senior")){
						totalFare = totalFare - (totalFare * .35);
					}else if(value.equals("child")){
						totalFare = totalFare - (totalFare * .25);
					}else if(value.equals("disable")){
						totalFare = totalFare - (totalFare * .5);
					}
					fare.add(totalFare);
					String departDatetime = result.getString("departDatetime");
					String[] dDatetime = departDatetime.split(" ");
					departDate.add(dDatetime[0]);
					departTime.add(dDatetime[1]);
				}
				result.close();
			}catch(Exception e){
				System.out.println("Query Failed");
				System.out.println(e);
				out.println("Query failed! Please try again!");
			}
		}
		
		query = "select count(*) as \"totalRes\" from Reservation;";
		pstmt = con.prepareStatement(query);
		try{
			ResultSet result = pstmt.executeQuery();
			while(result.next()){
				totalRes = result.getInt("totalRes");
			}
		}catch(Exception e){
			System.out.println("Query Failed");
			System.out.println(e);
			out.println("Query failed! Please try again!");
		}
		
		query = "insert into Reservation values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, true);";
		pstmt = con.prepareStatement(query);
		for(int i = 0; i < transitName.length; i++){
			pstmt.setInt(1, totalRes);
			pstmt.setString(2, dateOfCreation);
			pstmt.setString(3, username);
			pstmt.setString(4, transitName[i]);
			pstmt.setInt(5, Integer.valueOf(trainID[i]));
			pstmt.setInt(6, Integer.valueOf(originStationID[i]));
			pstmt.setInt(7, Integer.valueOf(destinationStationID[i]));
			pstmt.setString(8, departTime.get(i));
			pstmt.setString(9, departDate.get(i));
			pstmt.setDouble(10, fare.get(i));
			totalRes++;
			System.out.println(pstmt);
			try{
				pstmt.executeUpdate();
			}catch(Exception e){
				System.out.println("Failed to insert " + String.valueOf(totalRes) + transitName[i] + " " + trainID[i] + " " + " " + originStationID[i] + " " + destinationStationID[i]);
				System.out.println(e);
				out.println("Failed to insert " + transitName[i] + " " + trainID[i] + " " + " " + originStationID[i] + " " + destinationStationID[i]);
			}
			
		}
		pstmt.close();
		System.out.println("Disconnecting from database");
		con.close();
	}catch(Exception e){
		System.out.println("Failed to connect to database");
		System.out.println(e);
		out.println("Failed to connect to database");
	}
	%>
	<div>
		<h2>
			Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
