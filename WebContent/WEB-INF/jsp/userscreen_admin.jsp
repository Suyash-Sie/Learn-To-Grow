<%@page import="com.siemens.learn.model.Risk"%>
<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Hello World</title>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/optimizationBar.js" />">
</script>
<script type="text/javascript" src="<c:url value="/resources/js/jQuery.js" />">
</script>
<script>
function renderCore(idSelector, slider) {
	"use strict";
	var optimizationBarV4 = new OptimizationBar();
	optimizationBarV4.setLeftLabel("HIGH RISK");
	optimizationBarV4.setRightLabel("LOW RISK");
	optimizationBarV4.setDomain(0,1);
	optimizationBarV4.setColors(["rgb(255,0,0)", "rgb(255,194,12)", "rgb(160,215,44)"]);
       
    // To control the layout of opti bar inside riskindicator.
    //optimizationBarV4.setMargin(0,0,0,0);
    optimizationBarV4.setChartMultipliers(0.1, 0.5);
    var apendee = d3.select(idSelector).node().getBoundingClientRect();
    optimizationBarV4.setDimension(apendee.height, apendee.width);
	optimizationBarV4.setSliderPosition(slider);
    optimizationBarV4.setSliderText(""); 
	//Draws the risk indicator
	optimizationBarV4.draw(idSelector);
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
		url : '/LearnApp/checkbox',
		contentType: 'application/json; charset=utf-8',
	   	data: riskJson,
	   	async: false,
	   	beforeSend: function(x) 
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
			renderCore("#userAdmin_riskIndicator6", result.lobRisk);
		},
		error:function(exception)
		{
			console.log(exception);
		}
});
};
</script>
</head>
<body>
<div style="float: left; width: 75%; height: 25%; position: relative;">
<div style="float: left; position: relative; width: 100%; height: 100%; overflow: hidden; border-bottom:1px solid black;"
		id="userAdmin_riskIndicatorLob">
	</div>
</div>
<div style="float: right; width: calc(25% - 1px); height: 25%; position: relative; border-left:1px solid black; border-bottom:1px solid black;">
<form action="">
<input type="checkbox" id="r7" name="r7" value="r7" onclick="checkClicked()" checked>R7<br>
<input type="checkbox" id="r8" name="r8" value="r8" onclick="checkClicked()" checked>R8<br>
<input type="checkbox" id="sit" name="sit" value="sit" onclick="checkClicked()" checked>SIT<br>
<input type="checkbox" id="sys" name="sys" value="sys" onclick="checkClicked()" checked>SYSTEC<br>
<input type="checkbox" id="tdoc" name="tdoc" value="tdoc" onclick="checkClicked()" checked>TDOC<br>
<br>
<input type="checkbox" id="q1" name="q1" value="q1" onclick="checkClicked()" checked="${checkq1}" readonly="${checkq1}">Q1<br>
<input type="checkbox" id="q2" name="q2" value="q2" onclick="checkClicked()" checked="${checkq2}" readonly="${checkq2}">Q2<br>
<input type="checkbox" id="q3" name="q3" value="q3" onclick="checkClicked()" checked="${checkq3}" readonly="${checkq3}">Q3<br>
<input type="checkbox" id="q4" name="q4" value="q4" onclick="checkClicked()" checked="${checkq4}" readonly="${checkq4}">Q4<br>
</form>
</div>
<div style="float: left; width: 75%; height: 75%; position: relative;">
	<div style="float: left; position: relative; width: 50%; height: 33%; overflow: hidden;"
		id="userAdmin_riskIndicator1">
	</div>
	<div style="float: right; position: relative; width: 50%; height: 33%; overflow: hidden;"
		id="userAdmin_riskIndicator2">
	</div>
	<div style="float: left; position: relative; width: 50%; height: 33%; overflow: hidden;"
		id="userAdmin_riskIndicator3">
	</div>
	<div style="float: right; position: relative; width: 50%; height: 33%; overflow: hidden;"
		id="userAdmin_riskIndicator4">
	</div>
	<div style="float: left; position: relative; width: 50%; height: 33%; overflow: hidden;"
		id="userAdmin_riskIndicator5">
	</div>
	<div style="float: right; position: relative; width: 50%; height: 33%; overflow: hidden;"
		id="userAdmin_riskIndicator6">
	</div>
</div>
	<script>
	function populateRisks()
	{
		renderCore("#userAdmin_riskIndicatorLob",'${risk.lobRisk}');
		renderCore("#userAdmin_riskIndicator1", '${risk.r7Risk}');
		renderCore("#userAdmin_riskIndicator2", '${risk.r8Risk}');
		renderCore("#userAdmin_riskIndicator3", '${risk.sitRisk}');
		renderCore("#userAdmin_riskIndicator4", '${risk.sysRisk}');
		renderCore("#userAdmin_riskIndicator5", '${risk.tDocRisk}');
		renderCore("#userAdmin_riskIndicator6", '${risk.lobRisk}');
	}
	populateRisks();
	</script>
</body>
</html>