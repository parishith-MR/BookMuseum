<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Orders with AJAX</title>
    <script>
        function loadOrders() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "orders.jsp", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var xml = xhr.responseXML;
                    var orders = xml.getElementsByTagName("order");
                    var output = "<table border='1'><tr><th>ID</th><th>Price</th><th>BookID</th><th>Date</th><th>Email</th></tr>";

                    for (var i = 0; i < orders.length; i++) {
                        var id = orders[i].getElementsByTagName("id")[0].textContent;
                        var price = orders[i].getElementsByTagName("price")[0].textContent;
                        var bookid = orders[i].getElementsByTagName("bookid")[0].textContent;
                        var date = orders[i].getElementsByTagName("date")[0].textContent;
                        var email = orders[i].getElementsByTagName("email")[0].textContent;

                        output += "<tr><td>" + id + "</td><td>" + price + "</td><td>" + bookid + "</td><td>" + date + "</td><td>" + email + "</td></tr>";
                    }
                    output += "</table>";

                    document.getElementById("result").innerHTML = output;
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
    <h1>Orders AJAX Example</h1>
    <button onclick="loadOrders()">Load Orders</button>
    <div id="result" style="margin-top:20px;"></div>
</body>
</html>
