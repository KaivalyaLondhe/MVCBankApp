<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
	<%-- Include header and navigation --%>
	<%@ include file="CustomerLandingPage.jsp"%>
	<%
		String firstName = (String) request.getAttribute("firstName");
		String lastName = (String) request.getAttribute("lastName");
		if (firstName == null || lastName == null) {
			firstName = "";
			lastName = "";
		}
	%>

	<div class="max-w-lg mx-auto p-6 bg-white shadow-md rounded-lg mt-10">
		<h2 class="text-2xl font-semibold mb-4">Edit Profile</h2>

		<form action="EditProfileController" method="post">
			<div class="mb-4">


				<label for="firstName" class="block text-gray-700 font-medium mb-2">First
					Name</label> <input id="firstName" name="firstName" type="text"
					value="<%=request.getAttribute("firstName") != null ? request.getAttribute("firstName") : ""%>"
					class="block w-full p-2 border border-gray-300 rounded-lg" required>
			</div>

			<div class="mb-4">
				<label for="lastName" class="block text-gray-700 font-medium mb-2">Last
					Name</label> <input id="lastName" name="lastName" type="text"
					value="<%=request.getAttribute("lastName") != null ? request.getAttribute("lastName") : ""%>"
					class="block w-full p-2 border border-gray-300 rounded-lg" required>
			</div>

			<div class="mb-4">
				<label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
				<input id="password" name="password" type="password"
					class="block w-full p-2 border border-gray-300 rounded-lg" required>
			</div>

			<div class="flex space-x-4">
				<button type="submit"
					class="bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition duration-300">Update</button>
				<a href="CustomerLandingPage.jsp"
					class="bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 transition duration-300">Cancel</a>
			</div>

			<%
				if (request.getAttribute("success") != null) {
			%>
			<p class="mt-4 text-green-500"><%=request.getAttribute("success")%></p>
			<%
				}
			%>
			<%
				if (request.getAttribute("error") != null) {
			%>
			<p class="mt-4 text-red-500"><%=request.getAttribute("error")%></p>
			<%
				}
			%>
		</form>
	</div>
</body>
</html>
