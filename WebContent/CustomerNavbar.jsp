<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.aurionpro.model.DbUtil" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>

<%
    String email = (String) session.getAttribute("email");
    Double balance = 0.00;

    if (email == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }
    
    DbUtil dbUtil = DbUtil.getDbUtil();

    try {
        Connection conn = dbUtil.connectToDb();
        String query = "SELECT balance FROM customer WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
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
            <button data-collapse-toggle="mobile-menu-2" type="button"
                class="inline-flex items-center p-2 text-white rounded-lg lg:hidden hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-300"
                aria-controls="mobile-menu-2" aria-expanded="true">
                <span class="sr-only">Open main menu</span>
                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                        d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                        clip-rule="evenodd"></path>
                </svg>
                <svg class="hidden w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                        d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                        clip-rule="evenodd"></path>
                </svg>
            </button>
        </div>

        <div class="items-center justify-between w-full lg:flex lg:w-auto lg:order-1" id="mobile-menu-2">
            <ul class="flex flex-col mt-4 lg:flex-row lg:space-x-8 lg:mt-0 font-medium">
                <li>
                    <a href="CustomerLandingPage.jsp"
                        class="block py-2 px-4 text-black hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">Home</a>
                </li>
                <li>
                    <a href="passbook"
                        class="block py-2 px-4 text-black hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">Passbook</a>
                </li>
                <li>
                    <a href="Transactionpage.jsp"
                        class="block py-2 px-4 text-black hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">New Transaction</a>
                </li>
                <li>
                    <a href="editprofile"
                        class="block py-2 px-4 text-black hover:bg-dark-blue-700 rounded-lg transition duration-300 lg:py-3 lg:px-5">Edit Profile</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

</body>
</html>
