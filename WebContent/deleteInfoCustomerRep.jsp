<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Customer Rep Info</title>
<link rel="stylesheet" href="home.css">
</head>

<body>
	
	 
	<form method="post" action="deleteCustRep.jsp">
	<table> 
      <% 
        try {
            //Get the database connection
            ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement st = con.createStatement();
			
			
       		String ssn = request.getParameter("ssn");
       		//error check for SSN
       		
            ResultSet result = st.executeQuery("SELECT * FROM Employee WHERE ssn ='" + ssn + "';");
           
       		
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
				Choose the fields you want to delete and leave them blank
			   </p>
	            <tr>
				    <td>user name</td>
				    <td><input type="text" name="user_name" value="<%=username %>"></td>
			    </tr>
			   	    
	            <tr>
				    <td>first name</td>
				    <td><input type="text" name="first_name" value="<%=firstName %>"></td>
			    </tr>
			    <tr>
				    <td>last name</td>
				    <td><input type="text" name="last_name" value="<%=lastName %>"></td>
			    </tr>	    
			
				<tr>
				    <td><input type="submit" name="btn_update" value="Update"></td> 
			    </tr>
			   	
	            <%
	            }
            
            
            
	            result.close();
	            st.close();
	            con.close();
	            %>
	
		      	  </table> 
		      	  <input type="hidden" name="ssn_original" value="<%=ssn%>">
		      	 </form>
		      	 
		      	 <h2>
		      	  Delete a Customer Rep from the System! (If you wish to delete the SSN, use this button)
		      	 </h2>
					
		      	 <form method="post" action="deleteCustRep.jsp">
		      	 	 <div class="flex-container">
		      	 	 	<input type="submit" value="Delete Employee">
		      	 	 	<span>
		      		 		<input type="text" name="deleteEmployee" value="<%=ssn%>">
		      	 	 	</span>
		      	 	 </div>
		         </form> 
	            
	            <%
            } 
            
        } catch(Exception e) {
            out.print(e + "<br>");
            out.print("Login failed. Click <a href='login.jsp'>here</a> to return to the login screen.");
        }
    	%>
	 
	 
	
</body>
</html>