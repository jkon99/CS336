<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Best Customer</title>
<link rel="stylesheet" href="home.css">
</head>

<body>

<%
try{
ApplicationDB db= new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet result;


result = st.executeQuery("select sums.username,sums.totalBought from (select username, sum(totalFare) as \"totalBought\" from Reservation GROUP BY username )sums where sums.totalBought = (select max(sumtest.totalBought) from (select username, sum(totalFare) as \"totalBought\" from Reservation group by username) sumtest);");
while(result.next()){ %>
<tr>
<td> <%= result.getString("username") %></td>
<td> <%= result.getString("totalBought") %></td>
</tr>

<%
}
}catch(Exception e){
		System.out.println("Query failed!");
		System.out.println(e);
		out.println("Query failed! Please retry");
}
%>
</body>
</html>

