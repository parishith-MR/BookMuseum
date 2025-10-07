package JavaServlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/AJAXServlet")
public class AJAXServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String EmailValue = request.getParameter("EmailValue").trim();
		System.out.println(EmailValue);
		String DataValue = "Sorry Your Email is not Present in the DataBase";
		try {
			String URL = "jdbc:mysql://localhost:3306/museum";
			String User = "root";
			String Pass="root";
			Connection con = DriverManager.getConnection(URL, User, Pass);
			PreparedStatement getName = con.prepareStatement("Select name from users where email=?");
			getName.setString(1, EmailValue);
			ResultSet rs = getName.executeQuery();
			if ( rs.next()) {
				DataValue = "Hi ";
				DataValue += rs.getString("name") + " Welcome To book Store";
			} 
		}catch(Exception e) {
			DataValue = "Error Occured.......";
		}
		response.setContentType("text/plain");
		response.getWriter().write(DataValue);
	}
}
