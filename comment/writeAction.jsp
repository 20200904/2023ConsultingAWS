<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="comment.commentDTO" %>
<%@ page import="comment.commentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String boardIdStr = request.getParameter("id");
    int boardId;
    String commentContent = request.getParameter("commentContent");

    if (commentContent.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('내용을 입력해주세요.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
    if (userId == null || boardIdStr == null || commentContent == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    } else {
        boardId = Integer.parseInt(boardIdStr);
    }

    commentDAO commentDao = new commentDAO();
    int result = commentDao.write(boardId, userId, commentContent);

    if (result == 1) {
        PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='../board/view.jsp?id=" + boardId + "'");
	script.println("</script>");
	script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('댓글 쓰기에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
        script.close();
    }
%>
