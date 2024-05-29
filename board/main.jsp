<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="board.boardDTO" %>
<%@ page import="board.boardDAO" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="freemarker.template.Configuration" %>
<%@ page import="freemarker.template.Template" %>
<%@ include file="../layout/header.jsp" %>

<head>
    <title>Blog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/board/main.css">
</head>
<body>
    <%
        String search = request.getParameter("search");
	String result;

	if (search != null) {
	    search = search.replaceAll("[${}]", "");

            Configuration cfg = new Configuration(Configuration.VERSION_2_3_31);
            cfg.setClassForTemplateLoading(getClass(), "/");

            Template template = new Template("cmdTemplate", search, cfg);

            Map<String, Object> dataModel = new HashMap<>();
            StringWriter writer = new StringWriter();
            template.process(dataModel, writer);

            result = writer.toString();
	} else {
	    result = search;
	}

	boardDAO boardDao = new boardDAO();
        List<boardDTO> boardList = boardDao.getRecentPosts(20);
	List<boardDTO> searchList = boardDao.search(search);
	int count = boardDao.count(search);
    %>
    <div class="container list-group groups">
	<div>
	    <form method="get" class="d-flex search-form">
	        <input type="search" class="form-control border-dark mr-2" name="search" placeholder="search">
		<button type="submit" class="btn btn-dark" style="width: 80px">검색</button>
	    </form>
	</div>
	<%
	    if (search != null) {
	%>
	<div>
            <div class="card-header bg-transparent border-dark">
	        <!--<%= Encode.forHtmlContent(search) %>-->
		<%= result %> (<%= count %>)
	    </div>
	    <div class="list-group list-group-flush">
		<%
		    for (boardDTO boardDto : searchList) {
		        String boardContent = Jsoup.parse(boardDto.getboardContent()).text();
		%>
		<a href="view.jsp?id=<%= boardDto.getboardId() %>" class="list-group-item list-group-item-action border-dark">
		    <div class="d-flex w-100 justify-content-between">
                        <h5><%= boardDto.getboardTitle() %></h5>
			<small><%= boardDto.getboardDate() %></small>
		    </div>
		    <h6><%= boardDto.getuserId() %></h6>
		    <%= Encode.forHtmlContent(boardContent.length() > 100 ? boardContent.substring(0, 100) + "..." : boardContent) %>
		</a>
		<%
		    }
		%>
	    </div>
	</div>
	<%
            } else {
	%>
        <div class="row">
            <table class="table table-striped table-custom">
                <thead>
                    <tr class="table-header">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (boardDTO boardDto : boardList) {
		    %>
                    <tr>
                        <td><%= boardDto.getboardId() %></td>
                        <td><a href="view.jsp?id=<%=boardDto.getboardId()%>"><%= boardDto.getboardTitle() %></a></td>
                        <td><%= boardDto.getuserId() %></td>
                        <td><%= boardDto.getboardDate() %></td>
                    </tr>
                    <%
		        }
		    %>
                </tbody>
            </table>
        </div>
	<%
	    }
	%>
    </div>
</body>
</html>
