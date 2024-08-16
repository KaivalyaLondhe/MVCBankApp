<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register User</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

	<div class="p-10">
		<h1 class="mb-8 font-extrabold text-4xl">Register</h1>
		<div class="grid grid-cols-1 md:grid-cols-2 gap-8">

			<form action="RegisterController" method="post">
				<c:if test="${not empty errorMessage}">
					<div class="bg-red-100 text-red-700 p-4 rounded-lg mb-4">
						<p>
							<c:out value="${errorMessage}" />
						</p>
					</div>
				</c:if>

				<div>
					<label class="block font-semibold" for="first-name">First
						Name</label> <input
						class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
						id="first-name" type="text" name="first-name" required autofocus>
				</div>

				<div class="mt-4">
					<label class="block font-semibold" for="last-name">Last
						Name</label> <input
						class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
						id="last-name" type="text" name="last-name">
				</div>

				<div class="mt-4">
					<label class="block font-semibold" for="email">Email</label> <input
						class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
						id="email" type="email" name="email" required>
				</div>

				<div class="mt-4">
					<label class="block font-semibold" for="password">Password</label>
					<input
						class="w-full shadow-inner bg-gray-100 rounded-lg placeholder-black text-2xl p-4 border-none block mt-1"
						id="password" type="password" name="password" required
						autocomplete="new-password">
				</div>

				<div class="flex items-center justify-between mt-8">
					<button type="submit"
						class="flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 md:py-4 md:text-lg md:px-10">Register</button>
					<a class="font-semibold" href="./LoginPage.jsp"> Already
						registered? </a>
				</div>
			</form>

			<aside>
			<div class="bg-gray-100 p-8 rounded">
				<h2 class="font-bold text-2xl">Instructions</h2>
				<ul class="list-disc mt-4 list-inside">
					<li>This registration option is only available for Admins and
						individuals registered with the organization.</li>
					<li>Please provide a valid email address and password to
						create an account.</li>
					<li>Ensure that your profile information is appropriate and
						accurate.</li>
				</ul>
			</div>
			</aside>

		</div>
	</div>

</body>
</html>
