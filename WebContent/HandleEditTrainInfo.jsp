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
<form method ="post" action = "EditTrainInfo.jsp">
<table>
<%
try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet result;
	int trainID = Integer.parseInt(request.getParameter("trainID"));
	ResultSet edit = st.executeQuery("SELECT * FROM Schedule WHERE trainID = '" + trainID + "'");
	while(edit.next()){
		trainID = edit.getInt("trainID");
		String transitLineName = edit.getString("transitLineName");
		String tripType = edit.getString("tripType");
		String arrivalDatetime = edit.getString("arrivalDatetime");
		String departDatetime = edit.getString("departDatetime");
		int originStationID = edit.getInt("originStationID");
		int destinationStationID = edit.getInt("destinationStationID");
		double fixedFare = edit.getDouble("fixedFare");
	%>
	<tr>
	<td>trainID</td>
	<td><input type = "text" name = "trainID" value = "<%=trainID%>"></td>
	</tr>
	<tr>
	<td> transit line name </td>
	<td><input type = "text" name = "transitLineName" value = "<%=transitLineName %>"></td>
	</tr>
	<tr>
	<td> Trip Type </td>
	<td><input type = "text" name = "tripType" value="<%=tripType%>"></td>
	</tr>
	<tr>
	<td> Arrival Date Time </td>
	<td><input type = "text" name ="arrivalDatetime" value = "<%=arrivalDatetime%>"></td>
	</tr>
	<tr>
	<td> Depart Date Time </td>
	<td><input type = "text" name = "departDatetime" value = "<%=departDatetime%>"></td>
	</tr>
	<tr>
	<td> Origin Station ID </td>
	<td><input type = "text" name = "originStationID" value = "<%=originStationID %>"></td>
	</tr>
	<tr>
	<td> Destination Station ID </td>
	<td><input type = "text" name = "destinationStationID" value = "<%=destinationStationID %>"></td>
	</tr>
	<tr>
	<td> Fixed Fare </td>
	<td><input type = "text" name = "fixedFare" value = "<%=fixedFare%>"></td>
	</tr>
	<%
	}
	edit.close();
	st.close();
	con.close();
	}catch(Exception e){
		out.println("Error: Query Failed");
		out.println(e);
		}
	%>
	</table>
	</form>
