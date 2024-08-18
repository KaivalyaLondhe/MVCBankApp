<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
	<div class="font-[sans-serif]">
		<div
			class="min-h-screen flex fle-col items-center justify-center py-6 px-4">
			<div class="grid md:grid-cols-2 items-center gap-10 max-w-6xl w-full">
				<div>
					<h2
						class="lg:text-5xl text-4xl font-extrabold lg:leading-[55px] text-gray-800">
						Welcome to Kaivalya's Bank Net banking</h2>
					<p class="text-sm mt-6 text-gray-800">Sign in to enjoy
						hassle-free banking experience with 0 downtime* today!.</p>
					<p class="text-sm mt-12 text-gray-800">
						Don't have an account <a href="./RegisterPage.jsp"
							class="text-blue-600 font-semibold hover:underline ml-1">Register
							here</a>
					</p>
				</div>

				<form class="max-w-md md:ml-auto w-full" action="login"
					method="post">
					<h3 class="text-gray-800 text-3xl font-extrabold mb-8">Sign in
					</h3>

					<div class="space-y-4">
						<div>
							<select name="role" id="role" required
								class="bg-gray-100 w-full text-sm text-gray-800 px-4 py-3.5 rounded-md outline-blue-600 focus:bg-transparent">
								<option value="" disabled selected>Select your role</option>
								<option value="admin">Admin</option>
								<option value="customer">Customer</option>
							</select>
						</div>
						<div>
							<input name="email" type="email" autocomplete="email" required
								class="bg-gray-100 w-full text-sm text-gray-800 px-4 py-3.5 rounded-md outline-blue-600 focus:bg-transparent"
								placeholder="Email address" />
						</div>
						<div>
							<input name="password" type="password"
								autocomplete="current-password" required
								class="bg-gray-100 w-full text-sm text-gray-800 px-4 py-3.5 rounded-md outline-blue-600 focus:bg-transparent"
								placeholder="Password" />
						</div>

					</div>

					<div class="!mt-8">
						<button type="submit"
							class="w-full shadow-xl py-2.5 px-4 text-sm font-semibold rounded text-white bg-blue-600 hover:bg-blue-700 focus:outline-none">
							Log in</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>