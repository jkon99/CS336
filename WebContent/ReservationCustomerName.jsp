<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Customer Reservations</title>
<link rel="stylesheet" href="home.css">

<body>

<%
try{
ApplicationDB db= new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet result;

String customername = request.getParameter("customername") + "";

result = st.executeQuery("select * from Reservation where username ='"+customername+"'");
%>
<table class= "fancyTable">
<caption>Reservations per Customer Name</caption>
<colgroup>
	<col>
	<col>
	<col>
</colgroup>
<thread>
<tr>
	<th> Reservation Number </th>
	<th> Reservation Date </th>
	<th> username </th>
	<th> Transit Line Name </th>
	<th> Train ID </th>
	<th> Origin Station ID </th>
	<th> Destination Station ID </th>
	<th> Departure Time </th>
	<th> Departure Date </th>
	<th> Total Fare </th>
	<th> Active </th>
</tr>
</thread>

<tbody>
<%
while(result.next()){ %>
<tr>
	<td> <%= result.getString("reservationNumber") %></td>
	<td> <%= result.getString("reservationDate") %></td>
	<td> <%= result.getString("username") %></td>
	<td> <%= result.getString("transitLineName") %></td>
	<td> <%= result.getString("trainID") %></td>
	<td> <%= result.getString("originStationID") %></td>
	<td> <%= result.getString("destinationStationID") %></td>
	<td> <%= result.getString("departureTime") %></td>
	<td> <%= result.getString("departureDate") %></td>
	<td> <%= result.getString("totalFare") %></td>
	<td> <%= result.getString("active") %></td>
</tr>


<% }%>
</tbody>
</table>
<%
result.close();
con.close();

}catch(Exception e){
	System.out.println("Query failed!");
	System.out.println(e);
	out.println("Query failed! Please retry");
}

%>

</body>
</html>
