<%@ page contentType="text/xml" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<?xml-stylesheet type="text/xsl" href="orders.xsl"?>
<%
    String url = "jdbc:mysql://localhost:3306/museum";
    String user = "root";                              
    String pass = "root";                      

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT id, price, bookid, date, email FROM orders");

%>
<orders>
<%
        while (rs.next()) {
%>
    <order>
        <id><%= rs.getInt("id") %></id>
        <price><%= rs.getDouble("price") %></price>
        <bookid><%= rs.getInt("bookid") %></bookid>
        <date><%= rs.getString("date") %></date>
        <email><%= rs.getString("email") %></email>
    </order>
<%
        }
%>
</orders>
<%
    } catch (Exception e) {
        out.println(" Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
