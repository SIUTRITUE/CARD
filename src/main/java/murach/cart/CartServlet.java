package murach.cart;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import murach.business.*;

@WebServlet("/cart")   // ánh xạ servlet
public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();

        synchronized(session) {
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            String productCode = request.getParameter("productCode");
            String quantityString = request.getParameter("quantity");
            int quantity = 1;
            try {
                quantity = Integer.parseInt(quantityString);
                if (quantity < 0) quantity = 1;
            } catch (NumberFormatException e) { }

            Product product = new Product();
            if ("8601".equals(productCode)) {
                product.setCode(productCode);
                product.setDescription("86 (the band) - True Life Songs and Pictures");
                product.setPrice(14.95);
            } else if ("pf01".equals(productCode)) {
                product.setCode(productCode);
                product.setDescription("Paddlefoot - The First CD");
                product.setPrice(12.95);
            } else if ("pf02".equals(productCode)) {
                product.setCode(productCode);
                product.setDescription("Paddlefoot - The Second CD");
                product.setPrice(14.95);
            } else if ("jr01".equals(productCode)) {
                product.setCode(productCode);
                product.setDescription("Joe Rut - Genuine Wood Grained Finish");
                product.setPrice(14.95);
            }

            LineItem lineItem = new LineItem();
            lineItem.setProduct(product);
            lineItem.setQuantity(quantity);

            String action = request.getParameter("action");
            if (action == null) action = "cart";

            if ("cart".equals(action)) {
                if (quantity > 0) {
                    cart.addItem(lineItem);
                } else {
                    cart.removeItem(lineItem);
                }
            }

            session.setAttribute("cart", cart);
        }

        getServletContext()
                .getRequestDispatcher("/cart.jsp")
                .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        doPost(request, response);
    }
}
