<%@page import="java.util.List"%>
<%@page import="com.siemens.learn.model.Target"%>
<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Hello World</title>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/optimizationBar.js" />"></script>
<script>
function renderCore(idSelector, slider) {
	"use strict";
	var optimizationBarV4 = new OptimizationBar();
	optimizationBarV4.setLeftLabel("HIGH RISK");
	optimizationBarV4.setRightLabel("LOW RISK");
	optimizationBarV4.setDomain(0,100);
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

var checkClicked = function(checkIndex){
	//var json = {"index" : tabIndex};
	//console.log(json + ': ' + tabIndex);
	if(checkIndex === "1")
		var check = $('#check1').val();
	//if(checkIndex === "2")
		//var tab = $('#tab2').val();
	//if(checkIndex === "3")
		//var tab = $('#tab3').val();
	//if(checkIndex === "4")
		//var tab = $('#tab4').val();
	$.ajax({
		   	type: 'POST',
			url : '/LearnApp/checkbox',
			//contentType: 'application/json; charset=utf-8',
		   	data: "check=" + check,
		   //	dataType: 'json',
		   	async: false,
		   	success: function(data) {
		    	console.log('success',data);
		},
		error:function(exception){console.log(exception);}
	});
};
</script>
</head>

<!-- <script>
function selectTab(evt, quarter) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(quarter).style.display = "block";
    evt.currentTarget.className += " active";
}
	/* function selectTab(tabIndex) {
		//Hide All Tabs
		document.getElementById('tab1Content').style.display = "none";
		document.getElementById('tab2Content').style.display = "none";
		document.getElementById('tab3Content').style.display = "none";
		document.getElementById('tab4Content').style.display = "none";

		//Show the Selected Tab
		document.getElementById('tab' + tabIndex + 'Content').style.display = "block";
	} */
</script> -->
<body>
<div style="float: left; width: 75%; height: 25%; position: relative;">
<div style="float: left; position: relative; width: 100%; height: 100%; overflow: hidden; border-bottom:1px solid black;"
		id="userAdmin_riskIndicatorLob">
	</div>
</div>
<div style="float: right; width: calc(25% - 1px); height: 25%; position: relative; border-left:1px solid black; border-bottom:1px solid black;">
<form action="">
<input type="checkbox" id="check1" name="r7" value="r7" onclick="checkClicked('1')">R7<br>
<input type="checkbox" name="r8" value="r8">R8<br>
<input type="checkbox" name="sit" value="Bike">SIT<br>
<input type="checkbox" name="sys" value="Car">SYSTEC<br>
<input type="checkbox" name="tdoc" value="Bike">TDOC<br>
<input type="checkbox" name="lob" value="Car">LOB<br>
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
	renderCore("#userAdmin_riskIndicatorLob",50);
	renderCore("#userAdmin_riskIndicator1", 0);
	renderCore("#userAdmin_riskIndicator2", 25);
	renderCore("#userAdmin_riskIndicator3",35);
	renderCore("#userAdmin_riskIndicator4", 45);
	renderCore("#userAdmin_riskIndicator5", 55);
	renderCore("#userAdmin_riskIndicator6", 75);
	</script>
</body>
</html>