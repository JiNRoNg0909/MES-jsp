<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="newpackage.*"%>
<%@ page import="java.sql.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LOGOUT page</title>
</head>
<body>



<%
connectionDB allfunction = new connectionDB();

Connection connection = allfunction.getConnection();

connection.close();
session.invalidate(); 
response.sendRedirect("index.jsp");

%>









</body>
</html>