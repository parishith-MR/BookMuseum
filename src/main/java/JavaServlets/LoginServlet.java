package JavaServlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<h1> Login page.... </h1>");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/museum", "root", "root");
            Statement stm = con.createStatement();
            PreparedStatement ps = con.prepareStatement("Select * from users where email=? and password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
            	HttpSession session = request.getSession();
            	String name = rs.getString("name");
            	
            	session.setAttribute("email", email);
            	session.setAttribute("name", name);
            	
            	out.println("<script>alert('Login Sucsessfull......'); window.location='BookWebPage.jsp';</script>");
            }
            stm.close();
            con.close();
            out.println("<script>alert('Login failed......'); window.location='homepage.html';</script>");
		}catch(Exception e) {
			out.println(e.getMessage() + "error....");
		}
	}
}
