
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Passbook</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
</head>
<body class="bg-gray-100">
	<%@ include file="CustomerLandingPage.jsp"%>
	<nav class="bg-dark-blue-900 p-4">
		<div class="container mx-auto flex justify-between">
			<div>
				<a href="CustomerLandingPage.jsp"
					class="text-lg font-semibold">Banking Application</a>
			</div>
			
		</div>
	</nav>

	<!-- Passbook Table and Balance -->
	<div class="container mx-auto mt-10 p-5 bg-white rounded shadow">
		<h2 class="text-2xl font-semibold text-center text-dark-blue-900 mb-5">Passbook</h2>

		<!-- View Balance Form -->
		<div class="mb-5 text-center">

			<c:if test="${not empty balance}">
				<p class="text-lg font-semibold text-dark-blue-900 mt-4">Balance:
					Rs.${balance}</p>
			</c:if>
		</div>

		<!-- Transactions Table -->
		<c:choose>
			<c:when test="${not empty transactions}">
				<table class="min-w-full bg-white border border-gray-200">
					<thead>
						<tr>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Transaction
								ID</th>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Type</th>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Sender
								Account</th>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Receiver
								Account</th>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Amount</th>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Date</th>
							<th
								class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Description</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="transaction" items="${transactions}">
							<tr class="border-b border-gray-200">
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.transactionId}</td>
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.transactionType}</td>
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.senderAccountNumber}</td>
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.receiverAccountNumber}</td>
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.amount}</td>
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.transactionDate}</td>
								<td class="py-2 px-4 text-sm text-gray-600">${transaction.description}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<p class="text-center text-gray-600">No transactions found.</p>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>

