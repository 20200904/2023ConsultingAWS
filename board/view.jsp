<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="comment.commentDTO" %>
<%@ page import="comment.commentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ include file="../layout/header.jsp" %>

<html>
<head>
    <title>게시글</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://cdn.quilljs.com/1.3.6/quill.snow.css">
    <link rel="stylesheet" type="text/css" href="../css/board/view.css">
    <script src="../js/purify.min.js"></script>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        int boardId = Integer.parseInt(request.getParameter("id"));

        if (userId == null) {
            response.sendRedirect("../user/login.jsp");
            return;
        }

        boardDAO boardDao = new boardDAO();
        boardDTO boardDto = boardDao.detailView(boardId);

        commentDAO commentDao = new commentDAO();
        List<commentDTO> commentList = commentDao.commentList(boardId);
        int commentCount = commentDao.commentCount(boardId);
    %>
    <div class="group-content">
        <!--게시글 내용 출력-->
        <div class="card border-0 board-content">
            <div class="card-header bg-transparent border-dark">
                <h3><%=boardDto.getboardTitle()%></h3>
                <h5 class="mb-0"><%=boardDto.getuserId()%></h5>
                <div class="d-flex w-100 justify-content-between date-button mt-1">
                    <small><%=boardDto.getboardDate()%></small>
                    <%
                        if (userId.equals(boardDto.getuserId())) {
                    %>
                    <div class="buttons">
                        <button type="submit" class="btn btn-sm" onclick="location.href='edit.jsp?id=<%=boardDto.getboardId()%>'">수정</button>
                        <button type="submit" class="btn btn-sm" onclick="location.href='deleteAction.jsp?id=<%=boardDto.getboardId()%>'">삭제</button>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="card-body bg-transparent border-dark">
                <%= boardDto.getboardContent() %>
            </div>
            <!-- 업로드된 파일 -->
            <%
                if (boardDto.getfileName() != null) {
            %>
            <div class="card-footer bg-transparent border-dark">
                <a href="./downloadAction.jsp?id=<%= boardDto.getboardId() %>" class="link-dark"><%= boardDto.getfileName() %></a>
            </div>
            <%
                }
            %>
        </div>
        <div class="mt-3 mb-3">
            <div class="card-header bg-transparent border-dark">
                댓글 (<%=commentCount%>)
            </div>
            <%
                if (commentCount > 0) {
            %>
            <!--댓글 리스트 출력-->
            <div class="list-group list-group-flush">
                <%
                    for (commentDTO commentDto : commentList) {
                %>
                <div class="list-group-item border-dark">
                    <div class="d-flex w-100 justify-content-between user-button">
                        <h5 class="mb-1"><%=commentDto.getuserId()%></h5>
                        <%
                            if (userId.equals(commentDto.getuserId())) {
                        %>
                        <button class="btn btn-sm" onclick="location.href='../comment/deleteAction.jsp?id=<%=commentDto.getcommentId()%>'">삭제</button>
                        <%
                            }
                        %>
                    </div>
                    <div>
                        <small class="mb-3"><%=commentDto.getcommentDate()%></small>
                    </div>
                    <p><%= Encode.forHtmlContent(commentDto.getcommentContent()) %></p>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
        <!--댓글 등록-->
        <div>
            <form method="post" action="../comment/writeAction.jsp?id=<%=boardDto.getboardId()%>">
                <textarea class="form-control border-dark" rows="3" name="commentContent"></textarea>
                <button type="submit" class="btn btn-dark mt-2 buttons">등록</button>
            </form>
        </div>
    </div>
</body>
</html>
