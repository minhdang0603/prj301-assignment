<%-- 
    Document   : profile
    Created on : Jan 14, 2024, 10:11:17 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <link rel="stylesheet" href="bootstrap/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/profilecss.css"/>
    </head>
    <body>
        <%@include file="../component/navbar.jsp" %>

        <main style="margin-top: 100px; min-height: 85vh">
            <div class="container mt-5">
                <div class="row">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="text-center fs-3 fw-bold text-primary">Edit Profile</p>
                            <form class="row g-3" method="post" action="profile">
                                <input type="hidden" name="cusid" value="${info.id}">
                                <div class="col-md-6">
                                    <label for="firstname" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="firstname"
                                           name="fname" required="" value="${info.firstName}">
                                </div>
                                <div class="col-md-6">
                                    <label for="lastname" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="lastname"
                                           name="lname" required="" value="${info.lastName}">
                                </div>
                                <div class="col-12">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" 
                                           name="email" required="" value="${info.email}">
                                </div>
                                <div class="col-12">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" class="form-control" id="address" 
                                           name="address" value="${info.address}">
                                </div>
                                <div class="col-md-4">
                                    <label for="province" class="form-label">City/Province</label>
                                    <input type="text" class="form-control" id="province"
                                           name="province" value="${info.province}">
                                </div>
                                <div class="col-md-4">
                                    <label for="district" class="form-label">District</label>
                                    <input type="text" class="form-control" id="district"
                                           name="district" value="${info.district}">
                                </div>
                                <div class="col-md-4">
                                    <label for="ward" class="form-label">Ward</label>
                                    <input type="text" class="form-control" id="ward"
                                           name="ward" value="${info.ward}">
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">Edit</button>
                                </div>
                            </form>
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
                toast.innerHTML = '<i class="fa-solid fa-circle-check"></i> Update successfully!';
                toastBox.appendChild(toast);
            }

            if (msg === "Fail") {
                toast.classList.add("error");
                toast.innerHTML = '<i class="fa-solid fa-circle-xmark"></i> Fail to update! Please try again';
                toastBox.appendChild(toast);
            }

            setTimeout(() => {
                toast.remove();
            }, 6000);
        </script>
    </body>
</html>
