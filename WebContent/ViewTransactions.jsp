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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        
        $("#filterButton").click(function() {
            var startDate = $("#startDate").val();
            var endDate = $("#endDate").val();
            var transactionType = $("#transactionType").val().toLowerCase();
            
            $("#transactionTableBody tr").each(function() {
                var date = new Date($(this).find("td:eq(5)").text());
                var type = $(this).find("td:eq(3)").text().toLowerCase();

                var dateMatch = (!startDate || !endDate) || (date >= new Date(startDate) && date <= new Date(endDate));
                var typeMatch = !transactionType || transactionType === type;

                $(this).toggle(dateMatch && typeMatch);
            });
        });

        
        $("#resetButton").click(function() {
            $("#startDate").val('');
            $("#endDate").val('');
            $("#transactionType").val('');
            $("#transactionTableBody tr").show();
        });

        
        $('th').on('click', function(){
            var table = $(this).parents('table').eq(0);
            var rows = table.find('tr:gt(0)').toArray().sort(compare($(this).index()));
            this.asc = !this.asc;
            if (!this.asc) {rows = rows.reverse();}
            for (var i = 0; i < rows.length; i++) {table.append(rows[i]);}
        });

        function compare(index) {
            return function(a, b) {
                var valA = getCellValue(a, index), valB = getCellValue(b, index);
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB);
            }
        }

        function getCellValue(row, index) { 
            return $(row).children('td').eq(index).text(); 
        }
    });
</script>
</head>
<body class="bg-gray-900 text-gray-100">

    <%@ include file="Navbar.jsp"%>

<%
    if (email == null) {
        response.sendRedirect("LoginPage.jsp");
        return;
    }
%>

    <div class="p-10">
        <h1 class="mb-8 font-extrabold text-4xl text-dark-blue-800">Transaction History</h1>

        
        <div class="mb-4">
            <label class="block mb-2 text-sm">Filter by Date Range:</label>
            <div class="flex space-x-4 mb-4">
                <input type="date" id="startDate" class="p-2 border border-gray-600 rounded-lg bg-gray-700 text-gray-200">
                <input type="date" id="endDate" class="p-2 border border-gray-600 rounded-lg bg-gray-700 text-gray-200">
            </div>

            <label class="block mb-2 text-sm">Filter by Transaction Type:</label>
            <select id="transactionType" class="p-2 border border-gray-600 rounded-lg bg-gray-700 text-gray-200">
                <option value="">All</option>
                <option value="credit">Credit</option>
                <option value="debit">Debit</option>
                <option value="money transfer">Money Transfer</option>
            </select>

            <div class="flex justify-end mt-4 space-x-4">
                <button id="filterButton" class="px-4 py-2 bg-blue-600 text-white rounded-lg">Filter</button>
                <button id="resetButton" class="px-4 py-2 bg-gray-600 text-white rounded-lg">Reset</button>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-200 shadow-md rounded-lg">
                <thead>
                    <tr class="text-left cursor-pointer">
                        <th class="py-3 px-4">Transaction ID</th>
                        <th class="py-3 px-4">Sender Account</th>
                        <th class="py-3 px-4">Receiver Account</th>
                        <th class="py-3 px-4">Transaction Type</th>
                        <th class="py-3 px-4">Amount</th>
                        <th class="py-3 px-4">Date</th>
                        <th class="py-3 px-4">Description</th>
                    </tr>
                </thead>
                <tbody id="transactionTableBody">
                    <%
                        List<Transaction> transactionList = (List<Transaction>) request.getAttribute("transactionList");
                        if (transactionList != null) {
                            for (Transaction transaction : transactionList) {
                    %>
                    <tr class="border-t border-gray-200 ">
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
                        <td colspan="7" class="py-3 px-4 text-center ">No transactions found.</td>
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
