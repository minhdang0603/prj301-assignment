<%-- 
    Document   : home
    Created on : Feb 18, 2024, 4:11:41 PM
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
        <link rel="stylesheet" href="css/homecss.css"/>
        <style>
            #toastBox{
                position: absolute;
                bottom: 30px;
                right: 30px;
                display: flex;
                align-items: flex-end;
                flex-direction: column;
                overflow: hidden;
                padding: 20px;
            }

            .toast:not(.show) {
                display: flex;
                align-items: center;
            }

            .toast {
                width: 400px;
                height: 80px;
                background: #fff;
                font-weight: 500;
                margin: 15px 0;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
                position: relative;
                transform: translateX(100%);
                animation: moveleft 0.5s linear;
                animation-fill-mode: forwards;
            }

            @keyframes moveleft {
                100%{
                    transform: translateX(0);
                }
            }

            .toast i {
                margin: 0 20px;
                font-size: 45px;
                color: green;

            }

            .toast.error i {
                color: red;
            }

            .toast:after{
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 100%;
                height: 5px;
                background: green;
                animation: anim 6s linear;
                animation-fill-mode: forwards;
            }

            @keyframes anim {
                100%{
                    width: 0;
                }
            }

            .toast.error:after {
                background: red;
            }

            #message {
                display: none;
            }
        </style>
    </head>
    <body>
        <%@include file="component/navbar.jsp" %>

        <!--Main layout-->
        <main style="margin-top: 50px; min-height: 85vh">
            <div class="container">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-dark mt-3 mb-5 shadow p-2" style="background-color: #607D8B">
                    <!-- Container wrapper -->
                    <div class="container-fluid">

                        <!-- Navbar brand -->
                        <p class="navbar-brand me-3" style="margin: 0">Categories:</p>

                        <!-- Toggle button -->
                        <button 
                            class="navbar-toggler" 
                            type="button" 
                            data-mdb-toggle="collapse" 
                            data-mdb-target="#navbarSupportedContent2" 
                            aria-controls="navbarSupportedContent2" 
                            aria-expanded="false" 
                            aria-label="Toggle navigation">
                            <i class="fas fa-bars"></i>
                        </button>

                        <!-- Collapsible wrapper -->
                        <div class="collapse navbar-collapse" id="navbarSupportedContent2">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                                <!-- Link -->
                                <li class="nav-item acitve">
                                    <a class="nav-link text-white" href="home">All</a>
                                </li>
                                <c:forEach items="${categories}" var="c">
                                    <li class="nav-item acitve">
                                        <a class="nav-link text-white" 
                                           href="show-product?id=${c.id}">${c.categoryName}</a>
                                    </li>
                                </c:forEach>

                            </ul>

                            <!-- Search -->
                            <form method="post" action="home" class="w-auto py-1" style="max-width: 12rem">
                                <input type="search" name="search" class="form-control rounded-0" placeholder="Search" aria-label="Search">
                            </form>

                        </div>
                    </div>
                    <!-- Container wrapper -->
                </nav>
                <!-- Navbar -->

                <!-- Products -->
                <c:if test="${empty products}">
                    <p class="fs-5 text-center fw-bold opacity-25 align-middle">Do not have any product yet</p>
                </c:if>

                <c:if test="${not empty products}">
                    <section>
                        <div class="text-center">
                            <div class="row">
                                <c:forEach items="${products}" var="p">
                                    <div class="col-lg-3 col-md-6 mb-4">
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
        </main>
        <!--Main layout-->
        
        <!--Message-->
        <div id="toastBox">
            <c:set var="msg" value="${omsg}"></c:set>
            <c:remove scope="session" var="omsg"></c:remove>
            <div id="message">${msg}</div>
        </div>

        <footer class="text-center text-white mt-4" style="background-color: #607D8B">
            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2); text-color: #E0E0E0">
                © 2022 Copyright:
                <a class="text-white" href="https://mdbootstrap.com/">MDBootstrap.com</a>
            </div>
            <!-- Copyright -->
        </footer>
        <script src="bootstrap/bootstrap.bundle.min.js"></script>
        <script>
            let toastBox = document.getElementById("toastBox");
            let msg = document.getElementById("message").innerHTML;
            let toast = document.createElement("div");
            toast.classList.add("toast");

            if (msg === "Success") {
                toast.innerHTML = '<i class="fa-solid fa-circle-check"></i> Order Successfully! Your order\'s id is ${orderID}';
                toastBox.appendChild(toast);
            }

            if (msg === "Fail") {
                toast.classList.add("error");
                toast.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Fail to orders! Please try again';
                toastBox.appendChild(toast);
            }

            setTimeout(() => {
                toast.remove();
            }, 6000);
        </script>
        <c:remove scope="session" var="orderID"></c:remove>
    </body>
</html>
