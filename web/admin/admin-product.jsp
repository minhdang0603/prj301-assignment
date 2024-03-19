<%-- 
    Document   : admin-product
    Created on : Mar 12, 2024, 7:56:56 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Product</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/profilecss.css"/>
    </head>
    <body>
        <%@include file="admin-navbar.jsp"%>

        <main style="margin-top: 100px; min-height: 84vh">
            <c:if test="${not empty products}">
                <div class="container">
                    <div class="card" style="box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3)">
                        <div class="card-body">
                            <p class="text-center fs-4 fw-bold">Product List</p>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Product ID</th>
                                        <th>Product Name</th>
                                        <th>Price</th>
                                        <th>Category</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${products}" var="p">
                                        <tr>
                                            <td>${p.numModel}</td>
                                            <td>${p.name}</td>
                                            <td>$${p.price}</td>
                                            <td>${p.category}</td>
                                            <td>
                                                <a href="product-controller?action=edit&id=${p.numModel}" class="btn btn-sm btn-primary text-white">Edit</a>
                                                <a href="product-controller?action=delete&id=${p.numModel}" class="btn btn-sm btn-danger text-white">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty products}">
                <p class="fs-5 text-center fw-bold opacity-25 align-middle">Do not have any order yet</p>
            </c:if>
        </main>

        <!--Message-->
        <div id="toastBox">
            <c:set var="msg" value="${msg}"></c:set>
            <c:remove scope="session" var="msg"></c:remove>
            <div id="message">${msg}</div>
        </div>

        <script src="bootstrap/bootstrap.bundle.min.js"></script>
        <script>
            let toastBox = document.getElementById("toastBox");
            let msg = document.getElementById("message").innerHTML;
            let toast = document.createElement("div");
            toast.classList.add("toast");

            if (msg === "delete") {
                toast.innerHTML = '<i class="fa-solid fa-circle-check"></i> Delete product successfully!';
                toastBox.appendChild(toast);
            }
            
            if (msg === "update") {
                toast.innerHTML = '<i class="fa-solid fa-circle-check"></i> Update product successfully!';
                toastBox.appendChild(toast);
            }

            if (msg === "!delete") {
                toast.classList.add("error");
                toast.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Fail to delete product! Please try again';
                toastBox.appendChild(toast);
            }
            
            if (msg === "!update") {
                toast.classList.add("error");
                toast.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Fail to update product! Please try again';
                toastBox.appendChild(toast);
            }

            setTimeout(() => {
                toast.remove();
            }, 6000);
        </script>
    </body>
</html>
