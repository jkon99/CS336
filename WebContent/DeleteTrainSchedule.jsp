<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Train Schedule Info</title>
</head>
<body>

<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement st = con.createStatement();
			
			String transitLineName, trainID, originStationID, destinationStationID, arrivalDatetime, departDatetime, tripType, fixedFare;
			String updatetransitLineName = request.getParameter("transitname_original");
			String updatetrainID = request.getParameter("trainID_original");
			String updateoriginStationID = request.getParameter("originID_original");
			String updatedestinationStationID = request.getParameter("destID_original");
			
            
            String deletetransitLineName = request.getParameter("deleteTLN");
            String deletetrainID = request.getParameter("deleteSchedule");
            String deleteoriginStationID = request.getParameter("deleteoriginID");
            String deletedestinationStationID = request.getParameter("deletedestID");
        	if(request.getParameter("deleteSchedule")!=null){
        	
	        	PreparedStatement stsmt;
	        	stsmt=con.prepareStatement("DELETE FROM Schedule WHERE transitLineName= ? and trainID = ? and originStationID = ? and destinationStationID = ?");
	        	stsmt.setString(1,deletetransitLineName);
	        	stsmt.setString(2, deletetrainID);
	        	stsmt.setString(3,deleteoriginStationID);
	        	stsmt.setString(4, deletedestinationStationID);
	        	stsmt.executeUpdate();
	        	stsmt.close();
	        	con.close();
	        	out.println("Train Schedule has been deleted. You will now be redirected to the home page.");
	        	response.setHeader("Refresh", "3;home.jsp");
        	}
        	else{
        		transitLineName = request.getParameter("transitLineName");
        		trainID = request.getParameter("trainID");
        		originStationID = request.getParameter("originStationID");
        		destinationStationID = request.getParameter("destinationStationID");

        		
	            if(request.getParameter("arrival_Datetime").isEmpty()){
	            	arrivalDatetime = "NULL";
	            }
	            else {
	            	arrivalDatetime = request.getParameter("arrival_Datetime");
	            }
	            //
	            if(request.getParameter("depart_Datetime").isEmpty()){
	            	departDatetime = "NULL";
	            }
	            else {
	            	departDatetime = request.getParameter("depart_Datetime");
	            }
	           //
	            if(request.getParameter("trip_Type").isEmpty()){
	            	tripType= "NULL";
	            }
	            else{
	            	tripType = request.getParameter("trip_Type");
	            }
	           //
	           if(request.getParameter("fixed_fare").isEmpty()){
	        	   fixedFare = "NULL";
	           }
	           else{
	        	   fixedFare = request.getParameter("fixed_fare");
	           
	           }
			    //Create a SQL statement
	            PreparedStatement pstmt;
			    pstmt = con.prepareStatement("UPDATE Schedule SET transitLineName = ?, trainID = ?, originStationID = ?, destinationStationID = ?, arrivalDatetime = ?, departDatetime = ?, tripType = ?, fixedFare = ? WHERE transitLineName = ? and trainID = ? and originStationID = ? and destinationStationID = ?");
			    pstmt.setString(1,transitLineName);
			    pstmt.setString(2,trainID);
	            pstmt.setString(3,originStationID);
	            pstmt.setString(4,destinationStationID);
	            pstmt.setString(5,arrivalDatetime);
	            pstmt.setString(6,departDatetime);
	            pstmt.setString(7,tripType);
	            pstmt.setString(8,fixedFare);
	            pstmt.setString(9,updatetransitLineName);
	            pstmt.setString(10,updatetrainID);
	            pstmt.setString(11,updateoriginStationID);
	            pstmt.setString(12,updatedestinationStationID);
	            pstmt.executeUpdate();
	            out.println("Train Schedule has been updated! You will now be redirected back to the home page");
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
