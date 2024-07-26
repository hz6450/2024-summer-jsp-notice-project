<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%String cp = request.getContextPath(); %>
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
	<%
	ArrayList<Bbs> list = new ArrayList<Bbs>();
	
	String userID = null;
	BbsDAO bbsDAO = new BbsDAO();
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	String category = null;
	if (request.getParameter("category") != null) {
		category = request.getParameter("category");
	}
	String bbsCategory = null;
	if (request.getParameter("bbsCategory") != null) {
		bbsCategory = request.getParameter("bbsCategory");
	}

	String searchKeyword = null;
	if (request.getParameter("searchKeyword") != null) {
		searchKeyword = request.getParameter("searchKeyword");
		list = bbsDAO.search(bbsCategory, searchKeyword);
	}

	%>
	
	<script>
function searchIt(event){
    event.preventDefault();  // 기본 폼 제출 동작 방지

    console.log("searchIt 호출");

    var f = document.myForm;

    var str = f.searchKeyword.value.trim();
    f.searchKeyword.value = str;

    str = f.bbsCategory.value.trim();
    f.bbsCategory.value = str;
  // Check if action is correctly set
    console.log("Action URL: " + f.action);

    f.action = "<%=cp%>/BBS/search_ok";  // Ensure the URL is correct
    f.method = "post";  // Set form method to POST
    f.submit();
    console.log("성공적으로 검색 데이터 전송");
}
</script>

    
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="./main.do">JSP 게시판 웹 사이트</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
        aria-controls="bs-example-navbar-collapse-1" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="./main.do">메인</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="./list.do">게시판</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <div class="row justify-content-end mb-2">
        <div class="col-auto">
            <form class="form-inline" method="post" action="" name="myForm">
                <select name="bbsCategory" id="bbsCategory" class="form-control">
                    <option value="bbsTitle">제목</option>
                    <option value="bbsId">게시물 번호</option>
                </select>
                <input class="form-control mr-sm-2" type="search" placeholder="검색어 입력" aria-label="Search" name="searchKeyword">
                <button class="btn btn-outline-primary my-2 my-sm-0" onclick="searchIt(event)">검색</button>
            </form>
        </div>
    </div>
    <div class="row">
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
                <c:set var="BbsCategory" value="null" />
                <c:set var="listCount" value="<%=bbsDAO.getNextPage(category)%>" />
                <%
                for (int i = 0; i < list.size(); i++) {
                %>
                <tr>
                    <td><%=list.get(i).getBbsId()%></td>
                    <td><%=list.get(i).getBbsCategory()%></td>
                    <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsId()%>"><%=list.get(i).getBbsTitle()%></a></td>
                    <td><%=list.get(i).getBbsDate().substring(0, 16).replace(" ", "<br>")%></td>
                    <td><%=list.get(i).getBbsView()%></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>