<%-- 
    Document   : sorted-product
    Created on : Feb 21, 2024, 9:36:25 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shoes Store</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>

        <!--Main layout-->
        <main style="margin-top: 100px; min-height: 85vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-2 fixed-left">
                        <div class="mb-3">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <c:forEach items="${categories}" var="c">
                                    <li class="nav-item acitve">
                                        <c:if test="${cateId != c.id}">
                                            <a class="nav-link fs-6 fw-bold" 
                                               href="show-product?id=${c.id}">${c.categoryName}</a>
                                        </c:if>
                                        <c:if test="${cateId == c.id}">
                                            <a class="nav-link fs-6 fw-bold text-decoration-underline" 
                                               href="show-product?id=${c.id}">${c.categoryName}</a>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <hr/>
                        <form action="show-product?id=${cateId}" method="post">
                            <input type="hidden" value="1" name="id"/>
                            <div>
                                <select name="price" class="form-select" aria-label="Large select example">
                                    <option selected>By Price</option>
                                    <option value="1">Cao đến thấp</option>
                                    <option value="2">Thấp đến cao</option>
                                </select>
                            </div> <hr/>

                            <div>
                                <p class="fs-6 fw-bold">Size</p>
                                <input type="checkbox" class="btn-check" id="btn-check-1" name="size" value="39" autocomplete="off">
                                <label class="btn" for="btn-check-1">39</label>
                                <input type="checkbox" class="btn-check" id="btn-check-2" name="size" value="40" autocomplete="off">
                                <label class="btn" for="btn-check-2">40</label>
                                <input type="checkbox" class="btn-check" id="btn-check-3" name="size" value="41" autocomplete="off">
                                <label class="btn" for="btn-check-3">41</label>
                                <input type="checkbox" class="btn-check" id="btn-check-4" name="size" value="42" autocomplete="off">
                                <label class="btn" for="btn-check-4">42</label>
                                <input type="checkbox" class="btn-check" id="btn-check-5" name="size" value="43" autocomplete="off">
                                <label class="btn mt-2" for="btn-check-5">43</label>
                                <input type="checkbox" class="btn-check" id="btn-check-6" name="size" value="44" autocomplete="off">
                                <label class="btn mt-2" for="btn-check-6">44</label>
                            </div>

                            <div class="mt-4">
                                <button class="btn btn-outline-dark" type="submit">Find</button>
                            </div>
                        </form>
                    </div>

                    <div class="col-md-10">
                        <!-- Products -->
                        <c:if test="${empty products}">
                            <p class="fs-5 text-center fw-bold opacity-25 align-middle">Do not have any product yet</p>
                        </c:if>

                        <c:if test="${not empty products}">
                            <section>
                                <div class="text-center">
                                    <div class="row">
                                        <c:forEach items="${products}" var="p">
                                            <div class="col-lg-4 col-md-6 mb-4">
                                                <div class="card">
                                                    <div class="bg-image hover-zoom ripple ripple-surface ripple-surface-light"
                                                         data-mdb-ripple-color="light">
                                                        <img src="images/${p.image}"
                                                             class="w-100" />
                                                    </div>
                                                    <div class="card-body">
                                                        <a href="product?num-model=${p.numModel}" class="text-reset">
                                                            <h5 class="card-title mb-2">${p.name}</h5>
                                                        </a>
                                                        <p>${p.category}</p>
                                                        <h6 class="mb-3 price">$${p.price}</h6>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </section>
                        </c:if>
                    </div>
                </div>
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

