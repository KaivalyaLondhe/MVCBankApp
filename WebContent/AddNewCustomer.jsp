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


	<%
		String email = (String) session.getAttribute("email");

		if (email == null) {
			response.sendRedirect("LoginPage.jsp");
			return;
		}
	%>

	<nav class="bg-white border-gray-200 py-2.5 dark:bg-gray-900">
	<div
		class="flex flex-wrap items-center justify-between max-w-screen-xl px-4 mx-auto">
		<div class="flex items-center">
			<span class="text-xl font-semibold whitespace-nowrap dark:text-white">
				<%=email%>
			</span>
		</div>

		<div class="flex items-center lg:order-2">
			<a href="LogoutServlet"
				class="text-white bg-red-600 hover:bg-red-700 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-4 py-2 lg:py-2.5 dark:bg-red-600 dark:hover:bg-red-700 focus:outline-none dark:focus:ring-red-800">Logout</a>
			<button data-collapse-toggle="mobile-menu-2" type="button"
				class="inline-flex items-center p-2 ml-1 text-sm text-gray-500 rounded-lg lg:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
				aria-controls="mobile-menu-2" aria-expanded="true">
				<span class="sr-only">Open main menu</span>
				<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
					xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd"
					d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
					clip-rule="evenodd"></path> </svg>
				<svg class="hidden w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
					xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd"
					d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
					clip-rule="evenodd"></path> </svg>
			</button>
		</div>
		<div
			class="items-center justify-between w-full lg:flex lg:w-auto lg:order-1"
			id="mobile-menu-2">
			<ul
				class="flex flex-col mt-4 font-medium lg:flex-row lg:space-x-8 lg:mt-0">
				<li><a href="AddNewCustomer.jsp"
					class="block py-2 pl-3 pr-4 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-purple-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">Add
						New Customer</a></li>
				<li><a href="SelectCustomerController"
					class="block py-2 pl-3 pr-4 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-purple-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">Add
						Bank Account</a></li>
				<li><a href="ViewCustomersController"
					class="block py-2 pl-3 pr-4 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-purple-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">View
						Customers</a></li>
				<li><a href="ViewTransactionsController"
					class="block py-2 pl-3 pr-4 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-purple-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700">View
						Transactions</a></li>
			</ul>
		</div>
	</div>
	</nav>

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