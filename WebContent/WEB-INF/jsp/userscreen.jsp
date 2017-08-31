<%@page import="java.util.List"%>
<%@page import="com.siemens.learn.model.Target"%>
<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>Hello World</title>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script type="text/javascript" src="<c:url value="/resources/js/optimizationBar.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jQuery.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/angular.min.js" />"></script>
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
@import url('https://fonts.googleapis.com/css?family=Open+Sans:400,600,700');
@import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css');

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
  width: 100%;
  padding: 20px;
  margin: 0 auto;
  background: #fff;
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

label[for*='1']:before { content: '\f1cb'; }
label[for*='2']:before { content: '\f17d'; }
label[for*='3']:before { content: '\f16b'; }
label[for*='4']:before { content: '\f1a9'; }

label:hover {
  color: #888;
  cursor: pointer;
}

input:checked + label {
  color: #555;
  border: 1px solid #ddd;
  border-top: 2px solid orange;
  border-bottom: 1px solid #fff;
}

#tab1:checked ~ #content1,
#tab2:checked ~ #content2,
#tab3:checked ~ #content3,
#tab4:checked ~ #content4 {
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
</style>
<body>
	<div
		style="position: relative; width: 100%; height: 250px; overflow: hidden;"
		id="user_riskIndicator">
	</div>
	<script>
renderCore();

function renderCore() {
	"use strict";
	var optimizationBarV4 = new OptimizationBar();
	optimizationBarV4.setLeftLabel("HIGH RISK");
	optimizationBarV4.setRightLabel("LOW RISK");
	optimizationBarV4.setDomain(0,100);
	optimizationBarV4.setColors(["rgb(255,0,0)", "rgb(255,194,12)", "rgb(160,215,44)"]);
       
    // To control the layout of opti bar inside riskindicator.
    //optimizationBarV4.setMargin(0,0,0,0);
    optimizationBarV4.setChartMultipliers(0.1, 0.5);
    var apendee = d3.select("#user_riskIndicator").node().getBoundingClientRect();
    optimizationBarV4.setDimension(apendee.height, apendee.width);
    var test = {};
    <%
    List<Target> targets = ((List<Target>)request.getAttribute("targets"));
    float completed = 0;
    for(Target target: targets)
    {
    	completed+=Float.parseFloat(target.getCompletionPercent());
    }
    %>
    var i = <%=completed/targets.size()%>
	
		try {
			console.log(i)
				optimizationBarV4.setSliderPosition(i);
				 optimizationBarV4.setSliderText(""); 
		} catch(err) {
			optimizationBarV4.setSliderPosition(Number.NaN);
			console.error(err);
			console.error(err.stack);
		}
		
	    //Draws the risk indicator
	    optimizationBarV4.draw("#user_riskIndicator");
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
	var row = table.getElementsByClassName("dls-comp-table-row");
	var i=row.length;
	var max=3;
	if (i < max) {
		var row1 = row[i-1].cloneNode(true); // "deep" clone
		i++;
		row1.id = "myRow" + i; // there can only be one element with an ID
        row[0].parentNode.appendChild(row1);
    }
     if (i === max)
     {
     	var contentSec = document.getElementById(contentId);
     	contentSec.getElementsByClassName('insertRow')[0].disabled = true;
     }
}

var tabChange = function(tabIndex){
	//var json = {"index" : tabIndex};
	//console.log(json + ': ' + tabIndex);
	if(tabIndex === "1")
		var tab = $('#tab1').val();
	if(tabIndex === "2")
		var tab = $('#tab2').val();
	if(tabIndex === "3")
		var tab = $('#tab3').val();
	if(tabIndex === "4")
		var tab = $('#tab4').val();
	$.ajax({
		   	type: 'POST',
			url : '/LearnApp/radio',
			//contentType: 'application/json; charset=utf-8',
		   	data: "tab=" + tab,
		   //	dataType: 'json',
		   	async: false,
		   	success: function(data) {
		    	console.log('success',data);
		},
		error:function(exception){console.log(exception);}
	});
};

</script>
<div>
	<h3 style="text-align: center">Your Targets:</h3>
	<br/>
	<form method="POST" action="submit">
	<main>
	<input style="display: none;" id="tab1" type="radio" tabindex="1" name="tab" onclick="tabChange('1')" value="Quarter 1" checked>
    <label for="tab1">Quarter 1</label>
    
    <input style="display: none;" id="tab2" type="radio" tabindex="2" onclick="tabChange('2')" name="tab" value="Quarter 2">
    <label for="tab2">Quarter 2</label>
    
    <input style="display: none;" id="tab3" type="radio" tabindex="3" onclick="tabChange('3')" name="tab" value="Quarter 3">
    <label for="tab3">Quarter 3</label>
    
    <input style="display: none;" id="tab4" type="radio" tabindex="4" onclick="tabChange('4')" name="tab" value="Quarter 4">
    <label for="tab4">Quarter 4</label>
	
      
      <section id="content1">
        <div>
          <div class="obs-comp-table" id="myTable1">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Competency Level</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:set var="count" value="0"/>
				<c:set var="Q" value="${quarter}"/>
				<c:if test = "${Q=='Quarter 1'}">	
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row" id="myRow">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
								<input name="targetName${count}" type="text" value="${target.targetName}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">					
								<input name="category${count}" type="text" value="${target.category}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input name="level${count}" type="text" value="${target.level}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
								<input name="completion${count}" type="text" value="${target.completionPercent}" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
						</div>
					</div>
				<c:set var="count" value="${count + 1}"/>
				</c:forEach>
				</c:if>
				<c:if test = "${fn:length(targets)<4}">
				<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row empty">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
							<input name="targetName3" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">
								<!-- <input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Category_list" name="category3" type="text" list="Category" /> -->
							<select style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Category_list" name="category3">       
					            <option value="Tools">Tools</option>
					            <option value="Technology">Technology</option>
					            <option value="Domain">Domain</option>
					            <option value="Process">Process</option>
					            <option value="Project Management">Project Management</option>
					    	</select>
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<!-- <input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level3" type="text" list="Level" /> -->
							<select style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level3">       
								<span style='margin: 5px; text-align: left'></span>
					            <option value="Basic">Basic</option>
					            <option value="Intermediate">Intermediate</option>
					            <option value="Advanced">Advanced</option>
					    	</select>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
							<input name="completion3" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;" disabled/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
					 </div>
				</div>
				</c:if>
			</div>
			</div>
			<c:if test = "${fn:length(targets)==4}">
			<button id="btnAdd" style="margin-top: 5px;" type="button" disabled="disabled">Add New Row</button>
			</c:if>
			<c:if test = "${fn:length(targets)<4}">
			<button id="btnAdd" class="insertRow" style="margin-top: 5px;" type="button" onclick="insertRow('myTable1','content1');">Add New Row</button>
			</c:if>
      </section>
      
      <section id="content2">
        <div>
          <div class="obs-comp-table" id="myTable2">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Competency Level</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:set var="count" value="4"/>
				<c:set var="Q" value="${quarter}"/>
				<c:if test = "${Q=='Quarter 2'}">
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row" id="myRow">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
								<input name="targetName${count}" type="text" value="${target.targetName}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">					
								<input name="category${count}" type="text" value="${target.category}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input name="level${count}" type="text" value="${target.level}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
								<input name="completion${count}" type="text" value="${target.completionPercent}" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
						</div>
					</div>
				<c:set var="count" value="${count + 1}"/>
				</c:forEach>
				</c:if>
				<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row empty">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
							<input name="targetName7" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Category_list" name="category7" type="text" list="Category" />
								<span style='margin: 5px; text-align: left'></span>
							<datalist  id="Category">       
					            <option value="Tools">Tools</option>
					            <option value="Technology">Technology</option>
					            <option value="Domain">Domain</option>
					            <option value="Process">Process</option>
					            <option value="Project Management">Project Management</option>
					    	</datalist>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level7" type="text" list="Level" />
								<span style='margin: 5px; text-align: left'></span>
							<datalist  id="Level">       
					            <option value="Basic">Basic</option>
					            <option value="Intermediate">Intermediate</option>
					            <option value="Advanced">Advanced</option>
					    	</datalist>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
							<input name="completion7" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;" disabled/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
					 </div>
				</div>
			</div>
			</div>
			<button id="btnAdd" class="insertRow" style="margin-top: 5px;" type="button" onclick="insertRow('myTable2','content2');">Add New Row</button>
      </section>
      <section id="content3">
        <div>
          <div class="obs-comp-table" id="myTable3">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Competency Level</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:set var="count" value="8"/>
				<c:set var="Q" value="${quarter}"/>
				<c:if test = "${Q=='Quarter 3'}">
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row" id="myRow">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
								<input name="targetName${count}" type="text" value="${target.targetName}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">					
								<input name="category${count}" type="text" value="${target.category}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input name="level${count}" type="text" value="${target.level}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
								<input name="completion${count}" type="text" value="${target.completionPercent}" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
						</div>
					</div>
				<c:set var="count" value="${count + 1}"/>
				</c:forEach>
				</c:if>
				<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row empty">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
							<input name="targetName11" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Category_list" name="category11" type="text" list="Category" />
								<span style='margin: 5px; text-align: left'></span>
							<datalist  id="Category">       
					            <option value="Tools">Tools</option>
					            <option value="Technology">Technology</option>
					            <option value="Domain">Domain</option>
					            <option value="Process">Process</option>
					            <option value="Project Management">Project Management</option>
					    	</datalist>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level11" type="text" list="Level" />
								<span style='margin: 5px; text-align: left'></span>
							<datalist  id="Level">       
					            <option value="Basic">Basic</option>
					            <option value="Intermediate">Intermediate</option>
					            <option value="Advanced">Advanced</option>
					    	</datalist>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
							<input name="completion11" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;" disabled/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
					 </div>
				</div>
			</div>
			</div>
			<button id="btnAdd" class="insertRow" style="margin-top: 5px;" type="button" onclick="insertRow('myTable3', 'content3');">Add New Row</button>
      </section>
      <section id="content4">
        <div>
          <div class="obs-comp-table" id="myTable4">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Competency Level</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:set var="count" value="12"/>
				<c:set var="Q" value="${quarter}"/>
				<c:if test = "${Q=='Quarter 4'}">
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row" id="myRow">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
								<input name="targetName${count}" type="text" value="${target.targetName}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">					
								<input name="category${count}" type="text" value="${target.category}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input name="level${count}" type="text" value="${target.level}" contenteditable="false" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
								<input name="completion${count}" type="text" value="${target.completionPercent}" style="margin: 5px; text-align: left;height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
							</div>
						</div>
					</div>
				<c:set var="count" value="${count + 1}"/>
				</c:forEach>
				</c:if>
				<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row empty">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
							<input name="targetName15" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Category_list" name="category15" type="text" list="Category" />
								<span style='margin: 5px; text-align: left'></span>
							<datalist  id="Category">       
					            <option value="Tools">Tools</option>
					            <option value="Technology">Technology</option>
					            <option value="Domain">Domain</option>
					            <option value="Process">Process</option>
					            <option value="Project Management">Project Management</option>
					    	</datalist>
							</div>
							<div contenteditable="false" id="level" class="dls-comp-tableDataCell">
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Level_list" name="level15" type="text" list="Level" />
								<span style='margin: 5px; text-align: left'></span>
							<datalist  id="Level">       
					            <option value="Basic">Basic</option>
					            <option value="Intermediate">Intermediate</option>
					            <option value="Advanced">Advanced</option>
					    	</datalist>
							</div>
							<div contenteditable="false" id="completionPercent" class="dls-comp-tableDataCell">
							<input name="completion15" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;" disabled/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
					 </div>
				</div>
			</div>
			</div>
			<button id="btnAdd" class="insertRow" style="margin-top: 5px;" type="button" onclick="insertRow('myTable4','content4');">Add New Row</button>
      </section>
			<div style='text-align: center; margin-top: 10px;'>
				<input type="submit" name="add" value="Submit New Targets" />
			</div>
    </main>
</form>
    

</div>
</body>
</html>