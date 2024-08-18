 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Dashboard</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
    .btn-primary {
        @apply text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 transition ease-in-out duration-300;
    }
    .btn-secondary {
        @apply text-gray-700 bg-gray-200 hover:bg-gray-300 focus:ring-4 focus:ring-gray-300 font-medium rounded-lg text-sm px-4 py-2 transition ease-in-out duration-300;
    }
    .btn-logout {
        @apply text-blue-800 bg-white border border-blue-800 hover:bg-blue-100 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 transition ease-in-out duration-300;
    }
</style>
</head>
<body class="bg-gray-100 dark:bg-gray-900">

    <%
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }
    %>

    <nav class="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 py-4">
        <div class="container mx-auto flex items-center justify-between px-4">
            <div class="flex items-center">
                <span class="text-xl font-semibold text-gray-900 dark:text-white">
                    <%= email %>
                </span>
            </div>

            <div class="flex items-center space-x-4">
                <a href="logout" class="submit">Logout</a>
            </div>
        </div>
    </nav>

    <main class="container mx-auto p-6">
        <section class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 dark:text-white">Welcome to Your Admin Dashboard</h1>
            <p class="mt-4 text-gray-600 dark:text-gray-400">Manage your bank's customers, accounts, and transactions with ease.</p>
        </section>

        <section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-lg flex flex-col items-center text-center">
                <a href="AddNewCustomer.jsp" class="w-full">
                    
                    <svg class="w-16 h-16 mx-auto text-blue-800 dark:text-blue-400 mb-4" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 14c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-3.31 0-6 2.69-6 6v2h12v-2c0-3.31-2.69-6-6-6zm0-10c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2z"></path>
                    </svg>
                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white mb-2">Add New Customer</h2>
                    <p class="text-gray-600 dark:text-gray-400">Easily add new customers to your bank's database.</p>
                </a>
            </div>

            <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-lg flex flex-col items-center text-center">
                <a href="accountnumbergenerator" class="w-full">
                    
                    <svg class="w-16 h-16 mx-auto text-blue-800 dark:text-blue-400 mb-4" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 2L3 7v6c0 .61.305 1.17.798 1.482L12 14l8.202-4.518A1.5 1.5 0 0021 13V7l-9-5zM12 14l-9-5v5h18v-5l-9 5z"></path>
                    </svg>
                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white mb-2">Add Bank Account</h2>
                    <p class="text-gray-600 dark:text-gray-400">Create new bank accounts for your customers.</p>
                </a>
            </div>

            <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-lg flex flex-col items-center text-center">
                <a href="customerlist" class="w-full">
                    
                    <svg class="w-16 h-16 mx-auto text-blue-800 dark:text-blue-400 mb-4" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-3.31 0-6 2.69-6 6v2h12v-2c0-3.31-2.69-6-6-6zm0-10c1.1 0 2 .9 2 2s-.9 2-2 2-2-.9-2-2 .9-2 2-2z"></path>
                        <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-3.31 0-6 2.69-6 6v2h12v-2c0-3.31-2.69-6-6-6z"></path>
                    </svg>
                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white mb-2">View Customers</h2>
                    <p class="text-gray-600 dark:text-gray-400">See a list of all your bank's customers.</p>
                </a>
            </div>

            <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-lg flex flex-col items-center text-center">
                <a href="transactions" class="w-full">
                    
                    <svg class="w-16 h-16 mx-auto text-blue-800 dark:text-blue-400 mb-4" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M20 14v-2H4v2h16zM4 6h16v2H4V6zm0 4h16v2H4v-2z"></path>
                    </svg>
                    <h2 class="text-xl font-semibold text-gray-900 dark:text-white mb-2">View Transactions</h2>
                    <p class="text-gray-600 dark:text-gray-400">Review all transactions processed by your bank.</p>
                </a>
            </div>
        </section>
    </main>

    <footer class="bg-white dark:bg-gray-800 py-4">
        <div class="container mx-auto text-center">
            <p class="text-gray-600 dark:text-gray-400">&copy; 2024 Kaivalya's Bank. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>

