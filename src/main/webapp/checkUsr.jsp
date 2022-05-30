<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="newpackage.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>checkuser page</title>
</head>

<body>



<%
connectionDB allfunction = new connectionDB();

String userid = request.getParameter("usr");
String password = request.getParameter("password");


boolean check = allfunction.checkUser(userid, password);

if (check) { 
    session.setAttribute("userid",userid); 
    String getprivilege = allfunction.checkPrivilege(userid, password);
    String getjob = allfunction.getJobTitle(userid, password);

    session.setAttribute("getprivilege",getprivilege); 
    session.setAttribute("getjob",getjob); 

   // if(check2.equals("f"))  {
     //   response.sendRedirect("adminhome.jsp");
   // }
   // else if(check2.equals("o")) {
   
     response.sendRedirect("homepage.jsp");
  //  }


}
else    {   
    System.out.println("invalid user or password");

    response.sendRedirect("index.jsp");
}

%>



</body>
</html>