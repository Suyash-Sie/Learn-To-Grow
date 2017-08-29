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

/* Style the tab */
div.tab {
	overflow: hidden;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
div.tab button {
	background-color: inherit;
	float: left;
	border: none;
	outline: none;
	cursor: pointer;
	padding: 14px 16px;
	transition: 0.3s;
	font-size: 17px;
}

/* Change background color of buttons on hover */
div.tab button:hover {
	background-color: #ddd;
}

/* Create an active/current tablink class */
div.tab button.active {
	background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
	display: none;
	padding: 6px 12px;
	border: 1px solid #ccc;
	border-top: none;
}
/* .tablinks {
	float: left;
	padding: 5px 10px 5px 10px;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
	margin: 0px 5px 0px 5px;
} */

#tab1, #tab2, #tab3, #tab4 {
	float: left;
	padding: 5px 10px 5px 10px;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
	margin: 0px 5px 0px 5px;
}

#tab1:hover, #tab2:hover, #tab3:hover, #tab4:hover {
	background-color: #ddd;
}

#tab1Content, #tab2Content, #tab3Content, #tab4Content {
	padding: 20px;
	border: none;
}

#tab1Content {
	display: block;
}

#tab2Content, #tab3Content, #tab4Content {
	display: none;
}
body{
  padding     : 1.5em;
  background  : #f8f8f8;
  font-family : sans-serif;
  line-height : 1.5;
}

.tabbed{
  float : left;
  width : 100%;
}

.tabbed > input{
  display : none;
}

.tabbed > section > h1{
  float       : left;
  box-sizing  : border-box;
  margin      : 0;
  padding     : 0.5em 0.5em 0;
  overflow    : hidden;
  font-size   : 1em;
  font-weight : normal;
}

.tabbed > input:first-child + section > h1{
  padding-left : 1em;
}

.tabbed > section > h1 > label{
  display                 : block;
  padding                 : 0.25em 0.75em;
  border                  : 1px solid #ddd;
  border-bottom           : none;
  border-top-left-radius  : 4px;
  border-top-right-radius : 4px;
  box-shadow              : 0 0 0.5em rgba(0,0,0,0.0625);
  background              : #fff;
  cursor                  : pointer;
     -moz-user-select     : none;
      -ms-user-select     : none;
  -webkit-user-select     : none;
}

.tabbed > section > div{
  position      : relative;
  z-index       : 1;
  float         : right;
  box-sizing    : border-box;
  width         : 100%;
  margin        : 2.5em 0 0 -100%;
  padding       : 0.5em 0.75em;
  border        : 1px solid #ddd;
  border-radius : 4px;
  box-shadow    : 0 0 0.5em rgba(0,0,0,0.0625);
  background    : #fff;
}

.tabbed > input:checked + section > h1{
  position : auto;
  z-index  : 2;
}

.tabbed > input:not(:checked) + section > div{
  display : none;
}
</style>
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

function insertRow(){
	var row = document.getElementById("myRow");
	var i=document.getElementsByClassName("dls-comp-table-row").length;
	var max=5;
	if (i < max + 1) {
		i++;
		var row1 = row.cloneNode(true); // "deep" clone
		row1.id = "myRow" + i; // there can only be one element with an ID
        row.parentNode.appendChild(row1);
        if (i > max) document.getElementById('btnAdd').disabled = true;
    }
}
</script>
<div>
	<h3>Your Targets:</h3>
	
	<!-- <div id="tab1" onClick="JavaScript:selectTab(1);">Quarter 1</div>
	<div id="tab2" onClick="JavaScript:selectTab(2);">Quarter 2</div>
	<div id="tab3" onClick="JavaScript:selectTab(3);">Quarter 3</div>
	<div id="tab4" onClick="JavaScript:selectTab(4);">Quarter 4</div> -->
	<!-- <div class="tab">
  		<button class="tablinks" onClick="JavaScript:selectTab(event,'Quarter1');">Quarter1</button>
  		<button class="tablinks" onClick="JavaScript:selectTab(event,'Quarter2');">Quarter2</button>
  		<button class="tablinks" onClick="JavaScript:selectTab(event,'Quarter3');">Quarter3</button>
  		<button class="tablinks" onClick="JavaScript:selectTab(event,'Quarter4');">Quarter4</button>
	</div>
	<br /> -->
	<form method="POST" action="userscreen/submit">
	<div class="tabbed">
      <input name="tabbed1" id="tabbed1" type="radio" checked>
      <section>
        <h1>
          <label for="tabbed1">Quarter 1</label>
        </h1>
        <div>
          <div class="obs-comp-table" id="myTable">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row" id="myRow">
							<div contenteditable="false" id="targetName" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.targetName}</span>
							</div>
							<div contenteditable="false" id="category" class="dls-comp-tableDataCell">					
							
								<span style='margin: 5px; text-align: left'>${target.category}</span>
							</div>
							<div contenteditable="true" id="completionPercent" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.completionPercent}</span>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row" id="myRow">
							<div contenteditable="true" id="targetName" class="dls-comp-tableDataCell">
							<input name="targetName" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="true" id="category" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'></span>
								<input style="height:35px; width: calc(100% - 3px);background: #ADD8E6;
	opacity: 0.7;" id="Category_list" name="category" type="text" list="Category" />
							<datalist  id="Category">       
					            <option value="Tools">Tools</option>
					            <option value="Technology">Technology</option>
					            <option value="Domain">Domain</option>
					            <option value="Process">Process</option>
					            <option value="Project Management">Project Management</option>
					    	</datalist>
							</div>
							<div contenteditable="true" id="completionPercent" class="dls-comp-tableDataCell">
							<input name="completionPercent" type="text" style="height:35px; width: calc(100% - 3px);background: #ADD8E6; opacity: 0.7;"/>
								<span style='margin: 5px; text-align: left'></span>
							</div>
					 </div>
				</div>
			</div>
			<button id="btnAdd" style="margin-top: 5px;" type="button" onclick="insertRow();">Add New Row</button>
			<div style='text-align: center; margin-top: 10px;'>
				<input type="submit" name="add" value="Submit New Targets"/>
				<input type="submit" name="update" value="Update completion percentage"/>
			</div>
			</div>
      </section>
      <input name="tabbed2" id="tabbed2" type="radio">	
      <section>
        <h1>
          <label for="tabbed2">Quarter 2</label>
        </h1>
        <div>
        <div class="obs-comp-table">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row">
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.targetName}</span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.category}</span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.completionPercent}</span>
							</div>
						</div>
					</div>
				</c:forEach>
				<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row">
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'></span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'></span>
							</div>
					 </div>
				</div>
			</div>
			<button id="btnAdd" style="margin-top: 5px;" type="button" onclick="insertRow();">Add New Row</button>
			<div style='text-align: center; margin-top: 10px;'>
				<input type="submit" />
				<button type="button">Update</button>
				<button type="reset">Cancel</button>
			</div>
			</div>
      </section>
      <input name="tabbed3" id="tabbed3" type="radio">
      <section>
        <h1>
          <label for="tabbed3">Quarter 3</label>
        </h1>
        <div>
        <div class="obs-comp-table">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row">
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.targetName}</span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.category}</span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.completionPercent}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<button id="btnAdd" style="margin-top: 5px;" type="button" onclick="insertRow();">Add New Row</button>
			<div style='text-align: center; margin-top: 10px;'>
				<input type="submit" />
				<button type="button">Update</button>
				<button type="reset">Cancel</button>
			</div>
			</div>
      </section>
      <input name="tabbed4" id="tabbed4" type="radio">
      <section>
        <h1>
          <label for="tabbed4">Quarter 4</label>
        </h1>
        <div>
        <div class="obs-comp-table">
				<div class="dls-comp-tableHeader">
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Target</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>Category</span>
					</div>
					<div class="dls-comp-tableHeaderCell">
						<span style='margin-left: 5px'>%Completion</span>
					</div>
				</div>
				<c:forEach var="target" items="${targets}">
					<div class="dls-comp-tableDataRow">
						<div class="dls-comp-table-row">
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.targetName}</span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.category}</span>
							</div>
							<div contenteditable="true" class="dls-comp-tableDataCell">
								<span style='margin: 5px; text-align: left'>${target.completionPercent}</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<button id="btnAdd" style="margin-top: 5px;" type="button" onclick="insertRow();">Add New Row</button>
			<div style='text-align: center; margin-top: 10px;'>
				<input type="submit" />
				<button type="button">Update</button>
				<button type="reset">Cancel</button>
			</div>
			</div>
      </section>
    </div>
</form>
</div>
</body>
</html>