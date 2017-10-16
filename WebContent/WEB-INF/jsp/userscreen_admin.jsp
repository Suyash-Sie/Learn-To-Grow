<%@page import="com.siemens.learn.model.Risk"%>
<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Welcome</title>
<link rel="shortcut icon" type="image/x-icon" href="/LearnApp/resources/icon/siemensicon.ico" />
<style>
#grad1 {
background: rgba(255,255,255,1);
background: -moz-linear-gradient(left, rgba(255,255,255,1) 0%, rgba(237,237,237,1) 0%, rgba(246,246,246,1) 47%, rgba(246,246,246,1) 100%);
background: -webkit-gradient(left top, right top, color-stop(0%, rgba(255,255,255,1)), color-stop(0%, rgba(237,237,237,1)), color-stop(47%, rgba(246,246,246,1)), color-stop(100%, rgba(246,246,246,1)));
background: -webkit-linear-gradient(left, rgba(255,255,255,1) 0%, rgba(237,237,237,1) 0%, rgba(246,246,246,1) 47%, rgba(246,246,246,1) 100%);
background: -o-linear-gradient(left, rgba(255,255,255,1) 0%, rgba(237,237,237,1) 0%, rgba(246,246,246,1) 47%, rgba(246,246,246,1) 100%);
background: -ms-linear-gradient(left, rgba(255,255,255,1) 0%, rgba(237,237,237,1) 0%, rgba(246,246,246,1) 47%, rgba(246,246,246,1) 100%);
background: linear-gradient(to right, rgba(255,255,255,1) 0%, rgba(237,237,237,1) 0%, rgba(246,246,246,1) 47%, rgba(246,246,246,1) 100%);
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#f6f6f6', GradientType=1 );
}
.btn { display: inline-block; *display: inline; *zoom: 1; padding: 4px 10px 4px; margin-bottom: 0; font-size: 13px; line-height: 18px; color: #333333; text-align: center;text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75); vertical-align: middle; background-color: #f5f5f5; background-image: -moz-linear-gradient(top, #ffffff, #e6e6e6); background-image: -ms-linear-gradient(top, #ffffff, #e6e6e6); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#e6e6e6)); background-image: -webkit-linear-gradient(top, #ffffff, #e6e6e6); background-image: -o-linear-gradient(top, #ffffff, #e6e6e6); background-image: linear-gradient(top, #ffffff, #e6e6e6); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#ffffff, endColorstr=#e6e6e6, GradientType=0); border-color: #e6e6e6 #e6e6e6 #e6e6e6; border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25); border: 1px solid #e6e6e6; -webkit-border-radius: 4px; -moz-border-radius: 4px; border-radius: 4px; -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); cursor: pointer; *margin-left: .3em; }
.btn:hover, .btn:active, .btn.active, .btn.disabled, .btn[disabled] { background-color: #e6e6e6; }
.btn-large { font-size: 14px; line-height: normal; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; }
.btn:hover { color: #333333; text-decoration: none; background-color: #e6e6e6; background-position: 0 -15px; -webkit-transition: background-position 0.1s linear; -moz-transition: background-position 0.1s linear; -ms-transition: background-position 0.1s linear; -o-transition: background-position 0.1s linear; transition: background-position 0.1s linear; }
.btn-primary, .btn-primary:hover { text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25); color: #ffffff; }
.btn-primary.active { color: rgba(255, 255, 255, 0.75); }
.btn-primary { background-color: #4a77d4; background-image: -moz-linear-gradient(top, #6eb6de, #4a77d4); background-image: -ms-linear-gradient(top, #6eb6de, #4a77d4); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#6eb6de), to(#4a77d4)); background-image: -webkit-linear-gradient(top, #6eb6de, #4a77d4); background-image: -o-linear-gradient(top, #6eb6de, #4a77d4); background-image: linear-gradient(top, #6eb6de, #4a77d4); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#6eb6de, endColorstr=#4a77d4, GradientType=0);  border: 1px solid #3762bc; text-shadow: 1px 1px 1px rgba(0,0,0,0.4); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.5); }
.btn-primary:hover, .btn-primary:active, .btn-primary.active, .btn-primary.disabled, .btn-primary[disabled] { filter: none; background-color: #4a77d4; }
</style>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/optimizationBar.js" />">
</script>
<script type="text/javascript" src="<c:url value="/resources/js/jQuery.js" />">
</script>
<script>
function renderCore(idSelector, slider) {
	"use strict";
	var optimizationBarV4 = new OptimizationBar();
	optimizationBarV4.setLeftLabel("Need Attention");
	optimizationBarV4.setRightLabel("Upto the Mark");
	optimizationBarV4.setDomain(100,0);
	optimizationBarV4.setColors(["rgb(255,0,0)", "rgb(255,194,12)", "rgb(160,215,44)"]);
	optimizationBarV4.setShowImage(false);
       
    // To control the layout of opti bar inside riskindicator.
    //optimizationBarV4.setMargin(0,0,0,0);
    optimizationBarV4.setChartMultipliers(0.25, .3);
    var apendee = d3.select(idSelector).node().getBoundingClientRect();
    optimizationBarV4.setDimension(apendee.height, apendee.width);
	optimizationBarV4.setSliderPosition(slider);
	if(idSelector==="#userAdmin_riskIndicator1")
		optimizationBarV4.setSliderText("R7");
	if(idSelector==="#userAdmin_riskIndicator2")
		optimizationBarV4.setSliderText("APPS");
	if(idSelector==="#userAdmin_riskIndicator3")
		optimizationBarV4.setSliderText("SIT");
	if(idSelector==="#userAdmin_riskIndicator4")
		optimizationBarV4.setSliderText("SYSTEC");
	if(idSelector==="#userAdmin_riskIndicator5")
		optimizationBarV4.setSliderText("TDOC");
	if(idSelector==="#userAdmin_riskIndicator6")
		optimizationBarV4.setSliderText("PRM");
	if(idSelector==="#userAdmin_riskIndicator7")
		optimizationBarV4.setSliderText("TE");
	//Draws the risk indicator
	optimizationBarV4.draw(idSelector,false);
	}

var checkClicked = function()
{
	var checked = "";
	var quarter = "";
	if (document.getElementById('r7').checked) 
		checked = checked + "R7;true.";
	else
		checked = checked + "R7;false.";
	if (document.getElementById('r8').checked) 
		checked = checked + "R8;true.";
	else
		checked = checked + "R8;false.";
	if (document.getElementById('sit').checked) 
		checked = checked + "SIT;true.";
	else
		checked = checked + "SIT;false.";
	if (document.getElementById('sys').checked) 
		checked = checked + "SYS;true.";
	else
		checked = checked + "SYS;false.";
	if (document.getElementById('tdoc').checked) 
		checked = checked + "TDOC;true.";
	else
		checked = checked + "TDOC;false";
	if (document.getElementById('prm').checked) 
		checked = checked + "PRM;true.";
	else
		checked = checked + "PRM;false";
		if (document.getElementById('te').checked) 
			checked = checked + "TE;true.";
		else
			checked = checked + "TE;false";
	if (document.getElementById('q1').checked) 
		quarter = quarter + "Q1;true.";
	else
		quarter = quarter + "Q1;false.";
	if (document.getElementById('q2').checked) 
		quarter = quarter + "Q2;true.";
	else
		quarter = quarter + "Q2;false.";
	if (document.getElementById('q3').checked) 
		quarter = quarter + "Q3;true.";
	else
		quarter = quarter + "Q3;false.";
	if (document.getElementById('q4').checked) 
		quarter = quarter + "Q4;true.";
	else
		quarter = quarter + "Q4;false.";
	var riskJson = {"checked": checked, "quarter": quarter}
	$.ajax({
	   	type: 'GET',
		url : '/checkbox',
		contentType: 'application/json; charset=utf-8',
	   	data: riskJson,
	   	async: true,
	   	/* headers: {
            'Access-Control-Allow-Origin': '*'
        },
 */	   	beforeSend: function(x) 
	   	{
            if (x && x.overrideMimeType) 
            {
              	x.overrideMimeType("application/j-son;charset=UTF-8");
            }
        },
	   	success: function(response) 
	   	{
	   		var result = JSON.parse(response);
	   		console.log(result);
	   		renderCore("#userAdmin_riskIndicatorLob", result.lobRisk);
			renderCore("#userAdmin_riskIndicator1", result.r7Risk);
			renderCore("#userAdmin_riskIndicator2", result.r8Risk);
			renderCore("#userAdmin_riskIndicator3", result.sitRisk);
			renderCore("#userAdmin_riskIndicator4", result.sysRisk);
			renderCore("#userAdmin_riskIndicator5", result.tDocRisk);
			renderCore("#userAdmin_riskIndicator6", result.prmRisk);
			renderCore("#userAdmin_riskIndicator7", result.teRisk);
		},
		error:function(exception)
		{
			console.log(exception);
		}
});
};
</script>
</head>
<body id="grad1">
<div style="float: left; width: 75%; height: 23%; position: relative;">
<h4 style="float: left; width: 75%;margin:0px;position: relative">Welcome, <%=request.getAttribute("name")%></h4>
<h3 style="float: left; width: 100%;margin:0px;text-align: center;color: royalblue;font-style: italic;">"Learning is a treasure that will follow its owner everywhere!"</h3>
<div style="float: left; position: relative; width: 100%; height: 85.5%; overflow: hidden; border-bottom:1px solid black;" id="userAdmin_riskIndicatorLob">
</div>
</div>
<div style="float: right; width: calc(25% - 1px); height: 25.8%; position: relative; border-left:1px solid black; border-bottom:1px solid black;">
<form method="post" action="logout">
<input type="submit" class="btn btn-primary btn-large" value="Logout" style="float: right;margin:0px;font-size: 12px;height:25px" />
</form>
<form action="">
<div style="float:left; position: relative;margin-left:10px;margin-right: 10px">
<input type="checkbox" id="r7" name="r7" value="r7" onclick="checkClicked()" checked>R7<br>
<input type="checkbox" id="r8" name="r8" value="r8" onclick="checkClicked()" checked>APPS<br>
<input type="checkbox" id="sit" name="sit" value="sit" onclick="checkClicked()" checked>SIT<br>
</div>
<div style="display:inline-block;position: relative">
<input type="checkbox" id="sys" name="sys" value="sys" onclick="checkClicked()" checked>SYSTEC<br>
<input type="checkbox" id="tdoc" name="tdoc" value="tdoc" onclick="checkClicked()" checked>TDOC<br>
<input type="checkbox" id="prm" name="prm" value="prm" onclick="checkClicked()" checked>PRM<br>
</div>
<div style="display: inline;position: relative"><input type="checkbox" id="te" name="te" value="te" onclick="checkClicked()" checked>TE<br></div>
<br>
<div style="float:left; position:relative;margin-left:10px;margin-right: 10px"><input type="checkbox" id="q1" name="q1" value="q1" onclick="checkClicked()" checked="${checkq1}" readonly="${checkq1}">Q1<br></div>
<div style="float:left; position: relative;margin-left:10px;margin-right: 10px"><input type="checkbox" id="q2" name="q2" value="q2" onclick="checkClicked()" checked="${checkq2}" readonly="${checkq2}">Q2<br></div>
<div style="float:left; position: relative;margin-left:10px;margin-right: 10px"><input type="checkbox" id="q3" name="q3" value="q3" onclick="checkClicked()" checked="${checkq3}" readonly="${checkq3}">Q3<br></div>
<div style="float:left; position: relative;margin-left:10px;margin-right: 10px"><input type="checkbox" id="q4" name="q4" value="q4" onclick="checkClicked()" checked="${checkq4}" readonly="${checkq4}">Q4<br></div>
<a style="color:blue;float: left;position:relative;height:25px;margin-left:10px;margin-top: 20px" href="/LearnApp/downloadExcel">Generate Report</a>
</form>
</div>
<div style="float: left; width: 75%; height: 75%; position: relative;">
	<div style="float: left; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator1">
	</div>
	<div style="float: right; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator2">
	</div>
	<div style="float: left; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator3">
	</div>
	<div style="float: right; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator4">
	</div>
	<div style="float: left; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator5">
	</div>
	<div style="float: right; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator6">
	</div>
	<div style="float: left; position: relative; width: 48%; height: 23%; overflow: hidden;margin:2px;padding:2px"
		id="userAdmin_riskIndicator7">
	</div>
</div>
<div style="position:fixed;right:0px;bottom:0px;overflow:hidden; background-image: url(/LearnApp/resources/image/learn.png);float:right;
background-repeat: no-repeat;width:25%;height:12%;margin:0px;background-position: 100%;display: inline;"></div>
	<script>
	function populateRisks()
	{
		renderCore("#userAdmin_riskIndicatorLob",'${risk.lobRisk}');
		renderCore("#userAdmin_riskIndicator1", '${risk.r7Risk}');
		renderCore("#userAdmin_riskIndicator2", '${risk.r8Risk}');
		renderCore("#userAdmin_riskIndicator3", '${risk.sitRisk}');
		renderCore("#userAdmin_riskIndicator4", '${risk.sysRisk}');
		renderCore("#userAdmin_riskIndicator5", '${risk.tDocRisk}');
		renderCore("#userAdmin_riskIndicator6", '${risk.prmRisk}');
		renderCore("#userAdmin_riskIndicator7", '${risk.teRisk}');
	}
	populateRisks();
	</script>
</body>
<script>
test();
function test(){
	d3.selectAll("image").attr("display","none");
}
</script>
</html>