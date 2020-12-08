<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Customer Rep Info</title>
<link rel="stylesheet" href="home.css">
</head>

<body>
	
	<form method="post" action="editCustRep.jsp">
	<table> 
      <% 
        try {
            //Get the database connection
            ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement st = con.createStatement();
			ResultSet result;
			
			
			
       		String ssn = request.getParameter("ssn");
            result = st.executeQuery("SELECT * FROM Employee WHERE ssn ='" + ssn + "'");
            
            if(!result.isBeforeFirst()){
				 out.println("There is no customer rep with that SSN.");
				 %>
				 <a href="home.jsp"> Refer back to the Admin Home Page</a>
				 <% 
			}
            
            else{
            	
            
	            while(result.next()) {
	            ssn = result.getString("ssn");	
	            String username = result.getString("username");
	            String firstName = result.getString("firstname");
	           	String lastName = result.getString("lastname");
	     
	            %>
	    	    <p> 
				Please enter the information you would like to edit </p>
				
	            <tr>
				    <td>ssn</td>
				    <td><input type="text" name="ssn" value="<%=ssn %>" required ></td>
			    </tr>
	            <tr>
				    <td>user name</td>
				    <td><input type="text" name="user_name" value="<%=username %>" required ></td>
			    </tr>
			   	    
	            <tr>
				    <td>first name</td>
				    <td><input type="text" name="first_name" value="<%=firstName %>" required ></td>
			    </tr>
			    <tr>
				    <td>last name</td>
				    <td><input type="text" name="last_name" value="<%=lastName %>" required ></td>
			    </tr>	    
			
				<tr>
				    <td><input type="submit" name="btn_update" value="Update" required></td> 
			    </tr>
			    	
			    	<input type="hidden" name="ssn_original" value="<%=ssn %>">
	            <%
	            } 
	            
	            result.close();
	            st.close();
	            con.close();
            }
            
        } catch(Exception e) {
            out.print(e + "<br>");
            out.print("Login failed. Click <a href='login.jsp'>here</a> to return to the login screen.");
        }
    %>
	  </table> 
	  
	 
	  
	 </form>
	
</body>
</html>