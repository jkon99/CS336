<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Customer Rep Info</title>
</head>
<body>

	<h1>
		<b>Please enter the customer representative's information you want to add into the database</b>
	</h1>
	
	<br>
	
	<form method="post" action="addCustRep.jsp">
	
		<table>
		
			<tr>
				<td>Customer Representative User</td>
				<td><input type="text" name="customerRepUser" required></td>
			</tr>
			
			<tr>
				<td>Password</td>
				<td><input type="text" name="password" required></td>
			</tr>
			
			<tr>
				<td>First Name</td>
				<td><input type="text" name="firstName" required ></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" name="lastName" required ></td>
			</tr>
			<tr>
				<td>SSN</td>
				<td><input type="text" name="SSN" required ></td>
			</tr>
		</table>
		
		<br> <input type="submit" value="submit">
		
	</form>

</body>
</html>