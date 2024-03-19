/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.CartDAO;
import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Customer;
import model.Item;
import model.Order;
import model.OrderDetails;
import model.Product;

/**
 *
 * @author Admin
 */
public class CheckOut extends HttpServlet {

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
            out.println("<title>Servlet CheckOut</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckOut at " + request.getContextPath() + "</h1>");
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
        CartDAO cartDB = new CartDAO();
        ProductDAO prodDB = new ProductDAO();
        List<Item> cart = cartDB.getAllItem(c);
        if (cart.isEmpty()) {
            session.setAttribute("msg", "Fail");
            response.sendRedirect("shopping-cart");
        }
        List<Product> prodList = prodDB.getAllProduct();
        double total = 0;
        for (Item item : cart) {
            total += (item.getPrice() * item.getAmount());
        }
        request.setAttribute("prodList", prodList);
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
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
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer c = (Customer) session.getAttribute("cusAcc");
        String address = request.getParameter("address");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String s = province + ", " + district + ", " + ward + ", " + address;
        CartDAO cartDB = new CartDAO();
        List<Item> cart = cartDB.getAllItem(c);

        OrderDAO orderDB = new OrderDAO();
        OrderDetailsDAO odDB = new OrderDetailsDAO();
        ProductDAO prodDB = new ProductDAO();

        // create order
        Order o = new Order(c.getId(), s, getCurrentDate(), "Pending");
        int check1 = orderDB.addOrder(o);
        // get newest order
        Order tmp = orderDB.getNewestOrder();
        OrderDetails od = new OrderDetails();
        Product p = new Product();
        int check2 = 0;
        int check3 = 0;
        // add to order details
        for (Item item : cart) {
            od = new OrderDetails(tmp.getOrderID(), item.getNumModel(), item.getAmount(), item.getPrice(), item.getSize());
            if (!odDB.addOrderDetails(od)) {
                check2++;
            }
            p = prodDB.getProductBySizeAndID(item.getNumModel(), item.getSize());
            p.setAmount(p.getAmount() - item.getAmount());
            if (!prodDB.updateProductAmount(p)) {
                check3++;
            }
        }
        int check4 = cartDB.deleteByCid(c);
        session.removeAttribute("cartSize");
        if ((check1 == 1) && (check2 == 0)) {
            session.setAttribute("omsg", "Success");
            session.setAttribute("orderID", tmp.getOrderID());
        } else {
            session.setAttribute("omsg", "Fail");
        }
        response.sendRedirect("home");
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

    private static String getCurrentDate() {
        Date thisDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(thisDate);
    }
}
