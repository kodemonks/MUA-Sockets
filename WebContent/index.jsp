<!DOCTYPE html>
<%@ page errorPage="webError.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>

<title>Login</title>

<script type="text/javascript">
	history.pushState(null, null, document.URL);
	window.addEventListener('popstate', function() {
		history.pushState(null, null, document.URL);
	});
</script>

<script type="text/javascript">
	function checkID(email) {
		var a = /\S+@\S+\.\S+/;
		check = a.test(email)
		return check;
	}

	function validation() {
		var x = document.getElementById("mail").value;
		if(x==null|| x=="")
			{
			alert("Email can't be empty!!")
			return false;
			}
		if (!checkID(x)) {
			alert("Incorrect e-mail ID syntax! Please check your input again");
			return false;
		}
	
		var y = document.getElementById("password").value;
		if(y==null||y=="")
		{
		alert("Password can't be empty!!")
		return false;
		}
		
		if (y.length < 8) {
			alert("Password cannot be less than 8 characters");
			return false;
		}

		window.location = "http://localhost:8080/webapp-api/login?mail=" + x
				+ "password=" + y;
		return true;
	}
</script>

<style type='text/css'>
body {
	background-image:
		url("https://www.crucial.com.au/blog/wp-content/uploads/2015/09/google-mail.jpg");
	background-repeat: no-repeat;
	background-position: center center;
	background-attachment: fixed;
	background-size: cover;
}

.Login {
	text-align: center;
	vertical-align: middle;
	background-color: white;
	width: 400px;
	display: block;
	margin-left: auto;
	margin-right: auto;
	opacity: 0.9;
	padding-top: 5px;
	border-style: solid;
	border-color: #336699;
	border-width: 1px;
	padding-left: 3px;
	padding-bottom: 10px;
}

.appform {
	margin: auto;
	width: 400px;
	padding: 10px;
	text-align: center;
}

#mailid {
	width: 25em;
	height: 2em;
	text-align: center;
}

#pass {
	width: 25em;
	height: 2em;
	text-align: center;
}

#submit {
	width: 25em;
	height: 2em;
	text-align: center;
}
#login{
    background-color:  #d1392b; /* Red light */
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
}


</style>
<script>
$("#login").click(function(e){
    e.preventDefault();
    
    //show loading gif
    $(this).closest('form').submit();
});

</script>
</head>

<body>
	<div class="appform">
		<img src='http://i.imgur.com/3YbxHL7.png' alt="A2J2 logo image"
			style="width: 150px" />

		<div class="Login">
			<form onsubmit="return validation()" action="/webapp-api/login"
				method="post">
				<p>
					<input type="text" id="mail" name="mail"
						placeholder="Enter your e-mail ID" />
				</p>
				<p>
					<input type="password" id="password" name="password"
						placeholder="Password" />
				</p>
				<p>
					<input type="submit" value="Login" name="Login" id="login">
				</p>
			</form>
		</div>
	</div>
</body>
</html>