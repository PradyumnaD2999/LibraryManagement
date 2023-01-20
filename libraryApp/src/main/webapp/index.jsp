<!-- Login Page -->

<html>
<body style="background-color: #c5d9ed;">
<% String failAuth = (String) request.getAttribute("loginFail");
if(failAuth == null) { %>
	<form action="getLogin" method="post">
	  <div>
	    <label for="user"><b>Username</b></label>
	    <input type="text" pattern="[0-9]+" placeholder="Enter Username" name="user" required>
		<br/>
		<br/>
	    <label for="pwd"><b>Password</b></label>
	    <input type="password" placeholder="Enter Password" name="pwd" required>
	    <br/>
	    <br/>
	    <label for="type"><b>User Type</b></label>
	    <select name="type" required>
		  <option value="Member">Member</option>
		  <option value="Librarian">Librarian</option>
		</select>
		<br/>
		<br/>
	    <button type="submit">Login</button>
	  </div>
	</form>

<!-- Login Fail -->
<% } else { %>
	<form action="failAck" method="get">
		<b>
			<% 
				out.println(failAuth);
			%>
		</b>
		<button type="submit">OK</button>
	</form>
<% } %>
</body>
</html>
