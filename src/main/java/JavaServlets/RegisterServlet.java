package JavaServlets;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String password = request.getParameter("pwd");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");

        if (name == null || name.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            dob == null || dob.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {

            response.setContentType("text/html");
            out.println("<script>alert('Validation failed! All fields are required.');");
            out.println("window.location.href = 'failed.html';</script>");
            return;
        }

        String[] preferences = request.getParameterValues("preference");
        boolean fiction = false, selfHelp = false, education = false;

        if (preferences != null) {
            for (String pref : preferences) {
                if (pref.equalsIgnoreCase("Fiction")) fiction = true;
                if (pref.equalsIgnoreCase("Self-help")) selfHelp = true;
                if (pref.equalsIgnoreCase("Education")) education = true;
            }
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/museum", "root", "root");

            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE email = ?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (storedPassword.equals(password)) {
                	out.println("<script>alert('You are the Existing user You  can Login'); window.history.back();</script>");
                    response.sendRedirect("Login.html");
                } else {
                    out.println("<script>alert('Incorrect password!'); window.history.back();</script>");
                }
            } else {
                out.println("<script>");
                out.println("alert('You are a new user, registering you now...');");
                out.println("</script>");

                PreparedStatement pst = con.prepareStatement(
                    "INSERT INTO users(name, password, dob, email, fiction, self_help, education) VALUES (?, ?, ?, ?, ?, ?, ?)");
                pst.setString(1, name);
                pst.setString(2, password);
                pst.setString(3, dob);
                pst.setString(4, email);
                pst.setBoolean(5, fiction);
                pst.setBoolean(6, selfHelp);
                pst.setBoolean(7, education);

                int row = pst.executeUpdate();
                if (row > 0) {
                    out.println("<script>window.location.href = 'BookWebPage.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to register user.'); window.history.back();</script>");
                }
            }

            con.close();
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }
}
