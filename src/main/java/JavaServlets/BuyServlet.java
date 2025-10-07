package JavaServlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        int bookId = Integer.parseInt(request.getParameter("bookId"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/museum", "root", "root");

            // Reduce stock by 1
            PreparedStatement ps = con.prepareStatement(
                "UPDATE books SET stock = stock - 1 WHERE id = ? AND stock > 0"
            );
            ps.setInt(1, bookId);
            int updated = ps.executeUpdate();

            if (updated > 0) {
                // Insert into orders table
                PreparedStatement orderPs = con.prepareStatement(
                    "INSERT INTO orders(book_id, user_email, order_date) VALUES (?, ?, NOW())"
                );
                // for now, assume email is stored in session after login
                HttpSession session = request.getSession();
                String email = (String) session.getAttribute("email");
                orderPs.setInt(1, bookId);
                orderPs.setString(2, email);
                orderPs.executeUpdate();

                out.println("<script>alert('Purchase Successful!'); window.location.href='homepage.html';</script>");
            } else {
                out.println("<script>alert('Sorry, out of stock!'); window.location.href='homepage.html';</script>");
            }

            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}
