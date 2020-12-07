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
<h2> Edit Train Schedule Information Below</h2>
<form method ="post" action="EditTrainInfo.jsp">
<table>
<%
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet result;
	
	String trainID=request.getParameter("trainID");
	String transitLineName = request.getParameter("transitLineName");
	String originStationID = request.getParameter("originStationID");
	String destinationStationID = request.getParameter("destinationStationID");
	
	ResultSet edit = st.executeQuery("SELECT * from Schedule where trainID ='" + trainID + "' and transitLineName = '" + transitLineName +"' and originStationID = '"+ originStationID + "' and destinationStationID ='" +destinationStationID+"'");
	while(edit.next()){
		transitLineName = edit.getString("transitLineName");
		trainID=edit.getString("trainID");
		originStationID = edit.getString("originStationID");
		destinationStationID= edit.getString("destinationStationID");
		String arrivalDatetime = edit.getString("arrivalDatetime");
		String departDatetime = edit.getString("departDatetime");
		String tripType = edit.getString("tripType");
		String fixedFare = edit.getString("fixedFare");

	%>
	<tr>
	<td>transit line name</td>
	<td><input type = "text" name = "transitLineName" value = "<%=transitLineName%>"></td>
	</tr>
	<tr>
	<td> train ID </td>
	<td><input type = "text" name = "trainID" value = "<%=trainID%>"></td>
	</tr>
	<tr>
	<td> Origin Station ID</td>
	<td><input type = "text" name = "originStationID" value="<%=originStationID%>"></td>
	</tr>
	<tr>
	<td> Destination Station ID </td>
	<td><input type = "text" name ="destinationStationID" value = "<%=destinationStationID%>"></td>
	</tr>
	<tr>
	<td> Arrival Date Time </td>
	<td><input type = "text" name = "arrivalDatetime" value = "<%=arrivalDatetime%>"></td>
	</tr>
	<tr>
	<td> Departure Date Time </td>
	<td><input type = "text" name = "departDatetime" value = "<%=departDatetime%>"></td>
	</tr>
	<tr>
	<td> Trip Type </td>
	<td><input type = "text" name = "tripType" value = "<%=tripType%>"></td>
	</tr>
	<tr>
	<td> Fixed Fare </td>
	<td><input type = "text" name = "fixedFare" value = "<%=fixedFare%>"></td>
	</tr>
	<tr>
	<td><input type ="submit" name="btn_update" value="Update"></td>
	</tr>
	<tr>
	<td><input type ="hidden" name="transitname_original" value="<%=transitLineName%>"></td>
	</tr>
	<tr>
	<td><input type="hidden" name="trainID_original" value="<%=trainID%>"></td>
	</tr>
	<tr>
	<td><input type= "hidden" name="originID_original" value="<%=originStationID %>"></td>
	</tr>
	<tr>
	<td><input type="hidden" name="destID_original" value="<%=destinationStationID %>"></td>
	</tr>
		<%
	}
	edit.close();
	st.close();
	con.close();
	%>
	</table>
	</form>
	
	
	</body>
	</html>
