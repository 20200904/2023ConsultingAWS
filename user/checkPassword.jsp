<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ include file="../layout/header.jsp" %>

<html>
<head>
    <title>회원 탈퇴</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/user/checkPassword.css">
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        userDAO userDao = new userDAO();
        userDTO userDto = userDao.userInfo(userId);
    %>
    <div class="card form-withdrawal border-dark">
        <h5 class="mt-5">비밀번호를 입력하세요</h5>
        <form method="post" action="profile.jsp" class="mb-5">
            <div class="mt-3 mb-3 align-items-center form-password">
                <input type="password" name="userPassword" class="form-control border-dark">
            </div>
            <button type="submit" class="btn btn-outline-dark btn-sm">확인</button>
        </form>
    </div>
</body>
</html>
