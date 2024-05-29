<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="../css/user/login.css">
    <link rel="stylesheet" href="../css/bootstrap.min.4.6.2.css">
    <link rel="stylesheet" href="../css/bootstrap.min.5.1.3.css">
    <!-- JS -->
    <script src="../js/jquery.slim.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.bundle.min.js"></script>
</head>
<body class="text-center">
    <div class="form-login">
        <form method="post" action="loginAction.jsp">
            <h1 class="mb-3 fw-normal">Login</h1>
            <div class="form-floating">
                <input type="text" class="form-control border-dark" placeholder="ID" name="userId">
                <label for="floatingInput">ID</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control border-dark" placeholder="password" name="userPassword">
                <label for="floatingInput">password</label>
            </div>
            <button type="submit" class="btn btn-dark w-100 btn-lg">로그인</button>
        </form>           
        <p class="small fw-bold mt-2 pt-1 mb-0">
            아직 계정이 없으십니까?
            <a href="join.jsp" class="link-danger">회원가입</a>
        </p>
    </div>
</body>
</html>
