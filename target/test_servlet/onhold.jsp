<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="newpackage.*"%>
 <%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <link href="adminhome.css" type="text/css" rel="stylesheet" />
 <!-- Boxicons CDN Link -->
 <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<%
connectionDB condb = new connectionDB();
condb.getConnection();

%>
<title>on hold or scrap page</title>
</head>
<body>
<%
         Date date = new Date();
        
String userid = (String)session.getAttribute("userid");
String serialnum = (String)session.getAttribute("serialnum");
String partnum = (String)session.getAttribute("partnum");
String status = (String)session.getAttribute("status");
String curr_step = (String)session.getAttribute("curr_step");

String getprivilege = session.getAttribute("getprivilege").toString();
String getjob = session.getAttribute("getjob").toString();


%>

<div class="sidebar">
    <div class="logo-details">
       <i class='bx bxs-label icon'></i>
        <div class="logo_name">MES</div>
        <i class='bx bx-menu' id="btn" ></i>
    </div>
    <ul class="nav-list">
   
      <li>
        <a href="homepage.jsp">
          <i class='bx bx-grid-alt'></i>
          <span class="links_name">Dashboard</span>
        </a>
         <span class="tooltip">Dashboard</span>
      </li>

<%
if (getprivilege.equals("f")) {
%>

<li>
        <a href="#">
          <i class='bx bx-pie-chart-alt-2' ></i>
          <span class="links_name">Output</span>
        </a>
         <span class="tooltip">Output</span>
      </li>

<%
}
%>

       <li class="profile">
        <div class="profile-details">
          <!--<img src="profile.jpg" alt="profileImg">-->
          <div class="name_job">
            <div class="name"><%=userid%></div>
            <div class="job"><%=getjob%></div>
          </div>
        </div>
        <i class='bx bx-log-out' onclick="location.href ='logout.jsp';" id="log_out" ></i>
    </li>

    </ul>
  </div>

 <section class="home-section">

<div class="topnav">
<a class="floatleft" href="homepage.jsp">
            <img src="https://cdn.shopify.com/s/files/1/0467/8660/9318/files/Tokimeku_Tag_Tokimeku_Logo_480x480.png?v=1620028225" class="paddingimg" alt="tokimeku" style="width:200px;height:75px;">
          </a>
<p class="floatleft">Change Status</p>
</div>
<div class="container">

<form name="submitonhold" action="onholdorscrapprocess.jsp" method ="post">
SerialNumber :<input type="text" name="serialNum" value="<%=serialnum%>" readonly/><br>
PartNumber :<input type="text" name="partNum" value="<%=partnum%>" readonly/><br>
Status :<input type="text" name="status" value="<%=status%>" readonly/><br>
Step :<input type="text" name="step" value="<%=curr_step%>" readonly/><br>

  <label for="status">Status:</label>
  <select id="status" name="selectionstatus">
    <option value="onhold">On Hold</option>
    <option value="scrap">Scrap</option>
     <option value="inprocess">InProcess</option>
  </select>
<br>
<label for="reason">Reason:</label>
<textarea id="reason" name="reason" rows="4" cols="50">
</textarea>

<input type="button" onClick="submitform()" value="Submit">
<input type="button" onClick="goBack()" value="Back">
</form>

</div>
  </section>

<script>
let sidebar = document.querySelector(".sidebar");
let closeBtn = document.querySelector("#btn");
let searchBtn = document.querySelector(".bx-search");

closeBtn.addEventListener("click", ()=>{
  sidebar.classList.toggle("open");
  menuBtnChange();//calling the function(optional)
});

searchBtn.addEventListener("click", ()=>{ // Sidebar open when you click on the search iocn
  sidebar.classList.toggle("open");
  menuBtnChange(); //calling the function(optional)
});

// following are the code to change sidebar button(optional)
function menuBtnChange() {
 if(sidebar.classList.contains("open")){
   closeBtn.classList.replace("bx-menu", "bx-menu-alt-right");//replacing the iocns class
 }else {
   closeBtn.classList.replace("bx-menu-alt-right","bx-menu");//replacing the iocns class
 }
}


</script>


<script>

  function goBack(){
       window.location = 'mainmain.jsp';
   }

function submitform() {
   document.forms["submitonhold"].submit();
}



</script>



</body>
</html>