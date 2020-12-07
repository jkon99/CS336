<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Edit Train Schedule </title>
<link rel="stylesheet" href="home.css">

<body>

<%
try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String transitLineName, tripType, arrivalDatetime, departDatetime;
	int trainID, originStationID, destinationStationID;
	double fixedFare;
	int updatetrainID = Integer.parseInt(request.getParameter("trainID_original"));
	trainID = Integer.parseInt(request.getParameter("trainID"));
	transitLineName = request.getParameter("transitLineName");
	tripType = request.getParameter("tripType");
	arrivalDatetime = request.getParameter("arrivalDatetime");
	departDatetime = request.getParameter("departDatetime");	
	originStationID = Integer.parseInt(request.getParameter("originStationID"));
	destinationStationID = Integer.parseInt(request.getParameter("destinationStationID"));
	fixedFare = Double.parseDouble(request.getParameter("fixedFare"));
	
	PreparedStatement pstmt;
	pstmt = con.prepareStatement("UPDATE Schedule set trainID = ?, transitLineName = ?, tripType = ?, arrivalDatetime= ?, departDatetime = ?, originStationID = ?, destinationStationID = ?, fixedFare = ? WHERE trainID = ?;");
	pstmt.setInt(1,trainID);
	pstmt.setString(2,transitLineName);
	pstmt.setString(3,tripType);
	pstmt.setString(4,arrivalDatetime);
	pstmt.setString(5,departDatetime);
	pstmt.setInt(6,originStationID);
	pstmt.setInt(7,destinationStationID);
	pstmt.setDouble(8,fixedFare);
	pstmt.executeUpdate();

	pstmt.close();
	con.close();
}catch(Exception e){
		out.println("Error: Query Failed");
		out.println(e);
		}
	%>
	</body>
	</html>
		
