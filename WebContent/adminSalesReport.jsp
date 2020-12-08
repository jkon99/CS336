<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Monthly Sales Report</title>
<link rel="stylesheet" href="home.css">
</head>

<body>

<form action="logout.jsp" method="post">
			<button class="logout">Logout</button>
</form>
<p class="loggedin">
		Logged in as <%= session.getAttribute("username")%>
</p>

<div>
Sales report acquired

</div>
	<%
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement st = con.createStatement();
		ResultSet result;
	
		String month = request.getParameter("month") + "";
		if(!month.matches("-?\\d+(\\.\\d+)?")){
			%>
			<div>
				The month has to be a in MM format, <a href="home.jsp">try</a> again. 
		    </div>
			<% 
		}
		else{
			result = st.executeQuery("select sum(totalfare) as revenue from Reservation where extract(month from reservationDate) = '"+month+"' ");
			
			out.println("Month Sales revenue for month "+month+ " is:");
			
			while(result.next()){
				if(result.getString("revenue")==null){
					out.println("$0.00");
				}
				else{
					out.println("$" + result.getString("revenue"));
				}
			} 
		
			result.close();
		}
		con.close();
	}catch(Exception e){
			System.out.println("Query Failed!");
			System.out.println(e);
			out.println("Query Failed! Please retry");
		}	
	
	%>
	
	


</body>
</html>
	