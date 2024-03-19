<%-- 
    Document   : checkout
    Created on : Mar 4, 2024, 9:11:17 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
    </head>
    <body>
        <%@include file="../component/navbar.jsp" %>
        <!--Main layout-->
        <main class="mt-5 pt-4">
            <div class="container">
                <!-- Heading -->
                <h2 class="my-5 text-center">Checkout form</h2>

                <!--Grid row-->
                <div class="row">

                    <!--Grid column-->
                    <div class="col-md-8 mb-4">
                        <!--Card-->
                        <div class="card p-4">
                            <!--Grid row-->
                            <form action="checkout" method="post">
                                <input type="hidden" name="cusid" value="${cusAcc.id}">
                                <div class="row mb-3">
                                    <!--Grid column-->
                                    <div class="col-md-6 mb-2">
                                        <!--firstName-->
                                        <div class="form-outline">
                                            <input type="text" class="form-control" id="firstname"
                                                   name="fname" required="" value="${cusAcc.firstName}">
                                            <label class="form-label" for="firstname">First name</label>
                                        </div>
                                    </div>
                                    <!--Grid column-->

                                    <!--Grid column-->
                                    <div class="col-md-6 mb-2">
                                        <!--lastName-->
                                        <div class="form-outline">
                                            <input type="text" class="form-control" id="lastname"
                                                   name="lname" required="" value="${cusAcc.lastName}">
                                            <label class="form-label" for="lastname">Last name</label>
                                        </div>
                                    </div>
                                    <!--Grid column-->
                                </div>
                                <!--Grid row-->

                                <!--email-->
                                <p class="mb-0">
                                    Email
                                </p>
                                <div class="form-outline mb-4">
                                    <input type="email" class="form-control" id="email" 
                                           name="email" required="" value="${cusAcc.email}">
                                </div>

                                <!--address-->
                                <p class="mb-0">
                                    Address
                                </p>
                                <div class="form-outline mb-4">
                                    <input type="text" class="form-control" id="address" 
                                           name="address" value="${cusAcc.address}">
                                </div>

                                <!--Grid row-->
                                <div class="row">
                                    <!--Grid column-->
                                    <div class="col-lg-4 col-md-12 mb-4">
                                        <label for="province" class="form-label">City/Province</label>
                                        <input type="text" class="form-control" id="province"
                                               name="province" value="${cusAcc.province}">
                                    </div>
                                    <!--Grid column-->

                                    <!--Grid column-->
                                    <div class="col-lg-4 col-md-12 mb-4">
                                        <label for="district" class="form-label">District</label>
                                        <input type="text" class="form-control" id="district"
                                               name="district" value="${cusAcc.district}">
                                    </div>
                                    <!--Grid column-->

                                    <!--Grid column-->
                                    <div class="col-lg-4 col-md-12 mb-4">
                                        <label for="ward" class="form-label">Ward</label>
                                        <input type="text" class="form-control" id="ward"
                                               name="ward" value="${cusAcc.ward}">
                                    </div>
                                    <!--Grid column-->
                                </div>
                                <button class="btn btn-primary" type="submit">Continue to checkout</button>
                            </form>
                        </div>
                        <!--/.Card-->
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-md-4 mb-4">
                        <!-- Heading -->
                        <h4 class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted">Your cart</span>
                        </h4>

                        <!-- Cart -->
                        <ul class="list-group mb-3">

                            <c:forEach items="${cart}" var="c">
                                <c:forEach items="${prodList}" var="p">
                                    <c:if test="${c.numModel == p.numModel}">
                                        <li class="list-group-item d-flex justify-content-between">
                                            <div>
                                                <h6 class="my-0">${p.name}</h6>
                                                <small class="text-muted">Size: ${c.size}</small>
                                                <small class="text-muted ms-2">Quantity: ${c.amount}</small>
                                            </div>
                                            <span class="text-muted">$${p.price}</span>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>

                            <li class="list-group-item d-flex justify-content-between">
                                <span>Total (USD)</span>
                                <strong>${total}</strong>
                            </li>
                        </ul>
                        <!-- Cart -->
                    </div>
                    <!--Grid column-->
                </div>
                <!--Grid row-->
            </div>
        </main>
        <!--Main layout-->

        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
