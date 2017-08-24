<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<title>Hello World</title>
	</head>

	<body>
		<h2>USER SCREEN</h2>
		<h2>Space for risk indicator</h2>
		<h3>Your Targets:</h3>
		<form method="POST">
			<table>
				<thead>
        			<tr>
        				<th>Target</th>
        				<th>Category</th>
        				<th>% Completion</th>
      				</tr>
    			</thead>
       			<c:forEach var="target" items="${targets}">
		            <tr>
		                <td>${target.targetName}</td>
		                <td>${target.category}</td>
		                <td>${target.completionPercent}</td>
		            </tr>       
		        </c:forEach>
      		</table>
      		<input type="submit" />
      		<button type="button">Update</button>
      		<button type="reset">Cancel</button>
		</form>
	</body>
</html>