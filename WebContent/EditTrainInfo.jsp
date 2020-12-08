<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title> Edit Train Schedule Information</title>
</head>
<body>

<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String transitLineName, trainID, originStationID, destinationStationID, arrivalDatetime, departDatetime, tripType, fixedFare;
	String updatetransitLineName = request.getParameter("transitname_original");
	String updatetrainID = request.getParameter("trainID_original");
	String updateoriginStationID = request.getParameter("originID_original");
	String updatedestinationStationID = request.getParameter("destID_original");
	transitLineName = request.getParameter("transitLineName");
	trainID = request.getParameter("trainID");
	originStationID = request.getParameter("originStationID");
	destinationStationID = request.getParameter("destinationStationID");
	arrivalDatetime = request.getParameter("arrivalDatetime");
	departDatetime = request.getParameter("departDatetime");
	tripType = request.getParameter("tripType");	
	fixedFare = request.getParameter("fixedFare");
	
	PreparedStatement pstmt;
	pstmt = con.prepareStatement("UPDATE Schedule set transitLineName = ?, trainID = ?, originStationID = ?, destinationStationID = ?, arrivalDatetime = ?, departDatetime = ?, tripType = ?, fixedFare = ? WHERE transitLineName = ? and trainID = ? and originStationID = ? and destinationStationID = ?");
	pstmt.setString(1,transitLineName);
	pstmt.setInt(2,Integer.valueOf(trainID));
	pstmt.setInt(3,Integer.valueOf(originStationID));
	pstmt.setInt(4,Integer.valueOf(destinationStationID));
	pstmt.setString(5,arrivalDatetime);
	pstmt.setString(6,departDatetime);
	pstmt.setString(7,tripType);
	pstmt.setDouble(8,Double.valueOf(fixedFare));
	pstmt.setString(9,updatetransitLineName);
	pstmt.setInt(10,Integer.valueOf(updatetrainID));
	pstmt.setInt(11,Integer.valueOf(updateoriginStationID));
	pstmt.setInt(12,Integer.valueOf(updatedestinationStationID));
	pstmt.executeUpdate();
	out.println("Information has been updated! Will redirect to home page");

	pstmt.close();
	con.close();
	response.setHeader("Refresh", "3;home.jsp");
	%>
	</body>
	</html>
		
