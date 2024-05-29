<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String boardId = request.getParameter("id");

    if (userId == null || boardId == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("var answer = confirm('삭제하시겠습니까?');");
    script.println("if (answer) {");
    script.println("location.href = 'deleteOkAction.jsp?id=" + boardId +"'");
    script.println("} else {");
    script.println("alert('삭제를 취소하였습니다.');");
    script.println("history.back();");
    script.println("}");
    script.println("</script>");
    script.close();
%>    
