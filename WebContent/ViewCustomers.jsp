<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="com.aurionpro.model.Customer"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer List</title>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function(){
       
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#customerTableBody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
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
        <h1 class="mb-8 font-extrabold text-4xl">Customer List</h1>

      
        <div class="flex justify-end mb-4">
            <input id="searchInput" type="text" placeholder="Search..." 
                   class="p-2 border border-gray-600 rounded-lg bg-gray-700 text-gray-200">
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full bg-white border border-gray-200 shadow-md rounded-lg">
                <thead>
                    <tr class="bg-blue-600 text-white text-left cursor-pointer">
                        <th class="py-3 px-4">Customer ID</th>
                        <th class="py-3 px-4">First Name</th>
                        <th class="py-3 px-4">Last Name</th>
                        <th class="py-3 px-4">Email</th>
                        <th class="py-3 px-4">Account Number</th>
                        <th class="py-3 px-4">Balance</th>
                    </tr>
                </thead>
                <tbody id="customerTableBody">
                    <%
                       
                        List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
                        if (customerList != null && !customerList.isEmpty()) {
                            for (Customer customer : customerList) {
                    %>
                    <tr class="border-t border-gray-200 text-gray-900">
                        <td class="py-3 px-4"><%=customer.getCustomerId()%></td>
                        <td class="py-3 px-4"><%=customer.getFname()%></td>
                        <td class="py-3 px-4"><%=customer.getLname()%></td>
                        <td class="py-3 px-4"><%=customer.getEmail()%></td>
                        <td class="py-3 px-4"><%=customer.getAccountNumber()%></td>
                        <td class="py-3 px-4"><%=customer.getBalance()%></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="py-3 px-4 text-center text-gray-500">No customers found.</td>
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
