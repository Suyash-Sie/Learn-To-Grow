<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<html>
	<head>
		<title>Hello World</title>
	</head>

	<body>
		<h2>USER SCREEN</h2>
		<h2>Space for risk indicator</h2>
		<h3>Your Targets:</h3>
		<form method="post">
			<table>
      			<tr>
        			<th>S. No.</th>
        			<th>Target</th>
        			<th>Category</th>
        			<th>% Completion</th>
      			</tr>
      			<tr>
        			<th>1</th>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
      			</tr>
      			<tr>
        			<th>2</th>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
      			</tr>
      			<tr>
        			<th>3</th>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
      			</tr>
      			<tr>
        			<th>4</th>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
      			</tr>
      			<tr>
        			<th>5</th>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
        			<th contenteditable="true"/>
      			</tr>
      		</table>
      		<input type="submit" />
      		<button type="button">Update</button>
      		<button type="reset">Cancel</button>
		</form>
	</body>
</html>