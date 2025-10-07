<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Order Confirmation</title>
</head>
<style>
body{
	background: linear-gradient(to right, #93DA97, #5E936C);
}
h1{
	color : white;
	text-align : center;
}
h2{
	color : white;
	text-align : center;
}
a{
	text-align : center;
}
</style>
<body>
	<h1> Hello <%=session.getAttribute("name")%> </h1>
	<h1> Email <%=session.getAttribute("email")%> </h1>
	
    <h2><%= request.getAttribute("message") %></h2>
    <%
        Double total = (Double) request.getAttribute("totalAmount");
        if (total != null) {
    %>
        <h3>Total Amount: Rs. <%= total %></h3>
    <%
        }
    %>
    <h1><a href="BookWebPage.jsp">Continue Shopping</a></h1>
</body>
</html>
