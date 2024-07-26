<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JSP 게시판 웹 사이트</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style type="text/css">
#bbs-table {
	box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.1);
}

#bbs-table th, #bbs-table td {
	vertical-align: middle;
}

.btn-container {
	display: flex;
	justify-content: center; /* Center align buttons */
	margin-bottom: 20px; /* Add bottom margin for spacing */
}

.pagination-container {
	margin-top: 20px; /* Add top margin for spacing */
	display: flex;
	justify-content: center; /* Center align pagination */
}

.pagination-container a {
	color: #007bff; /* Bootstrap primary link color */
	padding: 6px 12px;
	margin: 0 4px;
	text-decoration: none;
	border: 1px solid #007bff; /* Bootstrap primary border color */
	border-radius: 4px;
}

.pagination-container .active a {
	background-color: #007bff; /* Bootstrap primary background color */
	color: #fff; /* White text for active link */
}
</style>

</head>


<body>

	<script>
    function sendIt(event, bbsId) {
        event.preventDefault();  // 기본 링크 동작 방지
        var f = document.myForm;
        f.bbsId.value = bbsId;  // 폼의 bbsId 값을 클릭한 제목의 bbsId로 설정
        f.action = "<%=cp%>/BBS/view.do";
			f.submit(); // 폼 제출
		}
	</script>

	<c:set var="pageNumber" value="${param.pageNumber}" />
	<c:if test="${empty pageNumber}">
		<c:set var="pageNumber" value="1" />
	</c:if>

	<c:set var="category" value="${param.category}" />
	<c:if test="${not empty category}">
		<c:set var="category" value="${category}" />
	</c:if>
	<c:set var="bbsCategory" value="${param.bbsCategory}" />
	<c:if test="${not empty category}">
		<c:set var="bbsCategory" value="${bbsCategory}" />
	</c:if>
	<%
	ArrayList<Bbs> list = new ArrayList<Bbs>();
	String userID = null;
	BbsDAO bbsDAO = new BbsDAO();
	%>


	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="./main.do">JSP 게시판 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#bs-example-navbar-collapse-1"
			aria-controls="bs-example-navbar-collapse-1" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link " href="./main.do">메인</a>
				</li>
				<li class="nav-item "><a class="nav-link active"
					href="./BBS/list.do">게시판</a></li>
			</ul>
		</div>
	</nav>

	<div class="container mt-4">
		<div class="btn-container">
			<a href=<%=cp%> /BBS/list.do>
				<button type="button" class="btn btn-light"
					style="border: 1px solid black; margin: 10px;">전체</button>
			</a> <a href=<%=cp%> /BBS/list.do?category=공지>
				<button type="button" class="btn btn-light"
					style="border: 1px solid black; margin: 10px;">공지</button>
			</a> <a href=<%=cp%> /BBS/list.do?category=질문>
				<button type="button" class="btn btn-light"
					style="border: 1px solid black; margin: 10px;">질문</button>
			</a> <a href=<%=cp%> /BBS/list.do?category=자유>
				<button type="button" class="btn btn-light"
					style="border: 1px solid black; margin: 10px;">자유</button>
			</a>
		</div>

		<div>
			<c:set var="dataCount" value="${dataCount}" />
			총 게시물 갯수 :
			<c:out value="${dataCount}" />
		</div>
		<div class="row justify-content-end mb-2">
			<div class="col-auto">
				<a href=<%=cp%> /BBS/search.do><button
						class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button></a>
			</div>
		</div>
		<div class="row">

			<form method="post" action="" name="myForm">
				<input type="hidden" name="bbsId" value="" />
			</form>

			<table class="table table-striped" id="bbs-table">
				<thead>
					<tr>
						<th scope="col" style="width: 15%">No.</th>
						<th scope="col" style="width: 15%">종류</th>
						<th scope="col" style="width: 30%">제목</th>
						<th scope="col" style="width: 20%">작성일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="listCount" value="${dataCount}" />
					<c:forEach var="dto" items="${lists}">
						<tr>
							<td>${dto.bbsId}</td>
							<td>${dto.bbsCategory}</td>
							<td><a href="#" onclick="sendIt(event, '${dto.bbsId}')">${dto.bbsTitle}</a></td>
							<td>${dto.bbsDate}</td>
							<td>${dto.bbsView}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>

		<div class="pagination-container">
			<%-- 초기페이지 --%>
			<c:set var="totalPages" value="0" />
			<c:choose>
				<c:when test="${listCount % 5 == 0}">
					<c:set var="totalPages" value="${listCount / 5}" />
				</c:when>
				<c:otherwise>
					<c:set var="totalPages" value="${(listCount / 5) + 1}" />
				</c:otherwise>
			</c:choose>
			<c:if test="${totalPages >= 5}">
				<a href="<%=cp%>/BBS/list.do?pageNumber=1" class="btn">&lt;&lt;</a>
			</c:if>
			<%-- 이전 페이지 --%>
			<c:if test="${pageNumber > 1}">
				<c:choose>
					<c:when test="${empty category}">
						<a href="<%=cp%>/BBS/list.do?pageNumber=${pageNumber - 1}"
							class="btn">이전</a>
					</c:when>
					<c:otherwise>
						<a
							href="<%=cp%>/BBS/list.do?category=${category}&pageNumber=${pageNumber - 1}"
							class="btn">이전</a>
					</c:otherwise>
				</c:choose>
			</c:if>

			<%-- 페이지 번호 --%>

			<c:set var="startPage"
				value="${(pageNumber - 2) ge 1 ? (pageNumber - 2) : 1}" />
			<c:set var="endPage"
				value="${(startPage + 4) le totalPages ? (startPage + 4) : totalPages}" />


			<c:forEach var="i" begin="${startPage}" end="${endPage}">
				<c:set var="activeClass"
					value="${(i == pageNumber) ? 'active' : ''}" />
				<c:choose>
					<c:when test="${empty category}">
						<a href="<%=cp%>/BBS/list.do?pageNumber=${i}"
							class="btn btn-light ${activeClass}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="<%=cp%>/BBS/list.do?category=${category}&pageNumber=${i}"
							class="btn btn-light ${activeClass}">${i}</a>
					</c:otherwise>
				</c:choose>

			</c:forEach>
			<%-- 다음 페이지 --%>
			<c:if test="${pageNumber < totalPages}">
				<c:choose>
					<c:when test="${empty category}">
						<a href="<%=cp%>/BBS/list.do?pageNumber=${pageNumber + 1}"
							class="btn">다음</a>
					</c:when>
					<c:otherwise>
						<a
							href="<%=cp%>/BBS/list.do?category=${category}&pageNumber=${pageNumber + 1}"
							class="btn">다음</a>
					</c:otherwise>
				</c:choose>
			</c:if>

			<%-- 마지막 페이지 --%>
			<c:if test="${pageNumber != endPage}">
				<c:choose>
					<c:when test="${empty category}">
						<a href="<%=cp%>/BBS/list.do?pageNumber=${totalPages}" class="btn">&gt;&gt;</a>
					</c:when>
					<c:otherwise>
						<a
							href="<%=cp%>/BBS/list.do?category=${category}&pageNumber=${totalPages}"
							class="btn">&gt;&gt;</a>
					</c:otherwise>
				</c:choose>
			</c:if>

		</div>

		<a href=<%=cp%> /BBS/created.do class="btn btn-primary btn-write">글쓰기</a>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>