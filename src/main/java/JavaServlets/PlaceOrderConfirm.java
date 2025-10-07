package JavaServlets;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PlaceOrderConfirm")
public class PlaceOrderConfirm extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/museum";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("cart") == null) {
            request.setAttribute("message", "No items in cart!");
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
            return;
        }

        List<Integer> cart = (List<Integer>) session.getAttribute("cart");
        String email = (String) session.getAttribute("email");

        if (email == null) {
            request.setAttribute("message", "Please login first!");
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
            return;
        }

        double totalAmount = 0.0;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            conn.setAutoCommit(false);

            String fetchBookSQL = "SELECT id, price, stock FROM books WHERE id = ?";
            String updateStockSQL = "UPDATE books SET stock = stock - 1 WHERE id = ?";
            String insertOrderSQL = "INSERT INTO orders (price, bookid, date, email) VALUES (?, ?, ?, ?)";
            PreparedStatement fetchBook = conn.prepareStatement(fetchBookSQL);
            PreparedStatement updateStock = conn.prepareStatement(updateStockSQL);
            PreparedStatement insertOrder = conn.prepareStatement(insertOrderSQL);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String orderDate = LocalDateTime.now().format(formatter);
            for (int bookId : cart) {
                fetchBook.setInt(1, bookId);
                ResultSet rs = fetchBook.executeQuery();
                if (rs.next()) {
                    int stock = rs.getInt("stock");
                    double price = rs.getDouble("price");
                    if (stock > 0) {
                        totalAmount += price;
                        updateStock.setInt(1, bookId);
                        updateStock.executeUpdate();
                        insertOrder.setDouble(1, price);
                        insertOrder.setInt(2, bookId);
                        insertOrder.setString(3, orderDate);
                        insertOrder.setString(4, email);
                        insertOrder.executeUpdate();
                    }
                }
            }
            conn.commit();
            session.removeAttribute("cart");
            request.setAttribute("message", "Order placed successfully!");
            request.setAttribute("totalAmount", totalAmount);
        } catch (Exception e) {
            request.setAttribute("message", "Order failed: " + e.getMessage());
        }
        request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
    }
}
