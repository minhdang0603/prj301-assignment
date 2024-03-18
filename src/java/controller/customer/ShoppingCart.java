/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CartDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.Item;
import model.Product;

/**
 *
 * @author Admin
 */
public class ShoppingCart extends HttpServlet {

    private CartDAO cartDB = new CartDAO();
    private ProductDAO prodDB = new ProductDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ShoppingCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShoppingCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer c = (Customer) session.getAttribute("cusAcc");
        List<Item> cart = cartDB.getAllItem(c);
        List<Product> prodList = prodDB.getAllProduct();
        double total = 0;
        for (Item item : cart) {
            total += (item.getPrice() * item.getAmount());
        }
        request.setAttribute("prodList", prodList);
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        if (cart.size() != 0) {
            session.setAttribute("cartSize", cart.size());
        }
        request.getRequestDispatcher("customer/shopping-cart.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NumberFormatException {
        HttpSession session = request.getSession();
        Customer c = (Customer) session.getAttribute("cusAcc");
        int size = Integer.parseInt(request.getParameter("size"));
        int amount = Integer.parseInt(request.getParameter("amount"));
        int numModel = Integer.parseInt(request.getParameter("num_model"));
        Product p = prodDB.getProductByID(numModel);
        Item i = new Item(p.getNumModel(), amount, p.getPrice(), size);
        Item itemInCart = cartDB.getItemBySizeAndId(i, c);
        if (itemInCart != null) {
            i.setAmount(i.getAmount() + itemInCart.getAmount());
            cartDB.updateAmount(i, c);
        } else {
            cartDB.addToCart(i, c);
        }
        List<Item> list = cartDB.getAllItem(c);
        if (list.size() != 0) {
            session.setAttribute("cartSize", list.size());
        }
        response.sendRedirect("shopping-cart");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
