<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration</title>
<script src="https://cdn.tailwindcss.com"></script>

</head>
<body class="bg-white flex items-center justify-center min-h-screen">
	<div class="bg-blue-100 p-6 rounded-lg shadow-lg max-w-md w-full">
		<h1 class="text-2xl font-bold text-blue-600 mb-4">Congratulations!</h1>
		<p class="text-gray-700 mb-4">Registration was successful.</p>
		<p class="text-gray-700 mb-4">
			Welcome,
			<%=request.getParameter("first-name")%>
			<%=request.getParameter("last-name")%>!
		</p>
		<a href="LoginPage.jsp"
			class="bg-blue-600 text-white py-2 px-4 rounded-lg shadow hover:bg-blue-700">Login
			Now</a>
	</div>
</body>
</html>