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
            String deletetrainID = request.getParameter("deletetrainID");
            String deleteoriginStationID = request.getParameter("deleteoriginID");
            String deletedestinationStationID = request.getParameter("deletedestID");
        	if(request.getParameter("deleteTLN")!= null){
	        	PreparedStatement stsmt;
	        	stsmt=con.prepareStatement("DELETE FROM Schedule WHERE transitLineName= ? and trainID = ? and originStationID = ? and destinationStationID = ?");
	        	stsmt.setString(1,deletetransitLineName);
	        	stsmt.setInt(2, Integer.valueOf(deletetrainID));
	        	stsmt.setInt(3, Integer.valueOf(deleteoriginStationID));
	        	stsmt.setInt(4, Integer.valueOf(deletedestinationStationID));
	        	System.out.println(stsmt);
	        	stsmt.executeUpdate();
	        	stsmt.close();
	        	con.close();
	        	out.println("Train Schedule has been deleted. You will now be redirected to the home page.");
	        	response.setHeader("Refresh", "3;home.jsp");
        	}
        	else{
	            if(request.getParameter("arrival_Datetime").isEmpty()){
	            	arrivalDatetime = null;
	            }
	            else {
	            	arrivalDatetime = request.getParameter("arrival_Datetime");
	            }
	            //
	            if(request.getParameter("depart_Datetime").isEmpty()){
	            	departDatetime = null;
	            }
	            else {
	            	departDatetime = request.getParameter("depart_Datetime");
	            }
	           //
	            if(request.getParameter("trip_Type").isEmpty()){
	            	tripType= null;
	            }
	            else{
	            	tripType = request.getParameter("trip_Type");
	            }
	           //
	           if(request.getParameter("fixed_fare").isEmpty()){
	        	   fixedFare = "0";
	           }
	           else{
	        	   fixedFare = request.getParameter("fixed_fare");
	           
	           }
			    //Create a SQL statement
	            PreparedStatement pstmt;
			    pstmt = con.prepareStatement("UPDATE Schedule SET arrivalDatetime = ?, departDatetime = ?, tripType = ?, fixedFare = ? WHERE transitLineName = ? and trainID = ? and originStationID = ? and destinationStationID = ?");
	            pstmt.setString(1,arrivalDatetime);
	            pstmt.setString(2,departDatetime);
	            pstmt.setString(3,tripType);
	            pstmt.setDouble(4,Double.valueOf(fixedFare));
	            pstmt.setString(5,updatetransitLineName);
	            pstmt.setInt(6,Integer.valueOf(updatetrainID));
	            pstmt.setInt(7,Integer.valueOf(updateoriginStationID));
	            pstmt.setInt(8,Integer.valueOf(updatedestinationStationID));
	            System.out.println(pstmt);
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
