<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<nav class="navbar fixed-top navbar-expand-lg navbar-light bg-white">
    <!-- Container wrapper -->
    <div class="container">    
        <!-- Toggle button -->
        <button
            class="navbar-toggler"
            type="button"
            data-mdb-toggle="collapse"
            data-mdb-target="#navbarSupportedContent1"
            aria-controls="navbarSupportedContent1"
            aria-expanded="false"
            aria-label="Toggle navigation"
            >
            <i class="fas fa-bars"></i>
        </button>

        <!-- Collapsible wrapper -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent1">      
            <!-- Navbar brand -->
            <a class="navbar-brand mt-2 ms-3 mt-sm-0" href="admin-page">
                <img src="images/store-icon.png"
                     height="20"/>
            </a>
        </div>
        <!-- Collapsible wrapper -->

        <!-- Right elements -->
        <div class="d-flex align-items-center">
            <div class="dropdown">
                <button class="btn btn-white dropdown-toggle" id="dropdownMenuButton1"
                        type="button" 
                        data-bs-toggle="dropdown"
                        aria-expanded="false">
                    <i class="fa-regular fa-user me-2"></i>
                    Admin
                </button>
                <ul class="dropdown-menu dropdown-menu-end " aria-labelledby="dropdownMenuButton1">
                    <li><a class="dropdown-item" href="product-controller?action=add">Add Product</a></li>
                    <li><a class="dropdown-item" href="admin-page?action=logout">Logout</a></li>
                </ul>
            </div>
        </div>
        <!-- Right elements -->

    </div>
    <!-- Container wrapper -->
</nav>


