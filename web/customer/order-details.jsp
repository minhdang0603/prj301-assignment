<%-- 
    Document   : order-details
    Created on : Mar 10, 2024, 4:31:42 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
    </head>
    <body>
        <%@include file="../component/navbar.jsp"%>
        <main style="margin-top: 100px; min-height: 84vh">
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-6 offset-md-1">
                        <c:forEach items="${odList}" var="od">
                            <c:forEach items="${prodList}" var="p">
                                <c:if test="${od.numModel == p.numModel}">
                                    <hr/>
                                    <div class="mb-3">
                                        <div class="row container">
                                            <div class="col-md-4">
                                                <img src="images/${p.image}" class="img-thumbnail rounded-start" alt="">
                                            </div>
                                            <div class="col-md-8">
                                                <div class="d-flex">
                                                    <div class="d-flex align-items-start flex-column">
                                                        <p class="fw-bold"> 
                                                            <a href="product?num-model=${p.numModel}" 
                                                               class="text-reset link-offset-3-hover link-underline-dark link-underline-opacity-0 link-underline-opacity-75-hover">
                                                                ${p.name}
                                                            </a>
                                                        </p>
                                                        <p class="text-secondary">${p.category}</p>
                                                        <div>
                                                            <span class="text-secondary">Size: ${od.size}</span>
                                                            <span class="text-secondary ms-3">Quantity: ${od.quantity}</span>
                                                        </div>
                                                    </div>
                                                    <p class="fw-bold ms-auto">$${p.price}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                        <hr/>
                    </div>
                    <div class="col-md-3 ms-1">
                        <label class="form-label">Order</label>
                        <input type="text" class="form-control" disabled="" value="${order.orderID}">
                        <label class="form-label">Customer Name</label>
                        <input type="text" class="form-control" disabled="" value="${cusAcc.firstName} ${cusAcc.lastName}">
                        <label class="form-label">Order Date</label>
                        <input type="text" class="form-control" disabled="" value="${order.orderDate}">
                        <label class="form-label">Address</label>
                        <textarea rows="3" cols="50" disabled="">${order.address}</textarea>
                        <div class="d-flex">
                            <p class="fs-4">Total: </p>
                            <p class="ms-auto fs-4">$${total}</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
