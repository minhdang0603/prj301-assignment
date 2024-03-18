<%-- 
    Document   : changepassword
    Created on : Jan 25, 2024, 7:59:39 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>

        <style>
            .paint-card {
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>
        <%@include file="../component/navbar.jsp"%>

        <main style="margin-top: 100px; min-height: 85vh">
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card paint-card">
                            <div class="card-body">
                                <p class="text-center fs-3 fw-bold text-primary">Change Password</p>
                                <c:if test="${sessionScope.error != null}">
                                    <p class="fs-7 text-danger">${sessionScope.error}</p>
                                    <c:remove var="error" scope="session"/>
                                </c:if>
                                <c:if test="${sessionScope.msg != null}">
                                    <p class="fs-7 text-success">${sessionScope.msg}</p>
                                    <c:remove var="msg" scope="session"/>
                                </c:if>

                                <form action="change-password" method="post">

                                    <input type="hidden" name="userid" value="${cusAcc.id}"/>

                                    <div class="mb-3" >
                                        <label class="form-label">Enter Old Password</label>
                                        <input type="password" name="oldpass" class="form-control" required="">
                                    </div>

                                    <div class="mb-3" >
                                        <label class="form-label">Enter New Password</label>
                                        <div class="input-box">
                                            <input type="password" name="newpass" class="form-control" required="">
                                        </div>
                                    </div>

                                    <div class="mb-3" >
                                        <label class="form-label">Confirm New Password</label>
                                        <div class="input-box">
                                            <input type="password" name="confirm" class="form-control" required="">
                                        </div>
                                    </div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-outline-primary mt-3">Change Password</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
