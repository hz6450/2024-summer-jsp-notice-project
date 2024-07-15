<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>jsp 게시판 웹 사이트</title>
<style type="text/css">
</style>
</head>

<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");

	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="BBS.jsp">게시판</a></li>
			</ul>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" id="bbs-table">
				<thead style="box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.1)">
					<tr>
						<th id="bbs-th">No.</th>
						<th id="bbs-th-bor">제목</th>
						<th id="bbs-th-bor">작성자</th>
						<th id="bbs-th-bor">작성일</th>
						<th id="bbs-th-bor">조회수</th>
					</tr>
				</thead>
				<tbody id="bbs-tr">
					<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td id=""><%=list.get(i).getBbsId()%></td>
						<td id="bbs-td-bor"><a
							href="view.jsp?bbsID=<%=list.get(i).getBbsId()%>"> <%=list.get(i).getBbsTitle()%></a></td>
						<td id="bbs-td-bor"><%=list.get(i).getUserID()%></td>
						<td id="bbs-td-bor"><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
		+ list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
						<td id="bbs-td-bor"><%=list.get(i).getBbsView()%></td>
				</tbody>
				<%
				}
				%>

			</table>
			<a href="BBS.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a> <a
				href="BBS.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-left" style="align: center">다음</a>


			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>

	</div>



	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>

</html>