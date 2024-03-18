<%-- 
    Document   : admin-orders
    Created on : Mar 11, 2024, 8:15:13 PM
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
        <main style="margin-top: 100px; min-height: 84vh">
            <c:if test="${not empty orders}">
                <div class="container-fluid">
                    <div class="card" style="box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3)">
                        <div class="card-body">
                            <p class="text-center fs-4 fw-bold">Orders List</p>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer Name</th>
                                        <th>Order Date</th>
                                        <th>Address</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="o">
                                        <tr>
                                            <td>${o.orderID}</td>
                                            <c:forEach items="${customers}" var="c">
                                                <c:if test="${o.customerID == c.id}">
                                                    <td>${c.firstName} ${c.lastName}</td>
                                                </c:if>
                                            </c:forEach>
                                            <td>${o.orderDate}</td>
                                            <td>${o.address}</td>
                                            <td>
                                                <c:if test="${o.status == 'Pending'}">
                                                    <p class="btn btn-sm btn-warning text-white">
                                                        <i class="fa-regular fa-clock me-2"></i> ${o.status}
                                                    </p>
                                                </c:if>
                                                <c:if test="${o.status == 'On delivery'}">
                                                    <p class="btn btn-sm btn-primary text-white">
                                                        <i class="fa-solid fa-truck-fast"></i> ${o.status}
                                                    </p>
                                                </c:if>
                                                <c:if test="${o.status == 'Received'}">
                                                    <p class="btn btn-sm btn-success text-white">
                                                        <i class="fa-solid fa-check"></i></i> ${o.status}
                                                    </p>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${o.status == 'Pending'}">
                                                    <a href="order-controller?action=accept&order_id=${o.orderID}" class="btn btn-sm btn-success text-white">Deliver</a>
                                                </c:if>
                                                <a href="order-controller?action=detail&order_id=${o.orderID}" class="btn btn-sm btn-secondary text-white">Detail</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${empty orders}">
                <p class="fs-5 text-center fw-bold opacity-25 align-middle">Do not have any order yet</p>
            </c:if>
        </main>

        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
