<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>jsp 게시판 웹 사이트</title>
</head>

<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>"); // script태그 실행문구
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}

	Bbs bbs = new BbsDAO().getBbs(bbsID);

	BbsDAO bbsDAO = new BbsDAO();
	int result = bbsDAO.delete(bbsID);
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>"); // script태그 실행문구
		script.println("alert('글 삭제에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>"); // script태그 실행문구
		script.println("location.href='../view/BBS.jsp'");
		script.println("</script>");
	}
	%>
</body>

</html>