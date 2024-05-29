<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String directory = "/var/lib/tomcat9/webapps/files";
    int maxSize = 1024 * 1024 * 100;
    String encoding = "UTF-8";

    MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());

    int boardId = Integer.parseInt(multipartRequest.getParameter("id"));

    boardDAO boardDao = new boardDAO();
    boardDTO boardDto = boardDao.getFile(boardId);

    String fileName = boardDto.getfileName();
    String fileRealName = boardDto.getfileRealName();
    String updateFileName = multipartRequest.getOriginalFileName("boardFile");
    String updateFileRealName = multipartRequest.getFilesystemName("boardFile");
    String fileStatus = multipartRequest.getParameter("fileStatus");
/*
    if (userId != null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('fileName: "+fileName+", fileRealName: "+fileRealName+", updateFileName: "+updateFileName+", updatefilename: " +updateFileName+", fileStatus: " +fileStatus+"');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
    }
*/
    String boardTitle = multipartRequest.getParameter("boardTitle");
    String boardContent = multipartRequest.getParameter("boardContent");
    String strReferer = request.getHeader("referer"); //이전 URL 가져오기

    int result;

    if (updateFileName != null) {
        if (fileName == null) {
	    // case 1-2) db update
	    result = boardDao.update(boardId, userId, boardTitle, boardContent, updateFileName, updateFileRealName);
	} else {
	    // case 2-3) 기존 파일 삭제 후 db update
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

	    result = boardDao.update(boardId, userId, boardTitle, boardContent, updateFileName, updateFileRealName);
	}
    } else {
        // case 2-2)
	if (fileStatus.equals("change")) {
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

            result = boardDao.update(boardId, userId, boardTitle, boardContent, updateFileName, updateFileRealName);
	} else {
        // case 1-1), 2-1)
            result = boardDao.update(boardId, userId, boardTitle, boardContent, fileName, fileRealName);
	}
    }

    if(strReferer == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정상적인 경로를 통해 다시 접근해 주세요.');");
        script.println("location.href='../board/main.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    if (boardTitle.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('제목을 작성해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (boardContent.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('내용을 작성해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userId == null || boardTitle == null || boardContent == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글을 수정하였습니다.');");
        script.println("location.href='view.jsp?id=" + boardId + "'");
        script.println("</script>");
        script.close();
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수정에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
