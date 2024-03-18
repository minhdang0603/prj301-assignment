<%-- 
    Document   : add-product
    Created on : Mar 12, 2024, 8:54:06 AM
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
        <link rel="stylesheet" href="css/profilecss.css"/>  
    </head>
    <body>
        <%@include file="admin-navbar.jsp"%>

        <main style="margin-top: 100px; min-height: 84vh">
            <div class="container-fluid mt-5">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card shadow">
                            <div class="card-body">
                                <p class="text-center text-dark fs-3 fw-light">Add New Shoe</p>

                                <form class="form" action="product-controller" method="POST" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="adding">
                                    <div class="container">
                                        <div class="row">
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="form-label">Product Name</label>
                                                <input type="text" name="name" required class="form-control">
                                            </div>
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="form-label">Category</label>
                                                <select name="category" class="form-select">
                                                    <option>Choose Category</option>
                                                    <c:forEach items="${cateList}" var="c">
                                                        <option value="${c.id}">${c.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="form-label" >Price($)</label>
                                                <input type="number" step="0.01" name="price" required class="form-control">
                                            </div>
                                            <div class="form-group col-md-6 mb-3">
                                                <label for="formFile" class="form-label">Book Image</label>
                                                <input class="form-control" name="image" type="file" required id="formFile">
                                            </div>
                                            <div class="form-group mb-4">
                                                <label for="floatingTextarea2" class="form-label">Description</label>
                                                <textarea class="form-control" placeholder="Enter shoe's description" id="floatingTextarea2" name="summary" style="height: 200px" required></textarea>   
                                            </div>

                                            <button class="btn btn-sm btn-success col-md-6 offset-md-3 mb-3" type="submit">Add Product</button>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Message-->
            <div id="toastBox">
                <c:set var="msg" value="${msg}"></c:set>
                <c:remove scope="session" var="msg"></c:remove>
                <div id="message">${msg}</div>
            </div>

        </main>


        <script src="bootstrap/bootstrap.bundle.min.js"></script>
        <script>
            let toastBox = document.getElementById("toastBox");
            let msg = document.getElementById("message").innerHTML;
            let toast = document.createElement("div");
            toast.classList.add("toast");

            if (msg === "Success") {
                toast.innerHTML = '<i class="fa-solid fa-circle-check"></i> Add product successfully!';
                toastBox.appendChild(toast);
            }

            if (msg === "Fail") {
                toast.classList.add("error");
                toast.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Fail to add product! Please try again';
                toastBox.appendChild(toast);
            }

            setTimeout(() => {
                toast.remove();
            }, 6000);
        </script>
    </body>
</html>
