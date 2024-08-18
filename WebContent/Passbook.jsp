<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passbook</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <%@ include file="CustomerNavbar.jsp"%>
    <nav class="bg-dark-blue-900 p-4">
        <div class="container mx-auto flex justify-between">
            <div>
                <a href="CustomerLandingPage.jsp" class="text-lg font-semibold">Banking Application</a>
            </div>
        </div>
    </nav>

    <div class="container mx-auto mt-10 p-5 bg-white rounded shadow">
        <h2 class="text-2xl font-semibold text-center text-dark-blue-900 mb-5">Passbook</h2>

        <form action="passbook" method="get" class="mb-5">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                    <label for="startDate" class="block text-sm font-medium text-gray-700">Start Date:</label>
                    <input type="date" id="startDate" name="startDate"
                        class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="endDate" class="block text-sm font-medium text-gray-700">End Date:</label>
                    <input type="date" id="endDate" name="endDate"
                        class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                </div>
                <div>
                    <label for="transactionType" class="block text-sm font-medium text-gray-700">Transaction Type:</label>
                    <select id="transactionType" name="transactionType"
                        class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                        <option value="">All</option>
                        <option value="credit">Credit</option>
                        <option value="debit">Debit</option>
                        <option value="money transfer">Money Transfer</option>
                    </select>
                </div>
            </div>
            <div class="text-center mt-4 flex justify-center space-x-4">
                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700">Filter</button>
                <a href="passbook" class="bg-red-600 text-white px-4 py-2 rounded shadow hover:bg-red-700">Reset</a>
            </div>
        </form>

        <div class="mb-5 text-center">
            <c:if test="${not empty balance}">
                <p class="text-lg font-semibold text-dark-blue-900 mt-4">Balance: Rs.${balance}</p>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${not empty transactions}">
                <table class="min-w-full bg-white border border-gray-200">
                    <thead>
                        <tr>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Transaction ID</th>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Type</th>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Sender Account</th>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Receiver Account</th>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Amount</th>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Date</th>
                            <th class="py-2 px-4 bg-gray-200 text-left text-sm font-semibold text-gray-600">Description</th>
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
