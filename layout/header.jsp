<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- CSS -->
    <link rel="stylesheet" href="../css/layout/header.css">
    <link rel="stylesheet" href="../css/quill.snow.1.3.6.css">
    <link rel="stylesheet" href="../css/bootstrap.min.4.6.2.css">
    <!-- JS -->
    <script src="../js/jquery.slim.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script src="../js/quill.1.3.6.js"></script>
</head>
<body>
    <% 
        String userId = (String) session.getAttribute("userId");
    %>
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-between">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" style="font-size: 24px; font-weight: bold;" href="../board/main.jsp">Blog</a>
            </li>
        </ul>
        <ul class="navbar-nav">        
            <% if (userId == null) { %>
            <li class="nav-item">
                <a class="nav-link" href="../user/login.jsp">Log in</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../user/join.jsp">Sign up</a>
            </li>
            <% } else { %>
            <li class="nav-item">
                <a class="nav-link" href="../user/mypage.jsp">My page</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../user/logoutAction.jsp">Logout</a>
            </li>
            <% } %>
        </ul>
    </nav>
</body>
</html>
