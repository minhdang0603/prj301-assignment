<%-- 
    Document   : admin-home.jsp
    Created on : Mar 10, 2024, 8:16:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
    </head>
    <body>
        <%@include file="admin-navbar.jsp" %>

        <div class="container mt-5 p-5">
            <p class="text-center fs-3">Admin Dashboard</p>
            <div class="row">
                <div class="col-md-4 offset-md-2">
                    <div class="card paint-card">
                        <div class="card-body text-center text-dark">
                            <i class="fa-solid fa-store fs-1"></i><br>
                            <p class="fs-4 text-center">
                                Total Shoes ${prodSize}
                            </p>
                            <a href="admin-page?action=product" class="btn btn-outline-dark">Detail</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card paint-card">
                        <div class="card-body text-center text-dark">
                            <i class="fa-solid fa-user-check fs-2"></i><br/>
                            <p class="fs-4 text-center">
                                Pending ${pending}
                            </p>
                            <a href="admin-page?action=pending" class="btn btn-outline-dark">Detail</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 offset-md-2 mt-4">
                    <div class="card paint-card">
                        <div class="card-body text-center text-dark">
                            <i class="fa-solid fa-truck-fast fs-1"></i><br/>
                            <p class="fs-4 text-center">
                                On delivery ${onDelivery}
                            </p>
                            <a href="admin-page?action=delivery" class="btn btn-outline-dark">Detail</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mt-4">
                    <div class="card paint-card">
                        <div class="card-body text-center text-dark">
                            <i class="fa-regular fa-circle-check fs-1"></i><br/>
                            <p class="fs-4 text-center">
                                Delivered ${delivered}
                            </p>
                            <a href="admin-page?action=delivered" class="btn btn-outline-dark">Detail</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
