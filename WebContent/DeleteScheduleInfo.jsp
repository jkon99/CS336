<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Train Schedule Info</title>
<link rel="stylesheet" href="home.css">
</head>

<body>
	
	 
	<form method="post" action="DeleteTrainSchedule.jsp">
	<table> 
      <% 
        try {
            //Get the database connection
            ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement st = con.createStatement();
			
			
       		String transitLineName = request.getParameter("transitLineName");
       		String trainID = request.getParameter("trainID");
       		String originStationID = request.getParameter("originStationID");
       		String destinationStationID = request.getParameter("destinationStationID");
       	
       		
            ResultSet result = st.executeQuery("SELECT * from Schedule where trainID ='" + trainID + "' and transitLineName = '" + transitLineName +"' and originStationID = '"+ originStationID + "' and destinationStationID ='" +destinationStationID+"'");
           	
       		
       		if(!result.isBeforeFirst()){
				 out.println("There is no train schedule with those attributes.");
				 %>
				 <a href="home.jsp"> Refer back to the Admin Home Page</a>
				 <% 
			}
       		
            else{
				
	            while(result.next()) {
		            transitLineName = result.getString("transitLineName");	
		            trainID = result.getString("trainID");
		            originStationID = result.getString("originStationID");
		            destinationStationID = result.getString("destinationStationID");
		            String arrivalDatetime = result.getString("arrivalDatetime");
		            String departDatetime = result.getString("departDatetime");
		           	String tripType = result.getString("tripType");
		           	String fixedFare = result.getString("fixedFare");
	     
	            %>
	           <p>
				Choose the fields you want to delete and leave them blank
				</p>
			    <tr>
			    <td> Arrival Date Time </td>
			    <td><input type="text" name ="arrival_Datetime"	value ="<%=arrivalDatetime %>"></td>
				</tr>
				<tr>
				<td> Depart Date Time </td>
				<td><input type="text" name="depart_Datetime" value="<%=departDatetime %>"></td>
				</tr>
				<tr>
				<td> Trip Type </td>
				<td><input type="text" name="trip_Type" value="<%=tripType %>"></td>
				</tr>
				<tr>
				<td> Fixed Fare </td>
				<td><input type="text" name ="fixed_fare" value="<%=fixedFare %>"></td>
				</tr>
				<tr>
				    <td><input type="submit" name="btn_update" value="Update"></td> 
			    </tr>
			    <tr>
				<td><input type ="hidden" name="transitname_original" value="<%=transitLineName%>"></td>
				</tr>
				<tr>
				<td><input type="hidden" name="trainID_original" value="<%=trainID%>"></td>
				</tr>
				<tr>
				<td><input type= "hidden" name="originID_original" value="<%=originStationID %>"></td>
				</tr>
				<tr>
				<td><input type="hidden" name="destID_original" value="<%=destinationStationID %>"></td>
				</tr>
			    	
	         <%
	            }
            
            
            
	            result.close();
	            st.close();
	            con.close();
	            %>
	
		      	  </table> 
		      	  
		      	 </form>
		      	 
		      	 <h2>
		      	  Delete a Train Schedule from the System
		      	 </h2>
					<p>
						If you would like to delete Transit Line name or TrainID or originStation ID or destinationStation ID, you will have to delete the whole train Schedule.
					</p>
		      	 <form method="post" action="DeleteTrainSchedule.jsp">
		      	 	 <div class="flex-container">
		      	 	 	<input type="submit" value="Delete Train Schedule">
		      	 	 	<span>
		      		 		<input type="hidden" name="deleteTLN" value="<%=transitLineName%>">
		      		 		<input type="hidden" name="deletetrainID" value="<%=trainID%>">
		      	 	 		<input type="hidden" name="deletedestID" value="<%=destinationStationID%>">
		      	 	 		<input type="hidden" name="deleteoriginID" value="<%=originStationID%>">
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
