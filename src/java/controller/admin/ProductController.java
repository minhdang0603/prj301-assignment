/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.CategoriesDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author Admin
 */
@MultipartConfig()
public class ProductController extends HttpServlet {

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
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
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
        CategoriesDAO cateDB = new CategoriesDAO();
        ProductDAO prodDB = new ProductDAO();
        HttpSession session = request.getSession();

        // show add product page
        if (action.equals("add")) {
            List<Category> cateList = cateDB.getAllCategories();
            request.setAttribute("cateList", cateList);
            request.getRequestDispatcher("admin/add-product.jsp").forward(request, response);
        }

        // add product
        if (action.equals("adding")) {
            try {
                String productName = request.getParameter("name");
                int categoryID = Integer.parseInt(request.getParameter("category"));
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("summary");
                Part part = request.getPart("image");
                String image = getFileName(part);
                String path = getServletContext().getRealPath("/images" + File.separator + image);
                part.write(path);
                Product p = new Product(productName, image, price, description);
                if (prodDB.addProduct(p, categoryID)) {
                    Product newest = prodDB.getNewestProduct();
                    for (int i = 39; i < 45; i++) {
                        prodDB.addProductSizeAndAmount(newest, i);
                    }
                    session.setAttribute("msg", "Success");
                } else {
                    session.setAttribute("msg", "Fail");
                }
                response.sendRedirect("product-controller?action=add");
            } catch (NumberFormatException e) {
            }
        }

        // delete product
        if (action.equals("delete")) {
            try {
                int numModel = Integer.parseInt(request.getParameter("id"));
                if (prodDB.deleteProduct(numModel)) {
                    session.setAttribute("msg", "delete");
                } else {
                    session.setAttribute("msg", "!delete");
                }

                response.sendRedirect("admin-page?action=product");
            } catch (NumberFormatException e) {
            }
        }

        // show edit product page
        if (action.equals("edit")) {
            try {
                int numModel = Integer.parseInt(request.getParameter("id"));
                Product p = prodDB.getProductByID(numModel);
                List<Category> cateList = cateDB.getAllCategories();
                List<Product> sizeList = prodDB.getProductSizeAndAmount(numModel);
                int cateID = 0;
                for (Category c : cateList) {
                    if (c.getCategoryName().equalsIgnoreCase(p.getCategory())) {
                        cateID = c.getId();
                    }
                }
                request.setAttribute("cateList", cateList);
                request.setAttribute("cateID", cateID);
                request.setAttribute("product", p);
                request.setAttribute("sizes", sizeList);
                request.getRequestDispatcher("admin/edit-product.jsp").forward(request, response);
            } catch (NumberFormatException e) {
            }
        }

        // update product
        if (action.equals("update")) {
            try {
                // get infor from update form
                int numModel = Integer.parseInt(request.getParameter("num_model"));
                String productName = request.getParameter("name");
                int categoryID = Integer.parseInt(request.getParameter("category"));
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("summary");
                Part part = request.getPart("image");
                String image = getFileName(part);
                if (image.isEmpty()) {
                    image = request.getParameter("origin");
                }
                Product p = new Product(numModel, productName, image, price, description);
                String[] quantity = request.getParameterValues("quantity");
                int size = 39;
                if (prodDB.updateProduct(p, categoryID)) {
                    for (int i = 0; i < quantity.length; i++) {
                        p.setSize(size);
                        size++;
                        p.setAmount(Integer.parseInt(quantity[i]));
                        prodDB.updateProductAmount(p);
                    }
                    session.setAttribute("msg", "update");
                } else {
                    session.setAttribute("msg", "!update");
                }
                response.sendRedirect("admin-page?action=product");
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

    private String getFileName(Part part) {
        String contentDispositon = part.getHeader("content-disposition");

        if (!contentDispositon.contains("filename=")) {
            return null;
        }

        int beginIndex = contentDispositon.indexOf("filename=") + 10;
        int endIndex = contentDispositon.length() - 1;

        return contentDispositon.substring(beginIndex, endIndex);
    }

}
