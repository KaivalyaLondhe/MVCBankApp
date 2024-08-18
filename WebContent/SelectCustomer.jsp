<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.aurionpro.model.Customer"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Number Generation</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-gray-100">

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
		<h1 class="mb-8 font-extrabold text-4xl text-white">Select
			Customer and Generate Account Number</h1>

		<form action="accountnumbergenerator" method="post"
			class="mb-8 bg-gray-800 p-6 rounded-lg shadow-md">
			<label for="customerId"
				class="block text-lg font-medium text-gray-300">Select
				Customer:</label> 
			<select id="customerId" name="customerId"
				class="mt-2 mb-4 p-2 border border-gray-600 rounded-lg bg-gray-700 text-gray-200"
				required>
				<option value="">Select by Customer ID</option>
				<%
					List<Customer> customers = (List<Customer>) request.getAttribute("customerList");
					if (customers != null) {
						for (Customer customer : customers) {
				%>
				<option value="<%=customer.getCustomerId()%>">ID: <%=customer.getCustomerId()%></option>
				<%
						}
					}
				%>
			</select> 
			<input type="submit" value="Submit"
				class="bg-blue-800 text-white py-2 px-4 rounded-lg hover:bg-blue-700">
		</form>

		<c:if test="${not empty customer}">
			<div
				class="bg-gray-800 p-4 border border-gray-600 rounded-lg shadow-md">
				<h2 class="text-xl font-semibold text-white">Customer Details</h2>
				<p>
					<strong>First Name:</strong> ${customer.fname}
				</p>
				<p>
					<strong>Last Name:</strong> ${customer.lname}
				</p>
				<p>
					<strong>Email:</strong> ${customer.email}
				</p>
				<p>
					<strong>Balance:</strong> ${customer.balance}
				</p>
				<form action="GenerateAccountNumberController" method="post"
					class="mt-4">
					<input type="hidden" name="customerId"
						value="${customer.customerId}">
					<button type="submit"
						class="bg-blue-800 text-white py-2 px-4 rounded-lg hover:bg-blue-700">Generate
						Account Number</button>
				</form>
			</div>
		</c:if>

		<c:if test="${not empty message}">
			<div
				class="mt-4 p-4 border border-gray-600 rounded-lg bg-blue-900 text-blue-200">
				<p>${message}</p>
			</div>
		</c:if>
	</div>

</body>
</html>
