<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.aurionpro.model.DbUtil" %> <!-- Replace with the actual package path where your dbUtil class is located -->
    
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Customer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<%
        String email = (String) session.getAttribute("email");
        Double balance = 0.00;
        String fname = "";
        String lname = "";
        
        if (email == null) {
            response.sendRedirect("LoginPage.jsp");
            return;
        }
		DbUtil dbUtil = DbUtil.getDbUtil();
		
		
		
  
        try {
            Connection conn = dbUtil.connectToDb();
            String query = "SELECT fname, lname, balance FROM customer WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                fname = rs.getString("fname");
                lname = rs.getString("lname");
                balance = rs.getDouble("balance");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <nav class="bg-white border-gray-200 py-2.5 dark:bg-gray-900">
        <div class="flex flex-wrap items-center justify-between max-w-screen-xl px-4 mx-auto">
            <div class="flex items-center">
                <span class="text-xl font-semibold whitespace-nowrap dark:text-white">
                    <%= email %>
                </span>
                <span class="ml-4 text-lg text-gray-600">
                    Balance: Rs.<%= String.format("%.2f", balance) %>
                </span>
            </div>
            <div class="flex items-center lg:order-2 space-x-4">
                <a href="logout"
                    class="text-white bg-red-600 hover:bg-red-700 focus:ring-4 focus:ring-red-300 font-medium rounded-lg text-sm px-4 py-2 transition duration-300">Logout</a>
            </div>
        </div>
    </nav>

    <div class="max-w-screen-xl mx-auto mt-10 px-4">
        <h1 class="text-3xl font-semibold text-gray-800">Welcome, <%= fname %> <%= lname %>!</h1>
        <p class="mt-4 text-xl text-gray-600">Your current balance is <span class="font-bold">Rs.<%= String.format("%.2f", balance) %></span>.</p>

        <div class="mt-10 grid grid-cols-1 md:grid-cols-3 gap-6">

            <a href="passbook" class="block p-6 bg-white border border-gray-200 rounded-lg shadow-md hover:bg-gray-100">
                <h5 class="text-2xl font-bold tracking-tight text-gray-900">Passbook</h5>
                <p class="mt-2 text-gray-700">View all your transactions in detail.</p>
            </a>

            <a href="Transactionpage.jsp" class="block p-6 bg-white border border-gray-200 rounded-lg shadow-md hover:bg-gray-100">
                <h5 class="text-2xl font-bold tracking-tight text-gray-900">New Transaction</h5>
                <p class="mt-2 text-gray-700">Make a new transaction quickly and easily.</p>
            </a>

            <a href="editprofile" class="block p-6 bg-white border border-gray-200 rounded-lg shadow-md hover:bg-gray-100">
                <h5 class="text-2xl font-bold tracking-tight text-gray-900">Edit Profile</h5>
                <p class="mt-2 text-gray-700">Update your personal information and preferences.</p>
            </a>
        </div>
    </div>

    <script>
        function handleLogout() {
            sessionStorage.clear(); 
            window.location.href = 'LoginPage.jsp'; 
        }

        document.querySelector('a[href="logout"]').addEventListener('click', function(event) {
            event.preventDefault();
            handleLogout();
        });
    </script>

</body>
</html>
