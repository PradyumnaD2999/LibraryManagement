<!-- Dashboard for Member and Librarian -->

<%@ page import="com.libapp.model.Member"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="com.libapp.model.Librarian"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
</head>
<body style="background-color: #c5d9ed;">

<!-- Session Meta Data for Member/Librarian -->
	<% 
		String userType = (String) request.getAttribute("type");
		Member memData = new Member();
		Librarian libData = new Librarian();
		if(userType.equals("Member")) {
			memData = (Member)request.getAttribute("userData");
		} else {
			libData = (Librarian)request.getAttribute("userData");
		}
	%>

<!-- Logout and Home -->
	<form id="home" action="home" method="post">
		<% if(userType.equals("Member")) { %>
		    	<input type="hidden" value="<%=memData%>" name="userData" />
		   <%	} else { %>
		    	<input type="hidden" value="<%=libData%>" name="userData" />
		    <%	} %>
		<input type="hidden" value="<%=userType%>" name="type" />
		<a style="text-align: left;" href="javascript:{}" onclick="document.getElementById('home').submit();">Dashboard</a>
	</form>
		
	<form id="logout" action="logout" method="get">
		<a href="javascript:{}" onclick="document.getElementById('logout').submit();">Log out</a>
	</form>
	<br/>
	
	<div style="font-size: 150%;">
	<b>
	<%
    	if(userType.equals("Member")) {
    		out.println("Welcome " + memData.getFirstname() + "!");
    %>
    </b>
    </div>
    		<br/>
    		<br/>
    		<b style="font-size:150%;">Your Details and Summary:</b>
    		<br/>
    		<br/>
    		
    		<div style="font-size: 120%">
    <%
    		out.println("Member ID: " + memData.getMid());
    %>
    		<br/>
	<%	    out.println("Name: " + memData.getFirstname() + " " + memData.getLastname());
	%>
    		<br/>
	<%	    out.println("Books Borrowed: " + memData.getBorrowCount());
	%>
    		<br/>
	<%	    out.println("Late Fees: " + memData.getLatefees() + "$");
    %>	
    		<br/>	
    		</div>
    		
    		
    <%		if(memData.getReturnDate() == null) {
 	%>			
 				<br/>
 				<br/>
    			<form action="return" method="get">
	    			<input type="hidden" value="<%=memData%>" name="userData" />
	    			<input type="hidden" value="<%=userType%>" name="type" />
	    			<label for="returnButton"><b>Return Borrowed Document</b></label>
	    			<button type="submit" name="button" value="return">Return</button>
	    		</form>
	<%   		if(Date.valueOf(LocalDate.now()).after(memData.getDueDate())) {
    %>				
    				<b>Your currently borrowed document is overdue!</b>>
    <%			}
    %>
    <%		} else{
    %>
    			<br/>
    			<br/>
    			<b>We can read you like a book! Feel free to borrow from our collection!</b>
    <%		}
    	} else {
    		out.println("Welcome " + libData.getFirstname() + "!");
    %>
    
    		<br/>
    		<br/>
    		<b style="font-size:100%;">Your Details:</b>
    		<br/>
    		<br/>
    		
    		<div style="font-size: 75%">
    <%
    		out.println("Member ID: " + libData.getLid());
    %>
    		<br/>
	<%	    out.println("Name: " + libData.getFirstname() + " " + libData.getLastname());
	%>
    		<br/>
    		<br/>
    		<br/>
    		</div>
    
    		<form action="addDocument" method="get">
    			<input type="hidden" value="<%=libData%>" name="userData" />
	    		<input type="hidden" value="<%=userType%>" name="type" />
    			<button type="submit" name="button" value="addDoc">Add New Document</button>
    		</form>
    <%	}
  	%>
  	
  	<br/>
  	<br/>
  	<form action="getSearch" method="get">
	  	<% if(userType.equals("Member")) { %>
	    		<input type="hidden" value="<%=memData%>" name="userData" />
	    <%	} else { %>
	    		<input type="hidden" value="<%=libData%>" name="userData" />
	    <%	} %>
  		<input type="hidden" value="<%=userType%>" name="type" />
  		<input type="text" placeholder="Enter keywords" name="search" required>
  		<button type="submit">Search</button>
  	</form>
  			
</body>
</html>