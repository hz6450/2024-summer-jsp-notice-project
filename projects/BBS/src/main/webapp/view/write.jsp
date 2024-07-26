<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>jsp 게시판 웹 사이트</title>
</head>
<body>
	<c:set var="userID" value="null"></c:set>
	<c:if test="${not empty sessionScope.userID}">
		<c:set var="userID" value="${sessionScope.userID}" />
	</c:if>

	<script>
	function sendIt(event) {
	    console.log("쓰기 호출");
	    event.preventDefault();  // 기본 폼 제출 동작 방지

	    var f = document.myForm;

	    var str = f.bbsTitle.value.trim();
	    if (!str) {
	        alert("\n제목을 입력하세요.");
	        f.bbsTitle.focus();
	        return;
	    }
	    f.bbsTitle.value = str;

	    str = f.bbsContent.value.trim();
	    if (!str) {
	        alert("\n내용을 입력하세요.");
	        f.bbsContent.focus();
	        return;
	    }
	    f.bbsContent.value = str;

	    str = f.bbsCategory.value.trim();
	    if (!str) {
	        alert("\n카테고리를 선택하세요.");
	        f.bbsCategory.focus();
	        return;
	    }
	    f.bbsCategory.value = str;

	    // URL 확인
	    console.log("Action URL: " + f.action);

	    f.action = "<%=cp%>/BBS/created_complates";
	    f.submit();
	    console.log("성공적으로 전송");
	}

		
	</script>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.do">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.do">메인</a></li>
				<li class="active"><a class="nav-link active"
					href="./BBS/list.do">게시판</a></li>
			</ul>
			<div class="container">
				<div class="row">
					<form method="post" action="" name="myForm">
						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd;">
							<thead>
								<tr>
									<th colspan="2"
										style="background-color: #eeeeee; text-align: center;">게시판
										글쓰기 양식</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><select name="bbsCategory" id="bbsCategory"
										class="form-control">
											<option value="공지">공지</option>
											<option value="자유">자유</option>
											<option value="질문">질문</option>
									</select></td>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
								</tr>
								<tr>
									<td colspan="2"><textarea type="text" class="form-control"
											placeholder="글 내용" name="bbsContent" maxlength="2048"
											style="height: 350px;"></textarea></td>
								</tr>
							</tbody>

						</table>
						<button class="btn btn-outline-primary my-2 my-sm-0"
							onclick="sendIt(event)">글쓰기</button>

					</form>
				</div>
			</div>
		</div>
	</nav>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>