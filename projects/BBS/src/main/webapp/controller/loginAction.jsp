<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>jsp 게시판 웹 사이트</title>
    </head>

    <body>
		<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
			UserDAO userDAO = new UserDAO();
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>"); // script태그 실행문구
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}

		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		// 로그인 성공시 출력
		if(result == 1) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>"); // script태그 실행문구
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>"); // script태그 실행문구
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>"); // script태그 실행문구
			script.println("alert('존재하지 않는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>"); // script태그 실행문구
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		%>
    </body>

    </html>