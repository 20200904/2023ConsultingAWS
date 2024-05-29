<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("userId");

    userDAO userDao = new userDAO();
    int result = userDao.checkId(userId);

    if (result == 1) {
	out.print(1);
    } else if (result == 0) {
	out.print(0);
    } else {
	out.print(-1);
    } 
%>
