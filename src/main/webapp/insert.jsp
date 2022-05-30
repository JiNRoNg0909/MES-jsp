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

String getstep = request.getParameter("step");
String serialNum = request.getParameter("serialNum");
String partNum = request.getParameter("partNum");

int updateQuery = 0;
int updateStepCount = 0;
try{


if(getstep.equals("step1")) {
    String param1 = request.getParameter("param1");
    String param2 = request.getParameter("param2");
    String param3 = request.getParameter("param3");

     updateQuery = allfunction.inserttorecord_all(serialNum, partNum, dates, getstep, param1, param2, param3, userid);
    System.out.println("get updatequery output ======" + updateQuery);

    
}
else if(getstep.equals("step2"))    {
     String param1 = request.getParameter("param1");
    String param2 = request.getParameter("param2");

    updateQuery = allfunction.inserttorecord_all(serialNum, partNum, dates, getstep, param1, param2, null, userid);
    System.out.println("get updatequery output ======" + updateQuery);


}
else if(getstep.equals("step3"))    {
     

    updateQuery = allfunction.inserttorecord_all(serialNum, partNum, dates, getstep, null, null, null, userid);
    System.out.println("get updatequery output ======" + updateQuery);


}


    if (updateQuery > 0)    {

        System.out.println("get serialnum" + serialNum);
        System.out.println("get dates" + dates);
        System.out.println("get userid" + userid);
        System.out.println("get getstep" + getstep);

        updateStepCount = allfunction.updateStep(serialNum, partNum, dates, userid, getstep);
        
        if(updateStepCount > 0)  {
            System.out.println("Update to pro process success");
            response.sendRedirect("homepage.jsp");
        }
         else    {
        System.out.println("Update to pro process failed");
        response.sendRedirect("mainmain.jsp");
         }


    }

else    {
    response.sendRedirect("mainmain.jsp");
    System.out.println("Insert fail to record");
}



}

catch (Exception ex)    {
    System.out.println("Getting insert error here =====" + ex.toString());
}
%>




</html>