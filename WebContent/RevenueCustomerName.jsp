<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Customer Revenue</title>
<link rel="stylesheet" href="home.css">
</head>


<body>
<form action="logout.jsp" method="post">
	<button class= "logout"> Logout</button>
	</form>
<p class="loggedin">
	Logged in as <%=session.getAttribute("username") %>
	</p>

<%
try{
ApplicationDB db= new ApplicationDB();
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet result;

String customername = request.getParameter("customername") + "";

result = st.executeQuery("select sum(totalfare)as revenue from Reservation where username ='"+customername+"'");
out.println("Revenue per "+customername+" is:");


while(result.next()){
	if(result.getString("revenue")==null){
		out.println("$o.oo");
	}
	else{
		out.println("$" + result.getString("revenue"));
	}
}

con.close();

}catch(Exception e){
	System.out.println("Query failed!");
	System.out.println(e);
	out.println("Query failed! Please retry");
}
%>

</body>
</html>
