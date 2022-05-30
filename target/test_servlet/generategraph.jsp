<%@ page contentType="text" pageEncoding="UTF-8"%>
<%@ page import="newpackage.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>


<%
 
connectionDB allfunction = new connectionDB();
Connection conn = allfunction.getConnection();

Date date = new Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String dates=formatter.format(date);

String getvalue = request.getParameter("parameter1");

Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();

 int getCountinprocess = allfunction.getCountInprocess();
 int getCountfinish = allfunction.getFinish();
 int getCountonhold = allfunction.getOnHold();
 int getCountscrap = allfunction.getScrap();


 String sqlspecific = "select count(*) from finishtable where datetime='" + dates + "';";
 String sqlall = "select count(*) from finishtable;";
    try{
      
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
      

        if(getvalue.equals("today"))    {
             rs= stmt.executeQuery(sqlspecific);
        }
        else if(getvalue.equals("total"))   {
             rs= stmt.executeQuery(sqlall);
        }
  
        if(rs.next())    {
    
            map = new HashMap<Object,Object>(); 
            map.put("label", "Finish"); 
            map.put("y", rs.getInt(1)); 
            list.add(map);

            map = new HashMap<Object,Object>(); 
            map.put("label", "In Process"); 
            map.put("y", getCountinprocess); 
            list.add(map);

            map = new HashMap<Object,Object>(); 
            map.put("label", "On Hold"); 
            map.put("y", getCountonhold);
            list.add(map);

            map = new HashMap<Object,Object>(); 
            map.put("label", "Scrap"); 
            map.put("y", getCountscrap); 
            list.add(map);

            String dataPoints = gsonObj.toJson(list);    
            out.println(dataPoints); 
 
          }
         else{
            System.out.println("Something wrong");    
        }


     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


%>

