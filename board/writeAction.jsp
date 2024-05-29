<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 허용할 파일 확장자, MIME 타입 지정
    String[] validExtensions = {"jpg", "png", "gif", "pdf", "docx", "hwp", "xlsx", "ppt", "txt"};
    String[] validTypes = {"image/jpeg", "image/png", "image/gif", "application/pdf", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/haansofthwp", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.openxmlformats-officedocument.presentationml.presentation", "text/plain"};
    
    String directory = "/var/lib/tomcat9/webapps/files/";
    int maxSize = 1024 * 1024 * 100;
    String encoding = "UTF-8";

    MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding, new DefaultFileRenamePolicy());

    String userId = (String) session.getAttribute("userId");
    String boardTitle = multipartRequest.getParameter("boardTitle");
    String boardContent = multipartRequest.getParameter("boardContent");
    String fileName = multipartRequest.getOriginalFileName("boardFile");
    String fileRealName = multipartRequest.getFilesystemName("boardFile");
    String fileExtension = (fileName != null) ? fileName.substring(fileName.indexOf(".") + 1) : null;
    String fileType = multipartRequest.getContentType("boardFile");

    String userCSRFToken = multipartRequest.getParameter("csrfToken");
    String sessionCSRFToken = (String) session.getAttribute("csrfToken");

    // 파일 확장자, MIME 타입 확인
    if (fileExtension != null && fileType != null) {
        if (!Arrays.asList(validExtensions).contains(fileExtension) || !Arrays.asList(validTypes).contains(fileType)) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('허용되지 않는 파일 형식입니다." + fileExtension + ", " + fileType + "');");
            script.println("history.back();");
            script.println("</script>");
            script.close();
            File file = new File(directory, fileRealName);
            file.delete();
            return;
        }
    }

    if (userCSRFToken == null || !userCSRFToken.equals(sessionCSRFToken)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('잘못된 접근입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (boardTitle == null || boardContent == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back();");
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

    boardDAO boardDao = new boardDAO();
    int result = boardDao.write(userId, boardTitle, boardContent, fileName, fileRealName);

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글을 성공적으로 작성하였습니다.');");
        script.println("location.href = 'myblog.jsp'");
        script.println("</script>");
        script.close();
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글 작성에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
