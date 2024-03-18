<%-- 
    Document   : login
    Created on : Feb 23, 2024, 9:14:12 PM
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

        <main style="margin-top: 100px; min-height: 85vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card paint-card">
                            <div class="card-body">
                                <p class="text-center fs-3 fw-bold text-primary">Login</p>
                                <c:if test="${sessionScope.error != null}">
                                    <p class="fs-7 text-danger">${sessionScope.error}</p>
                                    <c:remove var="error" scope="session"/>
                                </c:if>

                                <form action="login" method="post">
                                    <div class="mb-3" >
                                        <label class="form-label">Email address</label>
                                        <input type="email" name="email" class="form-control" required="">
                                    </div>

                                    <div class="mb-3" >
                                        <label class="form-label">Password</label>
                                        <div class="input-box">
                                            <input type="password" name="pass" class="form-control" required="">
                                        </div>
                                    </div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-outline-primary mt-3">Login</button>
                                    </div>
                                </form>
                                <br/>
                                Don't have any account? <a href="signup" class="text-decoration-none">create one</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script src="bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>
