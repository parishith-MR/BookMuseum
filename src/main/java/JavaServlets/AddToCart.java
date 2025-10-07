package JavaServlets;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		List<Integer> cart = (List<Integer>) session.getAttribute("cart");
		if (cart == null) {
		    cart = new ArrayList<>();
		}
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		cart.add(bookId);
		session.setAttribute("cart", cart);
		response.sendRedirect("BookWebPage.jsp");
	}

}
