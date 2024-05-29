<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    int boardId = Integer.parseInt(request.getParameter("id"));

    boardDAO boardDao = new boardDAO();
    boardDTO boardDto = boardDao.detailView(boardId);

    String directory = "/var/lib/tomcat9/webapps/files";
    String fileName = boardDto.getfileName();
    String fileRealName = boardDto.getfileRealName();

    File file = new File(directory, fileRealName);

    if (!fileRealName.equals(file.getName()) || !directory.equals(file.getParent())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    FileInputStream fileInputStream = new FileInputStream(file);
    fileName = new String(fileName.getBytes("utf-8"), "8859_1");

    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

    OutputStream outputStream = response.getOutputStream();

    byte b[] = new byte[1024];
    int data = 0;

    while ((data = (fileInputStream.read(b, 0, b.length))) != -1) {
        outputStream.write(b, 0, data);
    }

    outputStream.flush();
    outputStream.close();
    fileInputStream.close();
%>
