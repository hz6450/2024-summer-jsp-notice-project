<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="../css/custom-font.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>jsp 게시판 웹 사이트</title>
</head>

<body>
	<c:set var="bbsID" value="0" />
	<c:if test="${not empty param.bbsID}">
		<c:set var="bbsID" value="${param.bbsID}" />
	</c:if>
	<c:if test="${bbsID == 0} ">
		<script>
			alert("유효하지 않은 값입니다.");
			location.href("bbs.jsp");
		</script>
	</c:if>


	<%
	int bbsID = Integer.parseInt(request.getParameter("bbsID"));
	Bbs bbs = new BbsDAO().getBbs(bbsID);
		
	pageContext.setAttribute("title", bbs.getBbsTitle());
	pageContext.setAttribute("category", bbs.getBbsCategory());
	pageContext.setAttribute("content", bbs.getBbsContent());
	pageContext.setAttribute("time", 	bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
			+ bbs.getBbsDate().substring(14, 16) + "분");
	pageContext.setAttribute("view", bbs.getBbsView() + 1);
	
	%>
	        <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="main.do">JSP 게시판 웹 사이트</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-controls="bs-example-navbar-collapse-1" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link " href="main.do">메인</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link active" href="./BBS/list.do">게시판</a>
                </li>
            </ul>
        </div>
    </nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판
							글보기</th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><c:out value="${title}" /></td>
					</tr>

					<tr>
						<td style="width: 20%;">글 종류</td>
						<td colspan="2"><c:out value="${category}" /></td>
					</tr>
					<tr>
						<td>작성 일자</td>
						<td colspan="2"><c:out value="${time}" /></td>
					</tr>
					<tr>
					<td style="text-align: center; vertical-align: middle;">내용</td>
					<td colspan="2" style="height: 200px; text-align: left;"><c:out value="${content}" /></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td colspan="2"><c:out value="${view}" /></td>
					</tr>

				</tbody>
			</table>
			<a href="javascript:history.back();" class="btn btn-primary">목록</a> <a
				href="update.jsp?bbsID=${bbsID}" class="btn btn-primary">수정</a> <a
				onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="../controller/deleteAction.jsp?bbsID=${bbsID}"
				class="btn btn-primary">삭제</a>

		</div>
	</div>





	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>

</html>