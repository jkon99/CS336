<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Customer Rep Info</title>
</head>
<body>

<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement st = con.createStatement();
			
			String ssn,username,password,firstName,lastName;
            String updateSSN = request.getParameter("ssn_original");
            
            ssn = request.getParameter("ssn");
            username = request.getParameter("user_name");
            password = request.getParameter("password");
            firstName = request.getParameter("first_name");
            lastName = request.getParameter("last_name");
            
		    //Create a SQL statement
            PreparedStatement pstmt;
		    pstmt = con.prepareStatement("UPDATE Employee SET username = ?, firstname = ?, lastname = ?, ssn = ?  WHERE ssn = ?;");
		    pstmt.setString(1,username);
		    pstmt.setString(2,firstName);
            pstmt.setString(3,lastName);
            pstmt.setString(4,ssn);
            pstmt.setString(5,updateSSN);
            pstmt.executeUpdate();
            out.println("Employee has been updated! Redirecting back to home page");
            pstmt.close();
            con.close();
            response.setHeader("Refresh", "3;home.jsp"); 

		}
		catch(Exception e){
			out.println("Error: Query Failed");
			out.println(e);
		}
		
		
	%>
	

</body>
</html>

	
		
		