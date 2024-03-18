/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.CustomerDAO;
import dal.OrderDAO;
import dal.OrderDetailsDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Customer;
import model.Order;
import model.OrderDetails;
import model.Product;

/**
 *
 * @author Admin
 */
public class OrderController extends HttpServlet {

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
            out.println("<title>Servlet AdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        int orderID = Integer.parseInt(request.getParameter("order_id"));
        OrderDAO orderDB = new OrderDAO();
        OrderDetailsDAO odDB = new OrderDetailsDAO();
        ProductDAO prodDB = new ProductDAO();
        CustomerDAO cusDB = new CustomerDAO();
        Order order = orderDB.getOrderByOid(orderID);
        if (action.equals("detail")) {
            List<Product> prodList = prodDB.getAllProduct();
            List<OrderDetails> odList = odDB.getOrderDetailsByOid(orderID);
            Customer c = cusDB.getCustomerById(order.getCustomerID());
            double total = 0;
            for (OrderDetails od : odList) {
                total += od.getPrice() * od.getQuantity();
            }
            request.setAttribute("total", total);
            request.setAttribute("customer", c);
            request.setAttribute("order", order);
            request.setAttribute("odList", odList);
            request.setAttribute("prodList", prodList);
            request.getRequestDispatcher("admin/admin-order-details.jsp").forward(request, response);
        }
        
        if (action.equals("accept")) {
            if (order.getStatus().equalsIgnoreCase("pending")) {
                order.setStatus("On delivery");
                System.out.println(orderDB.updateStatus(order));
                response.sendRedirect("admin-page?action=pending");
            }
        }
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
        doGet(request, response);
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
