package newpackage;

import java.sql.*;





public class connectionDB {

 String dburl = "jdbc:mysql://localhost:3306/*";
    String username = "*";
    String pass ="*";



public Connection getConnection()   {
    Connection conn = null;
try{
    Class.forName("com.mysql.cj.jdbc.Driver"); 
     conn = DriverManager.getConnection(dburl, username, pass);
   

   System.out.println("connected");
}

catch (Exception ex)    {

System.out.println("error here========================== " + ex);
}
    return conn;
}

public String checkPrivilege(String userID, String password) {
    String check = "";
    String sql = "select * from users where userid='" + userID + "' and password='" + password + "';";
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){

            if(rs.getString("userID").equals(userID) && rs.getString("password").equals(password))  {
               
                check = rs.getString("privilege");
               
                
            }
            else    {
                System.out.println("Invalid");
                check = "Invalid";
            }
        }

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}

public String getJobTitle(String userID, String password) {
    String check = "";
    String sql = "select * from users where userid='" + userID + "' and password='" + password + "';";
    
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){

            if(rs.getString("userID").equals(userID) && rs.getString("password").equals(password))  {
               
                check = rs.getString("job");
                System.out.println("check job here =====" + check);
                
            }
            else    {
                System.out.println("Invalid");
                check = "Invalid";
            }
        }

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}




public boolean checkUser(String userID, String password) {
    boolean check = false;
    String sql = "select * from users where userid='" + userID + "' and password='" + password + "';";
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){

            if(rs.getString("userID").equals(userID) && rs.getString("password").equals(password))  {
                System.out.println("Success log in");
                check = true;
                
            }
            else    {
                System.out.println("Invalid");
                check = false;
            }
        }

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}


public void getStatus(String serialNum, String partNum)   {

    String sql = "select * from pro_procc where serialnumber='" + serialNum + "' and partnumber='" + partNum + "';";
    try{
        Connection connection = getConnection();
        Statement stmt = connection.createStatement();
        ResultSet rs= stmt.executeQuery(sql);
         
 
     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }

}
public int inserttorecord_all(String serialNum, String partNum, String date, String process_step, String param1, String param2, String param3, String user)   {

    String sql = "Insert into record_all (serialnum, partnum, date_time, process_step, param1,param2,param3, users) values (?,?,?,?,?,?,?,?)";
     int updateQuery =0;
    
    try{      
        Connection connection = getConnection();
       PreparedStatement preparedStatement = connection.prepareStatement(sql);

       preparedStatement.setString(1, serialNum);
       preparedStatement.setString(2, partNum);
       preparedStatement.setString(3, date);
       preparedStatement.setString(4, process_step);
       preparedStatement.setString(5, param1);
       preparedStatement.setString(6, param2);
       preparedStatement.setString(7, param3);
       preparedStatement.setString(8, user);
        
     
       updateQuery = preparedStatement.executeUpdate();
         
 
     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


return updateQuery;
}

public int updateStep(String serialNum, String partNum, String date, String user, String curr_step)   {

    String sql = "update pro_procc set date=?, user=?, curr_step=? where serialnumber='" + serialNum + "';";
    String sqlinsert = "insert into finishtable (serialnumber, partnumber, datetime, users) values (?,?,?,?)";
    String deletefrom = "delete from pro_procc where serialnumber='" + serialNum + "';";
     int updateQuery =0;
     int inserttofinish =0;
     
    try{      
        Connection connection = getConnection();
       PreparedStatement preparedStatement = connection.prepareStatement(sql);
       PreparedStatement preparedStatementinsert = connection.prepareStatement(sqlinsert);
       PreparedStatement preparedStatementdelete = connection.prepareStatement(deletefrom);

       preparedStatement.setString(1, date);
       preparedStatement.setString(2, user);
      

        if(curr_step.equals("step1"))   {
            curr_step = "step2";
            preparedStatement.setString(3, curr_step);
            updateQuery = preparedStatement.executeUpdate();
            System.out.println("get updatequery in update proprocc here ====" + updateQuery);

        }
        else if(curr_step.equals("step2"))  {
            curr_step = "step3";
            preparedStatement.setString(3, curr_step);
            updateQuery = preparedStatement.executeUpdate();
            System.out.println("get updatequery in update proprocc here ====" + updateQuery);

        }
        else if(curr_step.equals("step3"))  {
            curr_step = "finish";
            preparedStatement.setString(3, curr_step);
            updateQuery = preparedStatement.executeUpdate();
             System.out.println("get updatequery in update proprocc here ====" + updateQuery);

            preparedStatementinsert.setString(1, serialNum);
            preparedStatementinsert.setString(2, partNum);
            preparedStatementinsert.setString(3, date);
            preparedStatementinsert.setString(4, user);

            inserttofinish = preparedStatementinsert.executeUpdate();
         
            if(inserttofinish>0)    {
                preparedStatementdelete.executeUpdate();
            }

            System.out.println("get inserttofinish in insert finishtable here ====" + inserttofinish);

        }
        
        else {       
            preparedStatement.setString(3, "Something Wrong");
        }
            
       
     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


return updateQuery;
}

public int updateOnHold(String serialNum, String partNum, String status, String date, String curr_step, String reason, String user)   {

    String sql = "insert into onholdtable (serialnumber, partnumber, status, date, curr_step,reason,user) values (?,?,?,?,?,?,?)";
     String sql2 = "update pro_procc set status=?, date=?, user=? where serialnumber='" + serialNum + "';";
    int updateQuery =0;
    int updateQuery2=0;
    try{      
        Connection connection = getConnection();
       PreparedStatement preparedStatement = connection.prepareStatement(sql);
       PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);

       preparedStatement.setString(1, serialNum);
       preparedStatement.setString(2, partNum);
       preparedStatement.setString(3, status);
       preparedStatement.setString(4, date);
       preparedStatement.setString(5, curr_step);
       preparedStatement.setString(6, reason);
       preparedStatement.setString(7, user);

       preparedStatement2.setString(1, status);
       preparedStatement2.setString(2, date);
       preparedStatement2.setString(3, user);

     
       updateQuery = preparedStatement.executeUpdate();
         
       System.out.println("get updatequery in update onholdtable here ====" + updateQuery);

        if(updateQuery>0)   {
            updateQuery2 = preparedStatement2.executeUpdate();
            System.out.println("get updatequery2======" + updateQuery2);
        }
        else{
            System.out.println("Updte to pro_procc table failed");
            updateQuery2=0;
        }

     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


return updateQuery2;
}


public int updateScrap(String serialNum, String partNum, String date, String curr_step, String reason, String user)   {

    String sql = "insert into scraptable (serialnumber, partnumber, datetime, reason, user, curr_step) values (?,?,?,?,?,?)";
     
    String deletefrom = "delete from pro_procc where serialnumber='" + serialNum + "';";
    int updateQuery =0;
    int updateQuery2=0;
    try{      
        Connection connection = getConnection();
       PreparedStatement preparedStatement = connection.prepareStatement(sql);
       PreparedStatement preparedStatement2 = connection.prepareStatement(deletefrom);

       preparedStatement.setString(1, serialNum);
       preparedStatement.setString(2, partNum);
       preparedStatement.setString(3, date);
       preparedStatement.setString(4, reason);
       preparedStatement.setString(5, user);
       preparedStatement.setString(6, curr_step);

     
       updateQuery = preparedStatement.executeUpdate();
         
       System.out.println("get updatequery in update onholdtable here ====" + updateQuery);

        if(updateQuery>0)   {
            updateQuery2 = preparedStatement2.executeUpdate();
            System.out.println("get updatequery2======" + updateQuery2);
        }
        else{
            System.out.println("Updte to pro_procc table failed");
            updateQuery2=0;
        }

     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


return updateQuery2;
}

public int updateInProcess(String serialNum, String partNum, String status, String date, String curr_step, String reason, String user)   {

    String sql = "update onholdtable set status=?,date=?, reason=?,user=? where serialnumber='" + serialNum + "';" ;
     String sql2 = "update pro_procc set status=?, date=?, user=? where serialnumber='" + serialNum + "';";
    int updateQuery =0;
    int updateQuery2=0;
    try{      
        Connection connection = getConnection();
       PreparedStatement preparedStatement = connection.prepareStatement(sql);
       PreparedStatement preparedStatement2 = connection.prepareStatement(sql2);

        preparedStatement.setString(1, "release");
        preparedStatement.setString(2, date);
        preparedStatement.setString(3, reason);
        preparedStatement.setString(4, user);

       preparedStatement2.setString(1, status);
       preparedStatement2.setString(2, date);
       preparedStatement2.setString(3, user);

     
       updateQuery = preparedStatement.executeUpdate();
         
       System.out.println("get updatequery in update onholdtable here ====" + updateQuery);

        if(updateQuery>0)   {
            updateQuery2 = preparedStatement2.executeUpdate();
            System.out.println("get updatequery2======" + updateQuery2);
        }
        else{
            System.out.println("Updte to pro_procc table failed");
            updateQuery2=0;
        }

     }
 
     catch (Exception ex)    {
         System.out.println("Error check here ======"  + ex);
     }


return updateQuery2;
}

public int getCountInprocess() {
    int check = 0;
    String sql = "select count(*) from pro_procc where status='inprocess';";
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){
            
                check = rs.getInt(1);
                
                
        }
            else    {
               
                check = 0;
            }
        

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}

public int getFinish() {
    int check = 0;
    String sql = "select count(*) from finishtable;";
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){
            
            check = rs.getInt(1);   
                
        }
            else    {
               
                check = 0;
            }
        

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}

public int getOnHold() {
    int check = 0;
    String sql = "select count(*) from onholdtable;";
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){
            
            check = rs.getInt(1);     
                
        }
            else    {
               
                check = 0;
            }
        

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}


public int getScrap() {
    int check = 0;
    String sql = "select count(*) from scraptable;";
    try{
       Connection connection = getConnection();
       Statement stmt = connection.createStatement();
       ResultSet rs= stmt.executeQuery(sql);
        
        if(rs.next()){
            
            check = rs.getInt(1);      
                
        }
            else    {
               
                check = 0;
            }
        

    }

    catch (Exception ex)    {
        System.out.println("Error check here ======"  + ex);
    }
    return check;
}


} //end all