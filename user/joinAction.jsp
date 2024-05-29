<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("userId");
    String userPassword = request.getParameter("userPassword");
    String userName = request.getParameter("userName");
    String userPhone = request.getParameter("userPhone");
    String userEmail = request.getParameter("userEmail");
    String userAgeStr = request.getParameter("userAge");
    int userAge;
    String userAddress = request.getParameter("userAddress");

    if (userId.isEmpty() || userId == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userPassword.isEmpty() || userPassword == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userName.isEmpty() || userName == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이름을 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userPhone.isEmpty() || userPhone == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('전화번호를 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userEmail.isEmpty() || userEmail == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이메일을 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userAgeStr == null || userAgeStr.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('나이를 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        userAge = Integer.parseInt(userAgeStr);
    }

    userDTO userDto = new userDTO(userId, userPassword, userName, userPhone, userEmail, userAge, userAddress);
    userDAO userDao = new userDAO();
    int result = userDao.join(userDto);

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 성공하였습니다.');");
        script.println("location.href='../user/login.jsp';");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
