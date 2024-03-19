<%-- 
    Document   : product
    Created on : Feb 26, 2024, 8:48:08 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Page</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
    </head>
    <body>
        <%@include file="component/navbar.jsp"%>

        <!--Main layout-->
        <main style="margin-top: 100px; min-height: 84vh">
            <div class="container mt-5">
                <!--Grid row-->
                <div class="row">
                    <!--Grid column-->
                    <div class="col-md-4 offset-md-2 mb-4">
                        <img src="images/${product.image}" class="img-fluid" alt="" />
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-md-4">
                        <!--Content-->
                        <div class="p-4">
                            <div class="mb-3">
                                <a href="show-product?id=${cateID}">
                                    <span class="badge bg-dark me-1 fs-6">${product.category}</span>
                                </a>
                            </div>

                            <div class="mb-3">
                                <p class="fs-4 fw-bold">${product.name}</p>
                            </div>  

                            <p class="lead">
                                <span>$${product.price}</span>
                            </p>


                            <form class="d-flex flex-column justify-content-left" method="post" action="shopping-cart">
                                <input type="hidden" name="num_model" value="${product.numModel}"/>
                                <div>
                                    <p class="fs-5 fw-bold">Size</p>
                                    <c:forEach items="${sizes}" var="s">
                                        <c:if test="${s.amount == 0}">
                                            <input type="radio" disabled class="btn-check" id="btn-check-${s.size}" name="size" value="${s.size}" autocomplete="off">
                                        </c:if>
                                        <c:if test="${s.amount != 0}">
                                            <input type="radio" required="" class="btn-check" id="btn-check-${s.size}" name="size" value="${s.size}" autocomplete="off">
                                        </c:if>
                                        <label class="btn" for="btn-check-${s.size}">${s.size}</label>
                                    </c:forEach>
                                </div>
                                <!-- Default input -->
                                <div class="form-outline me-1 mt-2" style="width: 100px;">
                                    <input type="number" min="1" value="1" name="amount" class="form-control" />
                                    <button class="btn btn-primary ms-1 mt-2" 
                                            type="submit"
                                            style="width: 200px">
                                        Add to cart
                                        <i class="fas fa-shopping-cart ms-1"></i>
                                    </button>
                                </div>
                            </form>

                            <div class="mt-3">
                                <p class="fs-5 fw-bold">Description</p>
                                <p>${product.description}</p>
                            </div>
                        </div>
                        <!--Content-->
                    </div>
                    <!--Grid column-->
                </div>
                <!--Grid row-->
            </div>
        </main>
        <!--Main layout-->

        <footer class="text-center text-white mt-4" style="background-color: #607D8B">
            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2); text-color: #E0E0E0">
                © 2022 Copyright:
                <a class="text-white" href="https://mdbootstrap.com/">MDBootstrap.com</a>
            </div>
            <!-- Copyright -->
        </footer>
        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
