<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.aurionpro.model.Customer"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


	<%@ include file="AdminLandingPage.jsp"%>

	<div class="p-10">
		<h1 class="mb-8 font-extrabold text-4xl">Customer List</h1>

		<div class="overflow-x-auto">
			<table
				class="min-w-full bg-white border border-gray-200 shadow-md rounded-lg">
				<thead>
					<tr class="bg-blue-600 text-white text-left">
						<th class="py-3 px-4">Customer ID</th>
						<th class="py-3 px-4">First Name</th>
						<th class="py-3 px-4">Last Name</th>
						<th class="py-3 px-4">Email</th>
						<th class="py-3 px-4">Account Number</th>
						<th class="py-3 px-4">Balance</th>
					</tr>
				</thead>
				<tbody>
					<%
						// Retrieve the customer list from the request attribute
						List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
						if (customerList != null && !customerList.isEmpty()) {
							for (Customer customer : customerList) {
					%>
					<tr class="border-t border-gray-200">
						<td class="py-3 px-4"><%=customer.getCustomerId()%></td>
						<td class="py-3 px-4"><%=customer.getFname()%></td>
						<td class="py-3 px-4"><%=customer.getLname()%></td>
						<td class="py-3 px-4"><%=customer.getEmail()%></td>
						<td class="py-3 px-4"><%=customer.getAccountNumber()%></td>
						<td class="py-3 px-4"><%=customer.getBalance()%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td colspan="6" class="py-3 px-4 text-center text-gray-500">No
							customers found.</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>