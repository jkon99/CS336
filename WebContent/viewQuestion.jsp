<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>QA Service</title>
<link rel="stylesheet" href="home.css">
</head>
<body>
	<div>
		<% 
		
		try{
			System.out.println("Testing Session");
			session.getAttribute("username").equals("");
			}catch(Exception e){ 
				System.out.println("Invalid Session");
				System.out.println(e);
			%>	
				<div class="errorMessage">
					Your session has expired, please <a href="employeeLogin.jsp">login</a> again. 
				</div>
			<% 	
				return;
			}
		%>
		
	</div>
	
	
	<h1 class="title">
		Train Reservation System
	</h1>

		<div>
		<h2>
			Browse questions/answers
			</h2>
<%
    try
    {
    	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String query = "select * from Question;";

		System.out.println(query);
		Statement stmt = con.createStatement();
		ResultSet result = stmt.executeQuery(query);
    %><table border=1 align=center style="text-align:center">
      <thead>
          <tr>
             <th>Questions</th>
             <th>Answers</th>
          </tr>
      </thead>
      <tbody>
        <%while(result.next())
        {
            %>
            <tr>
                <td><%=result.getString("question") %></td>
                <td><%=result.getString("answer") %></td>
            </tr>
            <%}%>
           </tbody>
        </table><br>
    <%con.close();}
    catch(Exception e){
        out.print(e.getMessage());%><br><%
    }
	
    %>
	
	
	</div>
	<div>
		<h2>
			Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
