<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="../layout/header.jsp" %>

<html>
<head>
    <title>새 게시글 작성</title>
    <link rel="stylesheet" type="text/css" href="../css/board/write.css">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");

        if (userId == null) {
            response.sendRedirect("../user/login.jsp");
            return;
        }

        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
    %>
    <div class="forms">
        <form method="POST" action="writeAction.jsp" enctype="multipart/form-data">
            <input type="hidden" name="csrfToken" value="<%=csrfToken%>">
            <div class="mb-3">
                <input class="form-control border-dark" type="text" placeholder="제목을 입력하세요" max-length="50" name="boardTitle">
            </div>
            <div id="toolbar" class="border-dark">
                <select class="ql-size">
                    <option value="small"></option>
                    <option selected></option>
                    <option value="large"></option>
                    <option value="huge"></option>
                </select>
                <button class="ql-bold"></button>
                <button class="ql-italic"></button>
                <button class="ql-underline"></button>
                <button class="ql-strike"></button>
                <select class="ql-color"></select>
                <select class="ql-background"></select>
                <button class="ql-list" value="ordered"></button>
                <button class="ql-list" value="bullet"></button>
                <select class="ql-align"></select>
            </div>
            <div id="editor" class="editor border-dark"></div>
            <input type="hidden" name="boardContent" id="content">
            <div class="file-button justify-content-between" style="display: flex;">
		<div>
                    <div class="custom-file mt-3">
		        <label class="btn btn-outline-dark" for="formFile" id="formFileLabel">파일 선택</label>
                        <input class="form-control border-dark" type="file" id="formFile" name="boardFile" onchange="handleFileChange()" style="display: none;">
		        <div id="file-info" style="display: none;">
			    <div class="d-flex">
			       <input type="text" readonly class="mr-2 form-control-plaintext" id="selectedFileName">
                               <button type="button" class="btn btn-outline-dark btn-sm" onclick="cancelFile()" style="font-size: large">×</button>
			    </div>
			</div>
                    </div>
		</div>
                <button type="submit" class="btn btn-dark mt-3">작성</button>
            </div>
        </form>
    </div>
    <script>
        var quill = new Quill('#editor', {
            theme: 'snow',
            modules: {
                toolbar: '#toolbar'
            },
            placeholder: '내용을 작성해주세요'
        });

        document.querySelector('form').addEventListener('submit', function () {
            document.getElementById('content').value = quill.root.innerHTML;
        });

        function handleFileChange() {
            var fileInput = document.getElementById("formFile");
            var fileInfo = document.getElementById("file-info");
            var selectedFileName = document.getElementById("selectedFileName");

            if (fileInput.files.length > 0) {
                var fileName = fileInput.files[0].name;
                selectedFileName.value = fileName;
                fileInfo.style.display = "block";
                document.getElementById("formFileLabel").style.display = "none"; // Hide the "업로드" label
            } else {
                fileInfo.style.display = "none";
                document.getElementById("formFileLabel").style.display = "block"; // Show the "업로드" label
            }
        }

        function cancelFile() {
            var fileInput = document.getElementById("formFile");
            var fileInfo = document.getElementById("file-info");

            fileInput.value = ""; // Reset file input
            fileInfo.style.display = "none";
            document.getElementById("formFileLabel").style.display = "block"; // Show the "업로드" label
        }
    </script>
</body>
</html>
