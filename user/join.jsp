<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>회원 가입</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="../css/user/join.css">
    <link rel="stylesheet" href="../css/bootstrap.min.4.6.2.css">
    <link rel="stylesheet" href="../css/bootstrap.min.5.1.3.css">
    <!-- JS -->
    <script src="../js/jquery.slim.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.bundle.min.js"></script>
    <script src="../js/jquery-3.1.1.min.js"></script>
</head>
<body>
    <div class="form-signin">
        <form method="post" action="joinAction.jsp">
            <h1 class="mb-4 fw-normal">Signup</h1>
            <div class="mb-3 row g-3 align-items-center justify-content-between">
                <div class="col-auto">
                    <label for="id" class="col-form-label">* 아이디</label>
                </div>
                <div class="col-sm-9 form-input justify-content-between">
                    <input type="text" class="col-sm-8 form-control border-dark" name="userId" id="id" maxlength="15">
                    <button type="button" class="btn btn-outline-dark" id="checkId">중복확인</button>
                </div>
            </div>
            <div class="row g-3 mb-3 align-items-center justify-content-between">
                <div class="col-auto">
                    <label for="pass" class="col-form-label">* 비밀번호</label>
                </div>
                <div class="col-sm-9">
                    <input type="password" class="form-control border-dark" name="userPassword" id="pass">
                </div>
            </div>
            <div class="row g-3 mb-3 align-items-center justify-content-between">
                <div class="col-auto">
                    <label for="name" class="col-form-label">* 이름</label>
                </div>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userName" id="name">
                </div>
            </div>
            <div class="row g-3 mb-3 align-items-center justify-content-between">
                <label for="phone" class="col-auto col-form-label">* 휴대폰</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userPhone" id="phone">
                </div>
            </div>
            <div class="row g-3 mb-3 align-items-center justify-content-between">
                <label for="email" class="col-auto col-form-label">* 이메일</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userEmail" id="email">
                </div>
            </div>
            <div class="row g-3 mb-3 align-items-center justify-content-between">
                <label for="age" class="col-auto col-form-label">* 나이</label>
                <div class="col-sm-9">
                    <input type="number" class="form-control border-dark" name="userAge" id="age">
                </div>
            </div>
            <div class="row g-3 mb-3 align-items-center justify-content-between">
                <label for="address" class="col-auto col-form-label">주소</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control border-dark" name="userAddress" id="address">
                </div>
            </div>
            <p class="p">* 표시 항목은 필수 입력 항목입니다.</p>
            <div class="form-group">
                <button type="submit" class="btn btn-dark w-100 btn-lg">회원가입</button>
            </div>
            <p class="small fw-bold mt-2 pt-1 mb-0">
                이미 계정이 있으십니까?
                <a href="login.jsp" class="link-danger">로그인</a>
            </p>
        </form>
    </div>
    <script>
        $('#checkId').click(function() {
            if ($('#id').val().length !== 0) {
                $.ajax({
                    type: "POST",
                    url: "checkIdAction.jsp",
                    data: {
                        userId: $('#id').val()
                    },
                    success: function(result) {
                        if (result.trim() == 0) {
                            alert("사용 가능한 아이디입니다.");
                        } else if (result.trim() == 1) {
                            alert("이미 사용중인 아이디입니다.");
                        } else {
                            alert("오류가 발생하였습니다.");
                        }
                    }
                });
            } else {
                alert("아이디를 입력하세요.");
                $('#id').focus();
            }
        });

	$('#pass').blur(function() {
            var password = $(this).val();
            var passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;

            if (password.length !== 0) {
                if (passwordRegex.test(password)) {
                } else {
                    alert("비밀번호는 영문자/숫자/특수문자 조합으로 8자리 이상이어야 합니다.");
                }
            } else {
                alert("비밀번호를 입력하세요.");
                $('#pass').focus();
            }
        });
    </script>
</body>
</html>
