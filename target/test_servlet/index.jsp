<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="newpackage.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./cssfile.css" type="text/css" />

<%
connectionDB condb = new connectionDB();
condb.getConnection();
%>

<title>MES page</title>
</head>
<body>

<center>

<div class="login_form">

<div class="login_content">


<div class="login_title">
MES LOGIN
</div>


<form action="checkUsr.jsp" method ="post">

<div class="form-group">
<label class="form-control-label">USERNAME: </label>
<input type="text" name="usr" class="form-control" /><br>
</div>

<div class="form-group">
<label class="form-control-label">PASSWORD: </label>
<input type="password" name="password" class="form-control" /><br>
</div>

<div class="form-group">
<label class="form-control-label">SERVER: </label>
<input type="text" name="server" value="SERVER" class="form-control" /><br>
</div>


<div class="login_button">
<input  class="btn-outline-primary" type="submit" readonly value="LOGIN">
</div>



</form>

</div>

</div> 











</center>


</body>
</html>