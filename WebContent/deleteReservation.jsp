<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Reservation Page</title>
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
	String resIDs = request.getParameter("resID");
	String[] resID = resIDs.split(",");
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String query = "update Reservation set active=false where reservationNumber = ? and username = ?;";
		System.out.println(query);
		PreparedStatement pstmt = con.prepareStatement(query);
		for(String res_ID : resID){
			pstmt.setInt(1, Integer.valueOf(res_ID));
			pstmt.setString(2, ((String) session.getAttribute("username")));
			System.out.println(pstmt);
			try{
				pstmt.executeUpdate();
			}catch(Exception e){
				System.out.println("Query Failed!");
				System.out.println(e);
				out.println("Query failed, please retry");
			}
		}
		System.out.println("Disconnecting from database");
		con.close();
	}catch(Exception e){
		System.out.println("Could not connect to database");
		System.out.println(e);
		out.println("Could not connect to database");
	}
	
	%>
	<div>
		<h2>
			To see all the reservations: <a href="viewReservation.jsp">here</a>. Otherwise: please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
