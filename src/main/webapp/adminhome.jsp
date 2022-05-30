<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="newpackage.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./adminhome.css" type="text/css" />
 <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<title>Admin Home page</title>

<%
connectionDB condb = new connectionDB();
condb.getConnection();
%>
</head>
<body>
<%
       Date date = new Date();
       SimpleDateFormat formatter = new SimpleDateFormat("E yyyy.MM.dd 'at' HH:mm:ss a");
       String dates=formatter.format(date);

       session.setAttribute("userid", session.getAttribute("userid"));
%>
  <div class="sidebar">
    <div class="logo-details">
      <i class='bx bxl-c-plus-plus icon'></i>
        <div class="logo_name">CodingLab</div>
        <i class='bx bx-menu' id="btn" ></i>
    </div>
    <ul class="nav-list">
   
      <li>
        <a href="#">
          <i class='bx bx-grid-alt'></i>
          <span class="links_name">Dashboard</span>
        </a>
         <span class="tooltip">Dashboard</span>
      </li>
       <li class="profile">
        <div class="profile-details">
          <!--<img src="profile.jpg" alt="profileImg">-->
          <div class="name_job">
            <div class="name"><%=session.getAttribute("userid")%></div>
            <div class="job">Admin</div>
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
        <p class="floatright"><%=session.getAttribute("userid")%></p>
        <p class="floatleft">MES Check Unit</p>
        <button class="buttonradius" onclick="location.href ='logout.jsp';" id ="">Logout</button>
        </div>

        <div class="container">

          <form name="myform" method ="post" action="mainmain.jsp">
          <label class="">SerialNumber: </label>
          <input type="text" name="serialNum" /><br>
          <label class="">PartNumber: </label>
          <input type="text" name="partNum" /><br>
          <p id ="1"></p>
          
          <input type="button" onclick="return take_value()" value="submit">
          </form>
          </div>



  </section>


</body>

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
function take_value() {
  var serial = document.forms["myform"]["serialNum"].value;
  var part = document.forms["myform"]["partNum"].value;
console.log("get serial here" + serial);
console.log("get part here" + part);

var http;
 if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    http=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    http=new ActiveXObject("Microsoft.XMLHTTP");
    }

  http.open("POST", "getdata.jsp", true);
  http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  var params = "parameter1=" + serial + "&parameter2=" + part;
 http.send(params);
 http.overrideMimeType('text/xml');
try{

  http.onreadystatechange = function() {

        if (this.readyState == 4) {
                   
          //  document.getElementById("1").innerHTML = http.responseText;
            var some=http.responseXML.documentElement;
 //document.getElementById("1").innerHTML= "Serialnum : " + some.getElementsByTagName("serialnum")[0].childNodes[0].nodeValue;

if(some.getElementsByTagName("exist")[0].childNodes[0].nodeValue =="EXIST")  {

//document.getElementById("param3").disabled = true;
 document.forms["myform"].submit();

}
else{

 document.getElementById("1").innerHTML = "Invalid ID";
return false;
}
}

  };

}
catch(e)  {
  console.log("get error here============" + e);
}
}
</script>



</html>