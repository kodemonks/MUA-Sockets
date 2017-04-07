<%-- <%@ page errorPage="webError.jsp"%>
 --%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us" xml:lang="en-us">
<head>
<title>Compose EMAIL</title>

<script>
	function validation() {
		var x = document.getElementById("to").value;
		if (!checkID(x)) {
			alert("Incorrect e-mail ID syntax! Please check your input again");
			return false;
		}

		alert("Mail sent!! Loading Inbox")
		return true;
	}
	function checkID(email) {
		var a = /\S+@\S+\.\S+/;
		return a.test(email);
	}
</script>
<style type='text/css'>
body {
	color: white;
	font-family: sans-serif;
	font-size: 25px;
}

.nav {
	background-color: #dd4b39;
	text-align: center;
	width: 200px;
	height: 100%;
	position: fixed;
	top: 0px;
	left: 0px;
}

.button {
	border: none;
	color: white;
	padding: 16px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	-webkit-transition-duration: 0.4s;
	transition-duration: 0.4s;
	cursor: pointer;
}

.button1 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button1:hover {
	background-color: #4CAF50;
	color: white;
}

.button2 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button2:hover {
	background-color: #008CBA;
	color: white;
}

.button3 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button3:hover {
	background-color: #FFC0CB;
	color: white;
}

.button4 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button4:hover {
	background-color: #FFA500;
	color: white;
}

.button5 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 22px;
	color: white;
	border: 2px solid #dd4b39;
}

.button5:hover {
	background-color: #555555;
	color: white;
}

.button6 {
	background-color: #dd4b39;
	font-family: sans-serif;
	font-size: 25px;
	color: white;
	border: 2px solid #dd4b39;
}

.button6:hover {
	background-color: #c0c0c0;
	color: white;
}

.compose {
	text-align: center;
	vertical-align: middle;
	width: auto;
	display: block;
	margin-left: 220px;
	margin-right: auto;
}

#to {
	width: 35em;
	height: 2em;
}

#from {
	width: 35em;
	height: 2em;
}

#subj {
	width: 35em;
	height: 2em;
}
</style>
</head>

<body>
	<%
		if (request.getSession(false).getAttribute("Email") == null) {
			System.out.println("Found null sesison");
	%><jsp:forward page="index.jsp" />
	<%
		}
	%>



	<div class="nav">
		<button class="button button1" onclick="location.href='compose.jsp'">Compose</button>
		<button class="button button2" onclick="location.href='inbox'">Inbox</button>
		<button class="button button5"
			onclick="location.href='/webapp-api/logout'">
			Logout <span style="font-size: 50%; color: white;">(<%=request.getSession().getAttribute("Email")%>)
			</span>
		</button>
	</div>


	<h3>Compose an Email -</h3>
	<div class="compose">

		<form onsubmit="return validation()" action="sendStatus">

			<p>
				<input type="text" id="to" name="to"
					placeholder="TO[comma seaprated]: " required="" />
			</p>
			<p>
				<input id="from" name="from" placeholder="FROM: "
					value="abc@notrequired.com" type="hidden" />
			</p>
			<p>
				<input type="text" id="subj" name="subj" placeholder="SUBJECT: " />
			</p>
			<p>
				<textarea name="msg" rows="15" cols="62"
					placeholder="Enter your message"></textarea>
			</p>

			<p>
				<input type="submit" id="send" name="send" value="Send Email" />
			</p>

			<p>
				<input type="button" id="cancel" name="cancel" value="Cancel"
					onsubmit="Inbox.jsp" />
			</p>
		</form>
	</div>

</body>
</html>
