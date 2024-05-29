<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO" %>
<%@ page import="user.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    String userPassword = request.getParameter("userPassword");
    String userName = request.getParameter("userName");
    String userPhone = request.getParameter("userPhone");
    String userEmail = request.getParameter("userEmail");
    String userAgeStr = request.getParameter("userAge");
    int userAge;
    String userAddress = request.getParameter("userAddress");

    String sessionCSRFToken = (String) session.getAttribute("sessionCSRFToken");
    String userCSRFToken = request.getParameter("csrfToken");

    if (userCSRFToken == null || !userCSRFToken.equals(sessionCSRFToken)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('잘못된 접근입니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    if (userPassword.isEmpty() || userPassword == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userName.isEmpty() || userName == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이름을 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userPhone.isEmpty() || userPhone == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('전화번호를 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if (userEmail.isEmpty() || userEmail == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이메일을 입력해주세요.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if( userAgeStr.isEmpty() || userAgeStr == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('나이를 입력해주세요..')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        userAge = Integer.parseInt(userAgeStr);
    }

    userDTO userDto = new userDTO(userId, userPassword, userName, userPhone, userEmail, userAge, userAddress);
    userDAO userDao = new userDAO();
    int result = userDao.update(userDto);

    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수정을 완료하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('프로필 업데이트에 실패하였습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>
