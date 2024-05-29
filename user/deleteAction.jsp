<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String userPassword = request.getParameter("userPassword");

    if (userPassword.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호를 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userId == null || userPassword == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    userDAO userDao = new userDAO();
    boolean result = userDao.checkPassword(userId, userPassword);

    if (result) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
	script.println("var answer = confirm('탈퇴하시겠습니까?');");
        script.println("if (answer) {");
        script.println("location.href = 'deleteOkAction.jsp'");
        script.println("} else {");
        script.println("alert('회원탈퇴를 취소하였습니다.');");
        script.println("history.back();");
        script.println("}");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 다릅니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
