<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.aurionpro.model.Transaction"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Transactions</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

	<%@ include file="AdminLandingPage.jsp"%>

	<div class="p-10">
		<h1 class="mb-8 font-extrabold text-4xl text-dark-blue-800">Transaction
			History</h1>

		<div class="overflow-x-auto">
			<table
				class="min-w-full bg-white border border-gray-200 shadow-md rounded-lg">
				<thead>
					<tr class="bg-dark-blue-800 text-left">
						<th class="py-3 px-4">Transaction ID</th>
						<th class="py-3 px-4">Sender Account</th>
						<th class="py-3 px-4">Receiver Account</th>
						<th class="py-3 px-4">Transaction Type</th>
						<th class="py-3 px-4">Amount</th>
						<th class="py-3 px-4">Date</th>
						<th class="py-3 px-4">Description</th>
					</tr>
				</thead>
				<tbody>
					<%
						List<Transaction> transactionList = (List<Transaction>) request.getAttribute("transactionList");
						if (transactionList != null) {
							for (Transaction transaction : transactionList) {
					%>
					<tr class="border-t border-gray-200">
						<td class="py-3 px-4"><%=transaction.getTransactionId()%></td>
						<td class="py-3 px-4"><%=transaction.getSenderAccountNumber()%></td>
						<td class="py-3 px-4"><%=transaction.getReceiverAccountNumber()%></td>
						<td class="py-3 px-4"><%=transaction.getTransactionType()%></td>
						<td class="py-3 px-4"><%=transaction.getAmount()%></td>
						<td class="py-3 px-4"><%=transaction.getTransactionDate()%></td>
						<td class="py-3 px-4"><%=transaction.getDescription()%></td>
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
