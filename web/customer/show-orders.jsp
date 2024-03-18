<%-- 
    Document   : show-orders
    Created on : Mar 9, 2024, 4:15:30 PM
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
        <%@include file="../component/navbar.jsp"%>
        <main style="margin-top: 100px; min-height: 84vh">
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
                                    <th>Confirm</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td>${o.orderID}</td>
                                        <td>${cusAcc.firstName} ${cusAcc.lastName}</td>
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
                                                <a href="orders?service=cancel&id=${o.orderID}" class="btn btn-sm btn-danger text-white">Cancel</a>
                                            </c:if>
                                            <a href="orders?service=detail&id=${o.orderID}" class="btn btn-sm btn-secondary text-white">Detail</a>
                                        </td>
                                        <c:if test="${o.status == 'On delivery'}">
                                            <td><a href="orders?service=received&id=${o.orderID}" class="btn btn-sm btn-success text-white">Received</a></td>
                                        </c:if>
                                        <c:if test="${o.status != 'On delivery'}">
                                            <td><a href="" class="btn btn-sm disabled btn-success text-white">Received</a></td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
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

            if (msg === "Success") {
                toast.innerHTML = '<i class="fa-solid fa-circle-check"></i> Cancel successfully!';
                toastBox.appendChild(toast);
            }

            if (msg === "Fail") {
                toast.classList.add("error");
                toast.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Fail to cancel! Please try again';
                toastBox.appendChild(toast);
            }

            setTimeout(() => {
                toast.remove();
            }, 6000);
        </script>

    </body>
</html>
