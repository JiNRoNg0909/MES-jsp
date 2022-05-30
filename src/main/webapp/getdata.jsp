<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="newpackage.*"%>
<%@ page import="java.sql.*"%>
<html>
<%



response.setContentType("text/xml");
connectionDB allfunction = new connectionDB();
Connection conn = allfunction.getConnection();
String serialNum = request.getParameter("parameter1");
String partNum = request.getParameter("parameter2");
System.out.println("get from serial and part ======" + serialNum + partNum);
out.println(serialNum +"this ++===" + partNum);

session.setAttribute("userid", session.getAttribute("userid"));

 String sql = "select * from pro_procc where serialnumber='" + serialNum + "' and partnumber='" + partNum + "';";
    try{
        allfunction.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs= stmt.executeQuery(sql);
        if(rs.next())    {

            out.println("<exist>" + "EXIST"+ "</exist>");
           
          // out.println("<serialnum>" + rs.getString(1) + "</serialnum>");
           // out.println("<partnum>" + rs.getString(2) + "</partnum>");
           // out.println("<status>" + rs.getString(3) + "</status>");
           // out.println("<curr_step>" + rs.getString(6) + "</curr_step>");

          

            session.setAttribute("serialnum",rs.getString(1)); 
            session.setAttribute("partnum",rs.getString(2)); 
            session.setAttribute("status",rs.getString(3)) ;
            session.setAttribute("curr_step",rs.getString(6)); 
        }
    else{
            out.println("<exist>" + "Invalid ID"+ "</exist>");
        //    out.println("<serialnum>" + "Invalid ID" + "</serialnum>");
         //   out.println("<partnum>" + "Invalid ID" + "</partnum>");
          //  out.println("<status>" + "Invalid ID" + "</status>");
           // out.println("<curr_step>" + "Invalid ID" + "</curr_step>");

    }


 
     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


%>

</html>