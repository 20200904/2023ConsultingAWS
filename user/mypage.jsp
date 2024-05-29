<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ include file="../layout/header.jsp" %>

<html>
<head>
    <title>My page</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/user/mypage.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");

        if (userId == null) {
            response.sendRedirect("./login.jsp");
            return;
        }

        userDAO userDao = new userDAO();
        userDTO userDto = userDao.userInfo(userId);
    %>
    <div class="form-mypage">
        <i class="bi bi-person-circle" style="font-size: 196px"></i>
        <h2 class="mt-3 mb-3">
            <!-- userId 불러오기 -->
            <%=userDto.getuserId()%>
        </h2>
        <div class="form-list">
            <a href="../board/write.jsp" class="btn mt-3 mb-3">글 쓰기</a>
            <a href="../board/myblog.jsp" class="btn mt-3 mb-3">글 관리</a>
            <a href="checkPassword.jsp" class="btn mt-3 mb-3">회원 정보</a>
        </div>
    </div>
</body>
</html>
