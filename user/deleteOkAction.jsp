<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");

    userDAO userDao = new userDAO();
    int result = userDao.delete(userId);

    if (result == 1) {
        session.invalidate();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('탈퇴처리가 완료되었습니다.')");
        script.println("location.href = '../board/main.jsp'");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
	script.println("alert('탈퇴처리에 실패하였습니다.')");
	script.println("history.back()");
	script.println("</script>");
    }
%>
