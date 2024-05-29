<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ include file="../layout/header.jsp" %>
<%@ page import="java.util.UUID" %>

<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" type="text/css" href="../css/user/profile.css">
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userCSRFToken = UUID.randomUUID().toString();
        session.setAttribute("sessionCSRFToken", userCSRFToken);

        userDAO userDao = new userDAO();
        userDTO userDto = userDao.userInfo(userId);

	String showPassword = "";
	if (userDto.getuserPassword() != null) {
	    showPassword = "*".repeat(userDto.getuserPassword().length());
	}
    %>
    <div class="form-profile">
        <h2 class="mb-5">회원 정보</h2>
        <form method="post">
            <input type="hidden" name="csrfToken" value="<%=userCSRFToken%>">
            <div class="mb-3 row justify-content-between">
                <label for="staticId" class="col-auto col-form-label">* 아이디</label>
                <div class="col-sm-9 form-span">
                    <span>
                        <%=userDto.getuserId()%>
                    </span>
                </div>
            </div>
            <div class="mb-3 row justify-content-between">
                <label for="inputPassword" class="col-auto col-form-label">* 비밀번호</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control border-dark" name="userPassword" value="<%= showPassword %>">
                </div>
            </div>
            <div class="mb-3 row justify-content-between">
                <label for="inputName" class="col-auto col-form-label">* 이름</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userName" value="<%=userDto.getuserName()%>">
                </div>
            </div>
            <div class="mb-3 row justify-content-between">
                <label for="inputPhone" class="col-auto col-form-label">* 휴대폰</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userPhone" value="<%=userDto.getuserPhone()%>">
                </div>
            </div>
            <div class="mb-3 row justify-content-between">
                <label for="inputEmail" class="col-auto col-form-label">* 이메일</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userEmail" value="<%=userDto.getuserEmail()%>">
                </div>
            </div>
            <div class="mb-3 row justify-content-between">
                <label for="inputAge" class="col-auto col-form-label">* 나이</label>
                <div class="col-sm-9">
                    <input type="number" min="1" class="form-control border-dark" name="userAge" value="<%=userDto.getuserAge()%>">
                </div>
            </div>
            <div class="mb-3 row justify-content-between">
                <label for="inputAddress" class="col-auto col-form-label">주소</label>
                <div class="col-sm-9">
                    <textarea type="text" class="form-control border-dark" name="userAddress" rows="2"><%=userDto.getuserAddress()%></textarea>
                </div>
            </div>
            <div class="button-container">
                <button type="submit" class="btn btn-outline-dark btn-sm" formaction="updateAction.jsp">수정 완료</button>
                <button type="submit" class="btn btn-outline-dark btn-sm" formaction="deleteAction.jsp">회원 탈퇴</button>
            </div>
        </form>
    </div>
</body>
</html>
