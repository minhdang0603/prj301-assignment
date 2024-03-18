/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

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
import java.util.List;
import model.Customer;
import model.Order;
import model.OrderDetails;
import model.Product;

/**
 *
 * @author Admin
 */
public class OrdersServlet extends HttpServlet {

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
            out.println("<title>Servlet ShowOrders</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowOrders at " + request.getContextPath() + "</h1>");
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
        String service = request.getParameter("service");
        OrderDAO orderDB = new OrderDAO();
        OrderDetailsDAO odDB = new OrderDetailsDAO();
        HttpSession session = request.getSession();
        
        // show orders
        if (service.equals("show")) {
            Customer c = (Customer) session.getAttribute("cusAcc");
            List<Order> ordList = orderDB.getOrderByCid(c);
            request.setAttribute("orders", ordList);
            request.getRequestDispatcher("customer/show-orders.jsp").forward(request, response);
        }
        
        // delete order
        if (service.equals("cancel")) {
            String orderId_raw = request.getParameter("id");
            int orderId;
            try {
                orderId = Integer.parseInt(orderId_raw);
                if (orderDB.deleteOrder(orderId) == 1) {
                    session.setAttribute("msg", "Success");
                } else {
                    session.setAttribute("msg", "Fail");
                }
                response.sendRedirect("orders?service=show");
            } catch (NumberFormatException e) {
            }
        }
        
        // show order details
        if (service.equals("detail")) {
            String orderId_raw = request.getParameter("id");
            int orderId;
            ProductDAO prodDB = new ProductDAO();
            try {
                orderId = Integer.parseInt(orderId_raw);
                List<OrderDetails> odList = odDB.getOrderDetailsByOid(orderId);
                List<Product> prodList = prodDB.getAllProduct();
                double total = 0;
                for (OrderDetails od : odList) {
                    total += od.getPrice() * od.getQuantity();
                }
                Order o = orderDB.getOrderByOid(orderId);
                request.setAttribute("order", o);
                request.setAttribute("total", total);
                request.setAttribute("odList", odList);
                request.setAttribute("prodList", prodList);
                request.getRequestDispatcher("customer/order-details.jsp").forward(request, response);
            } catch (NumberFormatException e) {
            }
        }
        
        // confirm received
        if (service.equals("received")) {
            String orderId_raw = request.getParameter("id");
            int orderId;
            try {
                orderId = Integer.parseInt(orderId_raw);
                Order o = orderDB.getOrderByOid(orderId);
                o.setStatus("Received");
                orderDB.updateStatus(o);
                response.sendRedirect("orders?service=show");
            } catch (NumberFormatException e) {
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
