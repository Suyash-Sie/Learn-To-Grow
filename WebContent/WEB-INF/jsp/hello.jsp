<%@ page contentType="text/html; charset = UTF-8"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Form</title>
<link rel="shortcut icon" type="image/x-icon" href="/LearnApp/resources/icon/siemensicon.ico" />
<link rel="stylesheet" href="/LearnApp/resources/css/normalize.min.css">
 <style>
 @import url(https://fonts.googleapis.com/css?family=Open+Sans);
.btn { display: inline-block; *display: inline; *zoom: 1; padding: 4px 10px 4px; margin-bottom: 0; font-size: 13px; line-height: 18px; color: #333333; text-align: center;text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75); vertical-align: middle; background-color: #f5f5f5; background-image: -moz-linear-gradient(top, #ffffff, #e6e6e6); background-image: -ms-linear-gradient(top, #ffffff, #e6e6e6); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#e6e6e6)); background-image: -webkit-linear-gradient(top, #ffffff, #e6e6e6); background-image: -o-linear-gradient(top, #ffffff, #e6e6e6); background-image: linear-gradient(top, #ffffff, #e6e6e6); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#ffffff, endColorstr=#e6e6e6, GradientType=0); border-color: #e6e6e6 #e6e6e6 #e6e6e6; border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25); border: 1px solid #e6e6e6; -webkit-border-radius: 4px; -moz-border-radius: 4px; border-radius: 4px; -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.05); cursor: pointer; *margin-left: .3em; }
.btn:hover, .btn:active, .btn.active, .btn.disabled, .btn[disabled] { background-color: #e6e6e6; }
.btn-large { padding: 9px 14px; font-size: 15px; line-height: normal; -webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px; }
.btn:hover { color: #333333; text-decoration: none; background-color: #e6e6e6; background-position: 0 -15px; -webkit-transition: background-position 0.1s linear; -moz-transition: background-position 0.1s linear; -ms-transition: background-position 0.1s linear; -o-transition: background-position 0.1s linear; transition: background-position 0.1s linear; }
.btn-primary, .btn-primary:hover { text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25); color: #ffffff; }
.btn-primary.active { color: rgba(255, 255, 255, 0.75); }
.btn-primary { background-color: #4a77d4; background-image: -moz-linear-gradient(top, #6eb6de, #4a77d4); background-image: -ms-linear-gradient(top, #6eb6de, #4a77d4); background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#6eb6de), to(#4a77d4)); background-image: -webkit-linear-gradient(top, #6eb6de, #4a77d4); background-image: -o-linear-gradient(top, #6eb6de, #4a77d4); background-image: linear-gradient(top, #6eb6de, #4a77d4); background-repeat: repeat-x; filter: progid:dximagetransform.microsoft.gradient(startColorstr=#6eb6de, endColorstr=#4a77d4, GradientType=0);  border: 1px solid #3762bc; text-shadow: 1px 1px 1px rgba(0,0,0,0.4); box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px rgba(0, 0, 0, 0.5); }
.btn-primary:hover, .btn-primary:active, .btn-primary.active, .btn-primary.disabled, .btn-primary[disabled] { filter: none; background-color: #4a77d4; }
.btn-block { width: 100%; display:block; }

* { -webkit-box-sizing:border-box; -moz-box-sizing:border-box; -ms-box-sizing:border-box; -o-box-sizing:border-box; box-sizing:border-box; }

html { width: 100%; height:100%; overflow:hidden; }

body {
	background-image: url("/resources/image/GPG_2544.JPG"); 
	width: 100%;
	height:100%;
	font-family: 'Open Sans', sans-serif;
	-moz-background-size: cover;
-webkit-background-size: cover;
background-size: cover;
background-position: top center !important;
background-repeat: no-repeat !important;
background-attachment: fixed;
}
.login { 
	position: relative;
	top: 50%;
	left: 50%;
	margin: -150px 0 0 -150px;
	width:300px;
	height:300px;
}
.login h1 { color: black;letter-spacing:1px; text-align:center; }
.img {
	margin-top: 10px;
 	margin-right: auto;
 	margin-bottom: 0;
 	margin-left: 20px;
}

input { 
	width: 100%; 
	margin-bottom: 10px; 
	background: #ADD8E6;
	border: none;
	outline: none;
	padding: 10px;
	font-size: 13px;
	color: #ADD8E6;
	text-shadow: 1px 1px 1px white;
	border: 1px solid rgba(0,0,0,0.3);
	border-radius: 4px;
	box-shadow: inset 0 -5px 45px rgba(100,100,100,0.2), 0 1px 1px rgba(255,255,255,0.2);
	-webkit-transition: box-shadow .5s ease;
	-moz-transition: box-shadow .5s ease;
	-o-transition: box-shadow .5s ease;
	-ms-transition: box-shadow .5s ease;
	transition: box-shadow .5s ease;
}
input:focus { box-shadow: inset 0 -5px 45px rgba(100,100,100,0.4), 0 1px 1px rgba(255,255,255,0.2); }
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
</head>
<script>
/* document.getElementById("btnId").addEventListener("click", myFunction);

function myFunction() {
    document.getElementById('btnId').disabled = true;
} */
</script>
<body id="grad1" style="background-image: url(/LearnApp/resources/image/dci.jpg);background-size: cover;">
	<div class="img">
		<img src="/LearnApp/resources/image/logo.png" />
	</div>
	<div class="login" style="top: 20%">
		<h1 style="color: white">Login</h1>
    	<form name="myForm" method="post" action="login">
    		<input type="text" style="color:black" name="gid" placeholder="Username" required="required" />
        	<input type="password" style="color:black" name="password" placeholder="Password" required="required" />
        	<button id="btnId" type="submit" class="btn btn-primary btn-block btn-large">Let me in.</button>
        	<%if(request.getAttribute("message") != null)
        	{	
        	%>
        		<p style="color:white">${message}</p>
        	<%} %>
    	</form>
	</div>
</body>
</html>