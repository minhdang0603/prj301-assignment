/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.CustomerDAO;
import dal.OrderDAO;
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
import model.Order;
import model.Product;

/**
 *
 * @author Admin
 */
public class AdminHome extends HttpServlet {

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
            out.println("<title>Servlet AdminHome</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminHome at " + request.getContextPath() + "</h1>");
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
        ProductDAO prodDB = new ProductDAO();
        OrderDAO orderDB = new OrderDAO();
        CustomerDAO cusDB = new CustomerDAO();
        List<Customer> cusList = cusDB.getAll();
        List<Product> prodList = prodDB.getAllProduct();
        List<Order> pendingList = orderDB.getOrderByStatus("Pending");
        List<Order> onDeliveryList = orderDB.getOrderByStatus("On delivery");
        List<Order> deliveredList = orderDB.getOrderByStatus("Received");
        if (action == null) {
            request.setAttribute("prodSize", prodList.size());
            request.setAttribute("pending", pendingList.size());
            request.setAttribute("onDelivery", onDeliveryList.size());
            request.setAttribute("delivered", deliveredList.size());
            request.getRequestDispatcher("admin/admin-home.jsp").forward(request, response);
        } else {
            if (action.equals("logout")) {
                HttpSession session = request.getSession();
                session.removeAttribute("admin");
                response.sendRedirect("home");
            }
            
            if (action.equals("pending")) {
                request.setAttribute("customers", cusList);
                request.setAttribute("orders", pendingList);
                request.getRequestDispatcher("admin/admin-orders.jsp").forward(request, response);
            }
            
            if (action.equals("delivery")) {
                request.setAttribute("customers", cusList);
                request.setAttribute("orders", onDeliveryList);
                request.getRequestDispatcher("admin/admin-orders.jsp").forward(request, response);
            }
            
            if (action.equals("delivered")) {
                request.setAttribute("customers", cusList);
                request.setAttribute("orders", deliveredList);
                request.getRequestDispatcher("admin/admin-orders.jsp").forward(request, response);
            }
            
            if (action.equals("product")) {
                request.setAttribute("products", prodList);
                request.getRequestDispatcher("admin/admin-product.jsp").forward(request, response);
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
        processRequest(request, response);
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
