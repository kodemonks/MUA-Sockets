<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Login</title>
<script>
        function validation()
        {
            var x = document.getElementById("mailid").value;
        	if(x==null|| x=="")
			{
			alert("Email can't be empty!!")
			return false;
			}
            if(!checkID(x))
                {
                    alert("Incorrect e-mail ID syntax! Please check your input again");
                    return false;
                }
            var y = document.getElementById("passwd").value;
        	if(y==null|| y=="")
			{
			alert("Email can't be empty!!")
			return false;
			}
            if(y.length<8)
                {
                    alert("Password cannot be less than 8 characters");
                    return false;   
                }
            
            window.location = "http://localhost:8080/webapp-api/login?mail="+x+"password="+y; 
            return true;
        }
        function checkID(email)
        {
            var a = /\S+@\S+\.\S+/;
            return a.test(email);
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

#login{
    background-color:  #d1392b; /* red */
    border: none;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
}

</style>
</head>
<body>
	<div class="appform">
		<img src='http://i.imgur.com/3YbxHL7.png' alt="A2J2 logo image"
			style="width: 150px" />
<div class="Login">

			<h1>Invalid login details!</h1>
			<form onsubmit="return validation()" action="/webapp-api/login"
				method="post">
				<p>
					<input type="text" id="mail" name="mail"
						 />
				</p>
				<p>
					<input type="password" id="password" name="password"
						 />
				</p>
				<p>
				<input type="submit" value="Login" name="Login" id="login">
					</p>
			</form>

		</div>
	</div>
</body>
</html>
