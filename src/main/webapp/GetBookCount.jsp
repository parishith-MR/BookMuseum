<%@ page import="java.sql.*" %>
<%
    String bookId = request.getParameter("bookId");
    String url = "jdbc:mysql://localhost:3306/museum";
    String user = "root";
    String pass = "root";

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int count = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        ps = conn.prepareStatement("SELECT COUNT(*) FROM orders WHERE bookid = ?");
        ps.setInt(1, Integer.parseInt(bookId));
        rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }
        out.print(count);   // send result back to AJAX
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
