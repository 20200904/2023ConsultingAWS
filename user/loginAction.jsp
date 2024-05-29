<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = request.getParameter("userId");
    String userPassword = request.getParameter("userPassword");
    String[] restrictedCharacters = { "&", "|", ";", "`" };

    for (String restrictedChar : restrictedCharacters) {
        if (userId.contains(restrictedChar) || userPassword.contains(restrictedChar)) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력 값에 허용되지 않는 문자가 포함되어 있습니다.');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            return;
        }
    }

    if (userId == null || userPassword == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if (userId.isEmpty() || userPassword.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }

    userDAO userDao = new userDAO();
    int result = userDao.login(userId, userPassword);

    if (result == 1) {
        session.setAttribute("userId", userId);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href='../board/main.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else if (result == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>
