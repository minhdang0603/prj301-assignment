<%-- 
    Document   : edit-product
    Created on : Mar 18, 2024, 5:37:32 PM
    Author     : TaDang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
    </head>
    <body>

        <%@include file="admin-navbar.jsp"%>

        <main style="margin-top: 100px; min-height: 84vh">

            <div class="container-fluid mt-5">
                <div class="row">
                    <div class="col-md-6">
                        <!--Grid row-->
                        <div class="row">
                            <!--Grid column-->
                            <div class="col-md-6 mb-4">
                                <img src="images/${product.image}" class="img-fluid" alt="" />
                            </div>
                            <!--Grid column-->

                            <!--Grid column-->
                            <div class="col-md-6 mb-4">
                                <!--Content-->
                                <div class="p-4">
                                    <div class="mb-3">
                                        <span class="badge bg-dark me-1 fs-6">${product.category}</span>
                                    </div>

                                    <div class="mb-3">
                                        <p class="fs-4 fw-bold">${product.name}</p>
                                    </div>  

                                    <p class="lead">
                                        <span>$${product.price}</span> 
                                    </p>


                                    <div class="d-flex flex-column justify-content-left">
                                        <div>
                                            <p class="fs-5 fw-bold">Size and Quantity</p>
                                            <table class="table table-borderless">
                                                <tr>
                                                    <th>Size</th>
                                                        <c:forEach items="${sizes}" var="s">
                                                        <td>${s.size}</td>
                                                    </c:forEach>
                                                </tr>
                                                <tr>
                                                    <th>Quantity</th>
                                                        <c:forEach items="${sizes}" var="s">
                                                        <td>${s.amount}</td>
                                                    </c:forEach>
                                                </tr>
                                            </table>

                                        </div>
                                    </div>

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

                    <div class="col-md-6">
                        <p class="text-center text-dark fs-3 fw-light">Edit Shoe</p>

                        <form action="product-controller" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="num_model" value="${product.numModel}">
                            <input type="hidden" name="origin" value="${product.image}">
                            <div class="container">
                                <div class="row">
                                    <div class="form-group col-md-6 mb-3">
                                        <label class="form-label">Product Name</label>
                                        <input type="text" name="name" required class="form-control" value="${product.name}">
                                    </div>
                                    <div class="form-group col-md-6 mb-3">
                                        <label class="form-label">Category</label>
                                        <select name="category" class="form-select">
                                            <c:forEach items="${cateList}" var="c">
                                                <c:if test="${product.category == c.categoryName}">
                                                    <option value="${c.id}" selected="">${c.categoryName}</option>
                                                </c:if>
                                                <c:if test="${product.category != c.categoryName}">
                                                    <option value="${c.id}">${c.categoryName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6 mb-3">
                                        <label class="form-label" >Price($)</label>
                                        <input type="number" step="0.01" name="price" value="${product.price}" required class="form-control">
                                    </div>
                                    <div class="form-group col-md-6 mb-3">
                                        <label for="formFile" class="form-label">Book Image</label>
                                        <input class="form-control" name="image" accept="image/*,.pdf" value="images/${product.image}" type="file" id="formFile">
                                    </div>
                                    <c:forEach items="${sizes}" var="s">
                                        <div class="form-group col-md-4 mb-3">
                                            <div class="input-group">
                                                <span class="input-group-text" id="basic-addon1">Size ${s.size}</span>
                                                <input type="number" class="form-control" name="quantity" value="${s.amount}" aria-describedby="basic-addon1">
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <div class="form-group mb-4">
                                        <label for="floatingTextarea2" class="form-label">Description</label>
                                        <textarea class="form-control" id="floatingTextarea2" name="summary" style="height: 200px" required>${product.description}</textarea>   
                                    </div>

                                    <button class="btn btn-sm btn-success col-md-6 offset-md-3 mb-3">Update</button>
                                </div>
                            </div>
                        </form>      
                    </div>
                </div>
        </main>


        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
