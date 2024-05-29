<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    int boardId = Integer.parseInt(request.getParameter("id"));

    boardDAO boardDao = new boardDAO();
    boardDTO boardDto = boardDao.getFile(boardId);

    String directory = "/var/lib/tomcat9/webapps/files";
    String fileRealName = boardDto.getfileRealName();
  
    if (fileRealName != null) {
        File file = new File(directory, fileRealName);

        if (file.exists()) {
            file.delete();
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('오류가 발생하였습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
    }

    int result = boardDao.delete(userId, boardId);

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('삭제가 완료되었습니다.')");
        script.println("location.href = '../board/myblog.jsp'");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('삭제에 실패하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
