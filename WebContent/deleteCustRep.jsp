<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Customer Rep Info</title>
</head>
<body>

<%
	
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement st = con.createStatement();
			
			String ssn,username,password,firstName,lastName;
            String updateSSN = request.getParameter("ssn_original");
            
            //Dealing with deleting whole employee
            String deleteSSN = request.getParameter("deleteEmployee");
        	if(request.getParameter("deleteEmployee")!=null){
        	
	        	PreparedStatement psmt;
	        	psmt=con.prepareStatement("DELETE FROM Employee WHERE ssn = ?");
	        	psmt.setString(1,deleteSSN);
	        	psmt.executeUpdate();
	        	psmt.close();
	            con.close();
	            out.println("Employee has been deleted! Redirecting back to home page");
	            response.setHeader("Refresh", "3;home.jsp"); 
        		
        	}
        	else{
	            if(request.getParameter("user_name").isEmpty()){
	            	username = null;
	            }
	            else{
	            	username= request.getParameter("user_name");
	            }
	            //
	            if(request.getParameter("first_name").isEmpty()){
	            	firstName = null;
	            }
	            else{
	            	firstName= request.getParameter("first_name");
	            }
	            //
	            if(request.getParameter("last_name").isEmpty()){
	            	lastName = null;
	            }
	            else{
	            	lastName= request.getParameter("last_name");
	            }
            
	
            
			    //Create a SQL statement
	            PreparedStatement pstmt;
			    pstmt = con.prepareStatement("UPDATE Employee SET username = ?, firstname = ?, lastname = ? WHERE ssn = ?;");
			    pstmt.setString(1,username);
			    pstmt.setString(2,firstName);
	            pstmt.setString(3,lastName);
	            pstmt.setString(4,updateSSN);
	            pstmt.executeUpdate();
	            out.println("Employee has been updated! Redirecting back to home page");
	            pstmt.close();
	            con.close();
	            response.setHeader("Refresh", "3;home.jsp"); 
        	}

		//}
		//catch(Exception e){
		//		out.println("Error: Query Failed");
		//	out.println(e);
		//}
		
		
	%>
	

</body>
</html>