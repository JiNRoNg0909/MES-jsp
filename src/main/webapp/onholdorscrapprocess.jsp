<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="newpackage.*"%>
 <%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>


<html>

<%
connectionDB allfunction = new connectionDB();

Date date = new Date();
SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMddHHmmss");
String dates=formatter.format(date);

String userid = (String)session.getAttribute("userid");
String serialnum = (String)session.getAttribute("serialnum");
String partnum = (String)session.getAttribute("partnum");
String status = (String)session.getAttribute("status");
String curr_step = (String)session.getAttribute("curr_step");

String getStatus = request.getParameter("selectionstatus");
String getReason = request.getParameter("reason");
System.out.println("getselection status here =====" + getStatus);
System.out.println("getreason status here =====" + getReason);

int updateQuery = 0;
try{

if(getStatus.equals("onhold"))  {


updateQuery = allfunction.updateOnHold(serialnum, partnum, getStatus, dates, curr_step, getReason, userid);

if(updateQuery>0)   {
    System.out.println("Update success");



    response.sendRedirect("homepage.jsp");
}
else{
    System.out.println("Update failed");
     response.sendRedirect("onhold.jsp");
}
}
else if(getStatus.equals("scrap"))  {

updateQuery = allfunction.updateScrap(serialnum, partnum, dates, curr_step, getReason, userid);

if(updateQuery>0)   {
    System.out.println("Update scrap success");
    response.sendRedirect("homepage.jsp");
}
else{
    System.out.println("Update scrap failed");
     response.sendRedirect("onhold.jsp");
}


}
else if(getStatus.equals("inprocess"))  {
    updateQuery = allfunction.updateInProcess(serialnum, partnum, getStatus, dates, curr_step, getReason, userid);

if(updateQuery>0)   {
    System.out.println("Update inprocess success");


    response.sendRedirect("homepage.jsp");
}
else{
    System.out.println("Update inprocess failed");
     response.sendRedirect("onhold.jsp");
}

}


}


catch (Exception ex)    {
    System.out.println("Get update onhold error" + ex.toString());
}

%>







</html>