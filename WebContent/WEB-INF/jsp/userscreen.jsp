<%@page import="java.util.List"%>
<%@page import="com.siemens.learn.model.Target"%>
<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
<html>
<head>
<title>Welcome</title>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/benchmark.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/optimizationBar.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/jQuery.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/js/angular.min.js" />"></script>
</head>
<style>
.dls-comp-table {
	display: table;
	cursor: default;
	margin: 12px 12px 0px 12px;
	width: calc(100% - 24px);
}

.dls-comp-tableHeader {
	display: table-header-group;
	background-color: #39B7CD;
}

.dls-comp-tableHeaderCell {
	display: table-cell;
	width: 5%;
	border-right: 1px solid #d4d4e2;
	height: 35px;
	vertical-align: middle;
	font-weight: bold;
}

.dls-comp-tableDataRow {
	display: table-row-group;
}

.dls-comp-tableDataCell {
	display: table-cell;
	vertical-align: middle;
	border-bottom: #83838c solid 1px;
	background: #ADD8E6;
	opacity: 0.7;
	overflow: hidden;
	text-overflow: ellipsis;
	max-width: 20px;
	white-space: nowrap;
}

.dls-comp-table-row {
	display: table-row;
	vertical-align: top;
	height: 35px;
}

.obs-comp-table {
	display: table;
	width: 100%;
	cursor: default;
}

body {
	font-family: "Lato", sans-serif;
}

@import
	url('https://fonts.googleapis.com/css?family=Open+Sans:400,600,700');

@import
	url('https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css')
	;

*, *:before, *:after {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html, body {
	height: 100vh;
}

body {
	font: 14px/1 'Open Sans', sans-serif;
	color: #555;
	background: #eee;
}

h1 {
	padding: 50px 0;
	font-weight: 400;
	text-align: center;
}

p {
	margin: 0 0 20px;
	line-height: 1.5;
}

main {
	width: 75%;
	padding: 0px;
	margin: 0 auto;
	border-top: 2px solid beige;
	display:inline-block;
}

section {
	display: none;
	padding: 20px 0 0;
	border-top: 1px solid #ddd;
}

label {
	display: inline-block;
	margin: 0 0 -1px;
	padding: 15px 25px;
	font-weight: 600;
	text-align: center;
	color: #bbb;
	border: 1px solid transparent;
}

label:before {
	font-family: fontawesome;
	font-weight: normal;
	margin-right: 10px;
}

label[for*='1']:before {
	content: '\f1cb';
}

label[for*='2']:before {
	content: '\f17d';
}

label[for*='3']:before {
	content: '\f16b';
}

label[for*='4']:before {
	content: '\f1a9';
}

label:hover {
	color: #888;
	cursor: pointer;
}

input:checked+label {
	color: #555;
	border: 1px solid #ddd;
	border-top: 2px solid orange;
	border-bottom: 1px solid #fff;
}

#tab1:checked ~ #content1, #tab2:checked ~ #content2, #tab3:checked ~
	#content3, #tab4:checked ~ #content4 {
	display: block;
}

@media screen and (max-width: 650px) {
	label {
		font-size: 0;
	}
	label:before {
		margin: 0;
		font-size: 18px;
	}
}

@media screen and (max-width: 400px) {
	label {
		padding: 15px;
	}
}
body {
  font-family: "Helvetica Neue", Helvetica, Arial;
  font-size: 14px;
  line-height: 20px;
  font-weight: 400;
  color: #3b3b3b;
  -webkit-font-smoothing: antialiased;
  font-smoothing: antialiased;
  background: beige;
}

.wrapper {
  margin: 0 auto;
  padding: 40px;
  max-width: 800px;
}

.table {
  margin: 0 0 40px 0;
  width: 100%;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
  display: table;
}
@media screen and (max-width: 580px) {
  .table {
    display: block;
  }
}

.row1 {
  display: table-row;
  background: #f6f6f6;
}
.row {
  display: table-row;
  background: #f6f6f6;
}
.row:nth-of-type(odd) {
  background: #e9e9e9;
}
.row1.header {
  font-weight: 900;
  color: #ffffff;
  background: #ea6153;
}
.row1.green {
  background: #27ae60;
}
.row1.blue {
  background: #2980b9;
}
@media screen and (max-width: 580px) {
  .row {
    padding: 8px 0;
    display: block;
  }
}

.cell {
  padding: 6px 12px;
  display: table-cell;
}
@media screen and (max-width: 580px) {
  .cell {
    padding: 2px 12px;
    display: block;
  }
}
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
</style>
<body id="grad1">
<form method="post" action="/LearnApp/logout">
<p style="margin-top:5px;margin-left:5px;margin-bottom:0px">Welcome, <%=request.getAttribute("name")%>
<input type="submit" value="Logout" style="float: right;width:75px;height:25px;margin-top:5px;margin-right:5px" /></p>
</form>
	<div style="position: relative; width: 75%; height: 35%; overflow: hidden;" id="js_chart" align="center"></div>
	<script>
renderCore();
function renderCore() {
	"use strict";
	var ri = new benchMark();
	ri.setTopText("Your Current Quarter Risk");
	ri.setMargin(0,0,0,0);
	var optimizationBarV4 = new OptimizationBar();
	optimizationBarV4.setLeftLabel("HIGH RISK");
	optimizationBarV4.setRightLabel("LOW RISK");
	optimizationBarV4.setDomain(100,0);
	optimizationBarV4.setColors(["rgb(255,0,0)", "rgb(255,194,12)", "rgb(160,215,44)"]);
       
    // To control the layout of opti bar inside riskindicator.
    //optimizationBarV4.setMargin(0,0,0,0);
    var test = {};
  <%--   <%List<Target> targets = ((List<Target>) request.getAttribute("targets"));
			float completed = 0;
			for (Target target : targets) {
				completed += Float.parseFloat(target.getCompletionPercent());
			}%> --%>
<%--     var i = <%=completed / targets.size()%> --%>
	var currRisk = <%=request.getAttribute("currentRisk")%>;
	 try {
			console.log(currRisk.toFixed(2))
				optimizationBarV4.setSliderPosition(currRisk.toFixed(2));
				 optimizationBarV4.setSliderText(currRisk.toFixed(2)+"%"); 
				//ri.setBottomText("YOU: "+currRisk);
		} catch(err) {
			optimizationBarV4.setSliderPosition(Number.NaN);
			console.error(err);
			console.error(err.stack);
		}
		 
	    //Draws the risk indicator
		ri.renderChart(optimizationBarV4,"js_chart");
}

<%-- function deleteRow(){
	<%
    String quarter = request.;
    float completed = 0;
    for(Target target: targets)
    {
    	completed+=Float.parseFloat(target.getCompletionPercent());
    }
    %>
} --%>

function insertRow(id, contentId){
	var table = document.getElementById(id);
	var row = table.getElementsByClassName("row");
	var i=row.length;
	var max=4;
	if (i < max) {
		//var row1 = row[i-1].cloneNode(true); // "deep" clone
		if(id==='myTable1')
			var row1 = $("#myTable1 .dls-comp-tableDataRow:last").clone(true).find('input:first').val('').end().insertAfter("#myTable1 .dls-comp-tableDataRow:last");
		else if(id==='myTable2')
			var row1 = $("#myTable2 .dls-comp-tableDataRow:last").clone(true).find('input:first').val('').end().insertAfter("#myTable2 .dls-comp-tableDataRow:last");
		else if(id==='myTable3')
			var row1 = $("#myTable3 .dls-comp-tableDataRow:last").clone(true).find('input:first').val('').end().insertAfter("#myTable3 .dls-comp-tableDataRow:last");
		else if(id==='myTable4')
			var row1 = $("#myTable4 .dls-comp-tableDataRow:last").clone(true).find('input:first').val('').end().insertAfter("#myTable4 .dls-comp-tableDataRow:last");
		i++;
		row1.id = "myRow" + i; // there can only be one element with an ID
        //row[0].parentNode.appendChild(row1);
		//$("#myTable2").append(row1);
    }
     if (i === max)
     {
     	var contentSec = document.getElementById(contentId);
     	contentSec.getElementsByClassName('insertRow')[0].disabled = true;
     }
}
/* function validate(value) {
   //var outputPercentageString = document.getElementById('completionPercent').value;
    var outputPercentage = parseInt(value);
    if (outputPercentage < 0 || outputPercentage > 100) {
        alert("INVALID INPUT. Please enter the correct percentage.");
        return false;
    }
}
 */
<%-- function tabChange(current){
	console.log(current)
	console.log(current.value)
	if(current.value != "<%=request.getAttribute("currentQuarter")%>")
	{
		$("#formSubmit")[0].disabled = true;
	}else{
		$("#formSubmit")[0].disabled = false;
	}
	
}
 --%></script>
	 <div style="overflow-y: hidden; overflow-x: hidden;">
		<h3 style="text-align: left;margin-bottom:5px; margin-top:20px">Your Targets:</h3>
		<form name="myForm" method="POST" action="submit">
			<main>			
			<input style="display: none;" id="tab1" type="radio" tabindex="1" name="tab" value="Quarter 1" ${quarter=="Quarter 1" ? 'checked' : ''}> <label for="tab1">Quarter 1</label> 
			<input style="display: none;" id="tab2" type="radio" tabindex="2" name="tab" value="Quarter 2" ${quarter=="Quarter 2" ? 'checked' : ''}> <label for="tab2">Quarter 2</label>
		    <input style="display: none;" id="tab3" type="radio" tabindex="3" name="tab" value="Quarter 3" ${quarter=="Quarter 3" ? 'checked' : ''}> <label for="tab3">Quarter 3</label> 
		    <input style="display: none;" id="tab4" type="radio" tabindex="4" name="tab" value="Quarter 4" ${quarter=="Quarter 4" ? 'checked' : ''}> <label for="tab4">Quarter 4</label>
			<section id="content1" ${currentQuarter=="Quarter 1" ? '' : 'readonly'}>
				<div>
					<div class="table" id="myTable1">
						<div class="row1 header blue">
							<div class="cell">
								<span style='color: black;'>Target</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Category</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Competency Level</span>
							</div>
							<div class="cell">
								<span style='color: black;'>%Completion</span>
							</div>
						</div>
						<c:set var="count" value="0" />
						<c:set var="Q" value="${quarter}" />
							<c:forEach var="target" items="${q1}">
								<div class="dls-comp-tableDataRow">
									<div class="row" id="myRow">
										<div id="targetName" class="cell">
											<input name="targetName${count}" type="text"
												value="${target.targetName}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="category" class="cell">
											<input name="category${count}" type="text"
												value="${target.category}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="level" class="cell">
											<input name="level${count}" type="text"
												value="${target.level}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="completionPercent" class="cell">
											<input name="completion${count}" type="number" value="${target.completionPercent}" min="0" max="100" required
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 1" ? '' : 'readonly'}/>
										</div>
									</div>
								</div>
								<c:set var="count" value="${count + 1}" />
							</c:forEach>
						<c:if test="${fn:length(q1)<4}">
							<div class="dls-comp-tableDataRow">
								<div class="row empty">
									<div contenteditable="false" id="targetName" style="width:55%"
										class="cell">
										<input name="targetName3" type="text" style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 1" ? '' : 'readonly'}/>
										<span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="category" style="width:18%"
										class="cell">
										<select	style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Category_list" name="category3" ${currentQuarter=="Quarter 1" ? '' : 'disabled'}>
											<option value="Tools">Tools</option>
											<option value="Technology">Technology</option>
											<option value="Domain">Domain</option>
											<option value="Process">Process</option>
											<option value="Project Management">Project
												Management</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="level" style="width:12"
										class="cell">
										<!-- <input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level3" type="text" list="Level" /> -->
										<select	style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Level_list" name="level3" ${currentQuarter=="Quarter 1" ? '' : 'disabled'}>
											<option value="Basic">Basic</option>
											<option value="Intermediate">Intermediate</option>
											<option value="Advanced">Advanced</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="completionPercent" style="width:15%"
										class="cell">
										<input name="completion3" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											readonly /> <span style='margin: 5px; text-align: left'></span>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<div style="text-align: center;margin-top: 5px;margin-bottom: 10px">
				<c:if test="${fn:length(q1)==4}">
					<button id="btnAdd" style="margin-top: 5px;text-align:center;" type="button"
						disabled="disabled">Add New Row</button>
				</c:if>
				<c:if test="${fn:length(q1)<4}">
					<button id="btnAdd" class="insertRow" style="margin-right: 5px;"
						type="button" onclick="insertRow('myTable1','content1');"  ${currentQuarter=="Quarter 1" ? '' : 'disabled'}>Add
						New Row</button>
				</c:if>
				<input id="formSubmit" type="submit" name="add"	style="display: inline-block;" value="Submit New Targets" ${currentQuarter=="Quarter 1" ? '' : 'disabled'}/>
			</div>
			</section>
			<section id="content2" ${currentQuarter=="Quarter 2" ? '' : 'readonly'}>
				<div>
					<div class="table" id="myTable2">
						<div class="row1 header blue">
							<div class="cell">
								<span style='color: black;'>Target</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Category</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Competency Level</span>
							</div>
							<div class="cell">
								<span style='color: black;'>%Completion</span>
							</div>
						</div>
						<c:set var="count" value="4" />
						<c:set var="Q" value="${quarter}" />
						
							<c:forEach var="target" items="${q2}">
								<div class="dls-comp-tableDataRow">
									<div class="row" id="myRow">
										<div id="targetName" class="cell" style="width:55%">
											<input name="targetName${count}" type="text"
												value="${target.targetName}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="category" class="cell" style="width:18%">
											<input name="category${count}" type="text"
												value="${target.category}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="level" class="cell" style="width:12%">
											<input name="level${count}" type="text"
												value="${target.level}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="completionPercent" class="cell" style="width:15%">
											<input name="completion${count}" type="number" value="${target.completionPercent}" min="0" max="100" required
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 2" ? '' : 'readonly'}/>
										</div>
									</div>
								</div>
								<c:set var="count" value="${count + 1}" />
							</c:forEach>
						
						<c:if test="${fn:length(q2)<4}">
							<div class="dls-comp-tableDataRow">
								<div class="row empty">
									<div contenteditable="false" id="targetName" class="cell" style="width:55%">
										<input name="targetName7" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 2" ? '' : 'readonly'}/>
										<span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="category" class="cell" style="width:18%">
										<select
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Category_list" name="category7" ${currentQuarter=="Quarter 2" ? '' : 'disabled'}>
											<option value="Tools">Tools</option>
											<option value="Technology">Technology</option>
											<option value="Domain">Domain</option>
											<option value="Process">Process</option>
											<option value="Project Management">Project
												Management</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="level" style="width:12%" class="cell">
										<!-- <input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level3" type="text" list="Level" /> -->
										<select
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Level_list" name="level7" ${currentQuarter=="Quarter 2" ? '' : 'disabled'}>
											<option value="Basic">Basic</option>
											<option value="Intermediate">Intermediate</option>
											<option value="Advanced">Advanced</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="completionPercent" style="width:15%" class="cell">
										<input name="completion7" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											disabled /> <span style='margin: 5px; text-align: left'></span>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<div style="text-align: center;margin-top: 5px;margin-bottom: 10px">
				<c:if test="${fn:length(q2)==4}">
					<button id="btnAdd" style="margin-right: 5px" type="button"
						disabled="disabled">Add New Row</button>
				</c:if>
				<c:if test="${fn:length(q2)<4}">
					<button id="btnAdd" class="insertRow" style="margin-right: 5px"
						type="button" onclick="insertRow('myTable2','content2');"  ${currentQuarter=="Quarter 2" ? '' : 'disabled'}>Add
						New Row</button>
				</c:if>
				<input id="formSubmit" type="submit" name="add"	style="display: inline-block;"value="Submit New Targets" ${currentQuarter=="Quarter 2" ? '' : 'disabled'}/>
			</div>
			</section>
			<section id="content3" ${currentQuarter=="Quarter 3" ? '' : 'readonly'}>
				<div>
					<div class="table" id="myTable3">
						<div class="row1 header blue">
							<div class="cell">
								<span style='color: black;'>Target</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Category</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Competency Level</span>
							</div>
							<div class="cell">
								<span style='color: black;'>%Completion</span>
							</div>
						</div>
						<c:set var="count" value="8" />
						<c:set var="Q" value="${quarter}" />
						
							<c:forEach var="target" items="${q3}">
								<div class="dls-comp-tableDataRow">
									<div class="row" id="myRow">
										<div id="targetName" class="cell">
											<input name="targetName${count}" type="text"
												value="${target.targetName}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="category" class="cell">
											<input name="category${count}" type="text"
												value="${target.category}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="level" class="cell">
											<input name="level${count}" type="text"
												value="${target.level}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="completionPercent" class="cell">
											<input name="completion${count}" type="number" value="${target.completionPercent}" min="0" max="100" required
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 3" ? '' : 'readonly'} />
										</div>
									</div>
								</div>
								<c:set var="count" value="${count + 1}" />
							</c:forEach>
						<c:if test="${fn:length(q3)<4}">
							<div class="dls-comp-tableDataRow">
								<div class="row empty">
									<div contenteditable="false" id="targetName" style="width:55%"
										class="cell">
										<input name="targetName11" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 3" ? '' : 'readonly'}/>
										<span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="category" style="width:18%"
										class="cell">
										<select
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Category_list" name="category11" ${currentQuarter=="Quarter 3" ? '' : 'disabled'}>
											<option value="Tools">Tools</option>
											<option value="Technology">Technology</option>
											<option value="Domain">Domain</option>
											<option value="Process">Process</option>
											<option value="Project Management">Project
												Management</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="level" style="width:12%"
										class="cell">
										<!-- <input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level3" type="text" list="Level" /> -->
										<select
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Level_list" name="level11" ${currentQuarter=="Quarter 3" ? '' : 'disabled'}>
											<option value="Basic">Basic</option>
											<option value="Intermediate">Intermediate</option>
											<option value="Advanced">Advanced</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="completionPercent" style="width:15%"
										class="cell">
										<input name="completion11" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											disabled /> <span style='margin: 5px; text-align: left'></span>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<div style="text-align: center;margin-top: 5px;margin-bottom: 10px">
				<c:if test="${fn:length(q3)==4}">
					<button id="btnAdd" style="margin-top: 5px;margin-right: 5px" type="button"
						disabled="disabled">Add New Row</button>
				</c:if>
				<c:if test="${fn:length(q3)<4}">
					<button id="btnAdd" class="insertRow" style="margin-top: 5px;margin-right: 5px"
						type="button" onclick="insertRow('myTable3', 'content3');" ${currentQuarter=="Quarter 3" ? '' : 'disabled'}>Add
						New Row</button>
				</c:if>
				<input id="formSubmit" type="submit" name="add"	style="display: inline-block;" value="Submit New Targets" ${currentQuarter=="Quarter 3" ? '' : 'disabled'}/>
			</div>
			</section>
			<section id="content4" ${currentQuarter=="Quarter 4" ? '' : 'readonly'}>
				<div>
					<div class="table" id="myTable4">
						<div class="row1 header blue">
							<div class="cell">
								<span style='color: black;'>Target</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Category</span>
							</div>
							<div class="cell">
								<span style='color: black;'>Competency Level</span>
							</div>
							<div class="cell">
								<span style='color: black;'>%Completion</span>
							</div>
						</div>
						<c:set var="count" value="12" />
						<c:set var="Q" value="${quarter}" />
							<c:forEach var="target" items="${q4}">
								<div class="dls-comp-tableDataRow">
									<div class="row" id="myRow">
										<div id="targetName" class="cell" style="width:55%">
											<input name="targetName${count}" type="text"
												value="${target.targetName}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="category" class="cell" style="width:18%">
											<input name="category${count}" type="text"
												value="${target.category}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="level" class="cell" style="width:12%">
											<input name="level${count}" type="text"
												value="${target.level}"
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
												readonly />
										</div>
										<div id="completionPercent" class="cell" style="width:15%">
											<input name="completion${count}" type="number" value="${target.completionPercent}" min="0" max="100" required
												style="text-align: left; height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 4" ? '' : 'readonly'}/>
										</div>
									</div>
								</div>
								<c:set var="count" value="${count + 1}" />
							</c:forEach>
					
						<c:if test="${fn:length(q4)<4}">
							<div class="dls-comp-tableDataRow">
								<div class="row empty">
									<div contenteditable="false" id="targetName" style="width:55%"
										class="cell">
										<input name="targetName15" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;" ${currentQuarter=="Quarter 4" ? '' : 'readonly'} />
										<span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="category" style="width:18%"
										class="cell">
										<select
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Category_list" name="category15" ${currentQuarter=="Quarter 4" ? '' : 'disabled'}>
											<option value="Tools">Tools</option>
											<option value="Technology">Technology</option>
											<option value="Domain">Domain</option>
											<option value="Process">Process</option>
											<option value="Project Management">Project
												Management</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="level" style="width:12%"
										class="cell">
										<!-- <input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level3" type="text" list="Level" /> -->
										<select
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											id="Level_list" name="level15" ${currentQuarter=="Quarter 4" ? '' : 'disabled'}>
											<option value="Basic">Basic</option>
											<option value="Intermediate">Intermediate</option>
											<option value="Advanced">Advanced</option>
										</select> <span style='margin: 5px; text-align: left'></span>
									</div>
									<div contenteditable="false" id="completionPercent" style="width:15%"
										class="cell">
										<input name="completion15" type="text"
											style="height: 35px; width: calc(100% - 3px); background: #ADD8E6; opacity: 0.7;"
											disabled /> <span style='margin: 5px; text-align: left'></span>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<div style="text-align: center;margin-top: 5px;margin-bottom: 10px">
				<c:if test="${fn:length(q4)==4}">
					<button id="btnAdd" style="margin-top: 5px;margin-right: 5px" type="button"
						disabled="disabled">Add New Row</button>
				</c:if>
				<c:if test="${fn:length(q4)<4}">
					<button id="btnAdd" class="insertRow" style="margin-top: 5px; margin-right: 5px"
						type="button" onclick="insertRow('myTable4', 'content4');" ${currentQuarter=="Quarter 4" ? '' : 'disabled'}>Add
						New Row</button>
				</c:if>
				<input id="formSubmit" type="submit" name="add" style="display: inline-block;" value="Submit New Targets" ${currentQuarter=="Quarter 4" ? '' : 'disabled'}/>
			</div>
			</section>
			</main>
		</form>
		</div>
</body>
</html>