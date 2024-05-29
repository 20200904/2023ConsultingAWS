<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="comment.commentDTO" %>
<%@ page import="comment.commentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    int commentId = Integer.parseInt(request.getParameter("id"));

    commentDAO commentDao = new commentDAO();
    int result = commentDao.delete(userId, commentId);

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('댓글을 삭제하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('댓글 삭제에 실패하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
