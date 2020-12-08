<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Customer Rep Info</title>
</head>
<body>

<%
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement st = con.createStatement();
			ResultSet result;
			
			String username = request.getParameter("customerRepUser");
			String password = request.getParameter("password");
			String firstname = request.getParameter("firstName");
			String lastname = request.getParameter("lastName");
			String ssn = request.getParameter("SSN");
			
			result = st.executeQuery("SELECT * FROM Employee where ssn='"+ssn+"' ");
			
			if(result.next()){
				 out.println("A customer rep with that SSN already exists");
				 %>
				 <a href="home.jsp">Refer back to the Admin Home Page</a>
				 <% 
			}
			 else {
		        	String insertQuery = "INSERT INTO Employee VALUES('" + username + "', '" + password + "', '" + firstname + "', '" + lastname + "', '" + ssn + "')";
		           // out.print(insertQuery + "<br>");
		            st.executeUpdate(insertQuery);
		            out.println("Successfully added the employee! Redirecting back to home page");
		            response.setHeader("Refresh", "3;home.jsp"); 
		            
		        }
			result.close();
			st.close();
			con.close();

					
		}catch(Exception e){
			out.print("Account creation failed.");
	        out.print(e);
		}
	
	
	%>
	
</body>
</html>
