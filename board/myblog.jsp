<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ include file="../layout/header.jsp" %>

<html>
<head>
    <title>내 게시글 조회</title>
    <link rel="stylesheet" type="text/css" href="../css/board/myblog.css">
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");

        if (userId == null) {
            response.sendRedirect("../user/login.jsp");
            return;
        }

        boardDAO boardDao = new boardDAO();
        List<boardDTO> boardList = boardDao.myView(userId);

    %>
    <div class="groups">
        <div class="list-group list-group-flush">
        <%
            for (boardDTO boardDto : boardList) {
	        String boardContent = Jsoup.parse(boardDto.getboardContent()).text();
        %>
            <a href="view.jsp?id=<%=boardDto.getboardId()%>" class="border-dark list-group-item list-group-item-action" aria-current="true">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1"><%=boardDto.getboardTitle()%></h5>
                    <small><%=boardDto.getboardDate()%></small>
                </div>
                <h6 class="mb-1"><%=boardDto.getuserId()%></h6>
		<%= Encode.forHtmlContent(boardContent.length() > 100 ? boardContent.substring(0, 100) + "..." : boardContent) %>
            </a>
        <%
            }
        %>
        </div>
        <div class="page mt-3">
            <ul class="pagination mb-0">
                <li class="page-item">
                    <a class="page-link border-0 text-dark" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li class="page-item"><a class="page-link border-0 text-dark" href="#">1</a></li>
                <li class="page-item"><a class="page-link border-0 text-dark" href="#">2</a></li>
                <li class="page-item"><a class="page-link border-0 text-dark" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link border-0 text-dark" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>
