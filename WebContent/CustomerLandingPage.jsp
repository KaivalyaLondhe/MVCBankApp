<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Navbar</title>
<script src="https://cdn.tailwindcss.com"></script>
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
				<span
					class="text-xl font-semibold whitespace-nowrap dark:text-white">
					<%=email%>
				</span>
			</div>

			<div class="flex items-center lg:order-2 space-x-4">
				<a href="LogoutServlet"
					class="text-white bg-red-600 hover:bg-red-700 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-4 py-2 transition duration-300">Logout</a>
				<button data-collapse-toggle="mobile-menu-2" type="button"
					class="inline-flex items-center p-2 text-white rounded-lg lg:hidden hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-300"
					aria-controls="mobile-menu-2" aria-expanded="true">
					<span class="sr-only">Open main menu</span>
					<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
						xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
							d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
							clip-rule="evenodd"></path>
                </svg>
					<svg class="hidden w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
						xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
							d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
							clip-rule="evenodd"></path>
                </svg>
				</button>
			</div>

			<div
				class="items-center justify-between w-full lg:flex lg:w-auto lg:order-1"
				id="mobile-menu-2">
				<ul
					class="flex flex-col mt-4 lg:flex-row lg:space-x-8 lg:mt-0 font-medium">
					<li><a href="PassbookController"
						class="block py-2 px-4 text-white hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">Passbook</a>
					</li>
					<li><a href="Transactionpage.jsp"
						class="block py-2 px-4 text-white hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">New
							Transaction</a></li>
					<li><a href="EditProfile.jsp"
						class="block py-2 px-4 text-white hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">Edit
							Profile</a></li>
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

</body>
</html>
