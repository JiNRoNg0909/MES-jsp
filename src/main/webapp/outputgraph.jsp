<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 <%@ page import="newpackage.*"%>
<%

connectionDB allfunction = new connectionDB();
allfunction.getConnection();

 String userid = session.getAttribute("userid").toString();
 String getprivilege = session.getAttribute("getprivilege").toString();
 String getjob = session.getAttribute("getjob").toString();

 int getCountinprocess = allfunction.getCountInprocess();
 int getCountfinish = allfunction.getFinish();
 int getCountonhold = allfunction.getOnHold();
 int getCountscrap = allfunction.getScrap();


Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
 
map = new HashMap<Object,Object>(); 
map.put("label", "In Process"); 
map.put("y", getCountinprocess); 
list.add(map);

map = new HashMap<Object,Object>(); 
map.put("label", "Finish"); 
map.put("y", getCountfinish); 
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

%>
 
<!DOCTYPE HTML>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet" href="./adminhome.css" type="text/css" />

 <!-- Boxicons CDN Link -->
 <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>

<title>Graph page</title>

<script type="text/javascript">
window.onload = function() { 
 
 CanvasJS.addColorSet("setColor",
                [//colorSet Array

                "#00ABFA",
                "#1FFE00",
                "#FEA600",
                "#FE0000"                            
                ]);

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	title:{
		text: "Output Finalize"
	},
	colorSet:  "setColor",
	legend: {
		verticalAlign: "center",
		horizontalAlign: "right"
	},
	data: [{
		type: "pie",
		showInLegend: true,
		indexLabel: "{label}: {y}",
		indexLabelPlacement: "outside",
		legendText: "{label}: {y}",
		toolTipContent: "<b>{label}</b>: {y}",
		dataPoints : <%out.print(dataPoints);%>
	}]
});
chart.render();
 
}
</script>
</head>
<body>


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
        <a href="outputgraph.jsp">
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

        <p class="floatleft">Data Analysis</p>
    
        </div>

  <form name="myform" method="post,get">
  <label for="sort">Sort by:</label>
  <select name="sort" id="sort" onchange="return generate()">
    <option value=""></option>
    <option value="today">Today</option>
    <option value="total">Total</option>
   
  </select>
  <br><br>
 
  </form>




        <div id="chartContainer" style="height: 370px; width: 100%;"></div>
  </section>



<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>


<script>
function generate() {

var select = document.getElementById('sort');
var value = select.options[select.selectedIndex].value;
console.log(value); // en


var http;
 if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
    http=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
    http=new ActiveXObject("Microsoft.XMLHTTP");
    }

  http.open("POST", "generategraph.jsp", true);
  http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  var params = "parameter1=" + value;
  http.send(params);
  http.overrideMimeType("application/json");

try{

  http.onload = function() {
    
    var jsonResponse = JSON.parse(http.responseText);

CanvasJS.addColorSet("setColor",
                [//colorSet Array

                "#00ABFA",
                "#1FFE00",
                "#FEA600",
                "#FE0000"                            
                ]);

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	title:{
		text: "Output Finalize"
	},
	colorSet:  "setColor",
	legend: {
		verticalAlign: "center",
		horizontalAlign: "right"
	},
	data: [{
		type: "pie",
		showInLegend: true,
		indexLabel: "{label}: {y}",
		indexLabelPlacement: "outside",
		legendText: "{label}: {y}",
		toolTipContent: "<b>{label}</b>: {y}",
		dataPoints : jsonResponse
	}]
});
chart.render();





  };

}
catch(e)  {
  console.log("get error here============" + e);
}
}

</script>







</body>
</html>  