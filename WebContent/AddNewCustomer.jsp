<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add New Customer</title>
<script src="https://cdn.tailwindcss.com"></script>
<script>
	function confirmSubmit() {
		var firstName = document.getElementById("first-name").value;
		var lastName = document.getElementById("last-name").value;
		var email = document.getElementById("email").value;
		var password = document.getElementById("password").value;

		var confirmation = confirm("Please confirm the details:\n\n"
				+ "First Name: " + firstName + "\n" + "Last Name: " + lastName
				+ "\n" + "Email ID: " + email + "\n" + "Password: " + password);

		if (confirmation) {
			document.getElementById("customer-form").submit();
		}
	}

	function confirmCancel() {
		if (confirm("Are you sure you want to cancel?")) {
			window.location.href = "AdminLandingPage.jsp";
		}
	}
</script>
</head>
<body>
	<%@ include file="Navbar.jsp"%>

	<%
		if (email == null) {
			response.sendRedirect("LoginPage.jsp");
			return;
		}
	%>
	<script>
		function handleLogout() {
			sessionStorage.clear();
			window.location.href = 'LoginPage.jsp';
		}

		document.querySelector('a[href="LogoutServlet"]').addEventListener(
				'click', function(event) {
					event.preventDefault();
					handleLogout();
				});
	</script>
	<div class="p-10">
		<h1 class="mb-8 font-extrabold text-4xl">Add New Customer</h1>
		<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			if (errorMessage != null) {
		%>
		<div class="mb-4 text-red-600 font-semibold">
			<%=errorMessage%>
		</div>
		<%
			}
		%>

		<%
			String successMessage = (String) request.getAttribute("successMessage");
			if (successMessage != null) {
		%>
		<div class="mb-4 text-green-600 font-semibold">
			<%=successMessage%>
		</div>
		<%
			}
		%>

		<form action="AddCustomerController" method="post">
			<div>
				<label class="block font-semibold" for="first-name">First
					Name</label> <input
					class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
					id="first-name" type="text" name="first-name" required autofocus>
			</div>

			<div class="mt-4">
				<label class="block font-semibold" for="last-name">Last Name</label>
				<input
					class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
					id="last-name" type="text" name="last-name" required>
			</div>

			<div class="mt-4">
				<label class="block font-semibold" for="email">Email</label> <input
					class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
					id="email" type="email" name="email" required>
			</div>

			<div class="mt-4">
				<label class="block font-semibold" for="password">Password</label> <input
					class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
					id="password" type="password" name="password" required>
			</div>

			<div class="flex items-center justify-between mt-8">
				<button type="submit"
					class="flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 md:py-4 md:text-lg md:px-10">Submit</button>
				<button type="button"
					class="flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-gray-700 bg-gray-200 hover:bg-gray-300 md:py-4 md:text-lg md:px-10"
					onclick="confirmCancel()">Cancel</button>
			</div>
		</form>
	</div>

	<script>
		function confirmCancel() {
			if (confirm("Are you sure you want to cancel?")) {
				window.location.href = "adminLandingPage.jsp";
			}
		}
	</script>

</body>
</html>