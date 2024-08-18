

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Transaction</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
	<%@ include file="CustomerNavbar.jsp"%>
	<div class="max-w-lg mx-auto p-6 bg-white shadow-md rounded-lg mt-10">
		<h2 class="text-2xl font-semibold mb-4">Create Transaction</h2>

		<%
			String successMessage = (String) request.getAttribute("success");
			String errorMessage = (String) request.getAttribute("error");
			if (successMessage != null) {
		%>
		<div class="bg-green-100 text-green-800 p-4 rounded mb-4">
			<%=successMessage%>
		</div>
		<%
			} else if (errorMessage != null) {
		%>
		<div class="bg-red-100 text-red-800 p-4 rounded mb-4">
			<%=errorMessage%>
		</div>
		<%
			}
		%>

		<form action="TransactionController" method="post">
			<div class="mb-4">
				<label for="transactionType"
					class="block text-gray-700 font-medium mb-2">Type of
					Transaction</label> <select id="transactionType" name="transactionType"
					class="block w-full p-2 border border-gray-300 rounded-lg">
					<option value="credit">Credit</option>
					<option value="debit">Debit</option>
					<option value="money transfer">Money Transfer</option>
				</select>
			</div>

			<input type="hidden" id="senderAccountNumber"
				name="senderAccountNumber"
				value="<%=session.getAttribute("accountNumber")%>">

			<div class="mb-4">
				<label for="receiverAccountNumber"
					class="block text-gray-700 font-medium mb-2">Receiver
					Account Number</label> <input id="receiverAccountNumber"
					name="receiverAccountNumber" type="number" max="999999999999"
					class="block w-full p-2 border border-gray-300 rounded-lg" disabled>
			</div>

			<div class="mb-4">
				<label for="amount" class="block text-gray-700 font-medium mb-2">Amount</label>
				<input id="amount" name="amount" type="number" step="0.01"
					min="0.01"
					class="block w-full p-2 border border-gray-300 rounded-lg" required>
				<span class="text-red-500 text-sm" id="amountError"
					style="display: none;">Amount must be a positive value.</span>
			</div>

			<div class="mb-4">
				<label for="description"
					class="block text-gray-700 font-medium mb-2">Description</label> <input
					id="description" name="description" type="text"
					class="block w-full p-2 border border-gray-300 rounded-lg">
			</div>

			<div class="flex space-x-4">
				<button type="submit"
					class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition duration-300">Submit</button>
				<button type="reset"
					class="bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 transition duration-300">Cancel</button>
			</div>
		</form>
	</div>

	<script>
		document.getElementById('transactionType').addEventListener(
				'change',
				function() {
					var transactionType = this.value;
					var receiverInput = document
							.getElementById('receiverAccountNumber');
					if (transactionType === 'money transfer') {
						receiverInput.disabled = false;
					} else {
						receiverInput.disabled = true;
						receiverInput.value = '';
					}
				});
	</script>

</body>
</html>

