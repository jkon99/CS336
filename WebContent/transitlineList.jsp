<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Users Reservations</title>
<link rel="stylesheet" href="home.css">
</head>

<body>

		
<%

	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet result;
	
	
	String transitline = request.getParameter("transitlineID") + "";
	String reservationDate = request.getParameter("reservationDate") + ""; 
	
	result = st.executeQuery("select distinct username from Reservation where transitLineName= '"+transitline+"' and reservationDate= '"+reservationDate+"';"); 
	
	if(!result.next()){
		out.println("There is no reservations for this Transit Line and Date");
	}else{
	%>
	<!--  -->
	<style>
	
	table{
  		margin-left: auto;
  		margin-right: auto;	
  	}
	</style>
	<table class="fancyTable">	
	<colgroup>
		<col>
		<col>
		<col>
	</colgroup>
	<thead>
		<tr>
			<th>Customers</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td> <%= result.getString(1) %></td>
			</tr>
		<%
		//out.println(result.getString(1));
		while(result.next()){			
			%>
			<tr>
				<td> <%= result.getString(1) %></td>
			</tr>
	<%	}%>
		</tbody>
		</table> 

	<%
	}
	result.close();
	con.close();	
	%>

</body>
</html>