<%-- 
    Document   : shopping-cart
    Created on : Feb 29, 2024, 11:32:17 AM
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
        <%@include file="../component/navbar.jsp" %>
        <main style="margin-top: 100px; min-height: 84vh">
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-6 offset-md-1">
                        <c:forEach items="${cart}" var="c">
                            <c:forEach items="${prodList}" var="p">
                                <c:if test="${c.numModel == p.numModel}">
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
                                                            <span class="text-secondary">Size: ${c.size}</span>
                                                            <span class="text-secondary ms-3">Quantity: ${c.amount}</span>
                                                        </div>
                                                        <a href="delete?num_model=${c.numModel}&size=${c.size}" class="mt-4 text-secondary-emphasis fs-4 p-0">
                                                            <i class="fa-regular fa-trash-can"></i>
                                                        </a>
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
                        <h2 class="">Summary</h2>
                        <div class="d-flex">
                            <p class="fs-4">Total: </p>
                            <p class="ms-auto fs-4">$${total}</p>
                        </div>
                        <form action="checkout" method="get">
                            <input type="hidden" name="cus_id" value="${cusAcc.id}"/>
                            <button class="btn btn-dark form-control" type="submit">Check Out</button>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
