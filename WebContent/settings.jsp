<?xml version="1.0" encoding="UTF-8"?>
<%@ page errorPage="webError.jsp"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us" xml:lang="en-us">
<head>

<title>Settings</title>
<script>
    function validation()
        {
            var x = document.getElementById("mailid").value;
            if(!checkID(x))
                {
                    alert("Incorrect e-mail ID syntax! Please check your input again");
                    return false;
                }
            var y = document.getElementById("passwd").value;
            if(y.length&lt;8)
                {
                    alert("Password cannot be less than 8 characters");
                    return false;   
                }
            return true;
        }
        function checkID(email)
        {
            var a = /\S+@\S+\.\S+/;
            return a.test(email);
        }
    function check()
    {
        var a = document.getElementById("newpass").value();
        if(a.length&lt;8)
        {
            alert("Password cannot be less than 8 characters");
            return false;
        }
        return true;
    }
    </script>
<style type='text/css'>
body {
	background-image:
		url("http://cdn.wonderfulengineering.com/wp-content/uploads/2014/06/gear-wallpaper-11.jpg");
	background-repeat: no-repeat;
	background-position: center center;
	background-attachment: fixed;
	background-size: cover;
}

.Settings {
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
</style>
</head>
<body>

	<div class="Settings">

		<h3>User settings</h3>

		<p>
			<input type="password" id="oldpass" name="oldpass"
				placeholder="Enter your old password" required="" />
		</p>

		<p>
			<input type="password" id="newpass" name="newpass"
				placeholder="Enter your new password" required="" />
		</p>

		<p>
			<input type="button" onclick="return check()" value="OK" />
		</p>

		<hr />

		<h3>Mail settings</h3>

		<p>
			<input type="text" id="mailid" name="mailid"
				placeholder="Enter your e-mail ID" required="" />
		</p>

		<p>
			<input type="password" id="passwd" name="passwd"
				placeholder="Password" required="" />
		</p>

		<p>
			<input type="text" id="server" name="server" placeholder="Server"
				required="" />
		</p>

		<p>
			<input type="text" id="port" name="port" placeholder="Port"
				required="" />
		</p>

		<p>
			<input type="button" onclick="return validation()" value="OK" />
		</p>

		<hr />

		<p>
			<button
				onclick="window.location.href =
                  'http://validator.w3.org/check?uri=' + 
                  window.location.href">Validate
				XHTML</button>
		</p>
		<p>
			<button
				onclick="window.location.href =
                  'http://jigsaw.w3.org/css-validator/validator?uri=' + 
                  window.location.href">Validate
				CSS</button>
		</p>
	</div>

</body>
</html>
