<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
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
	pageContext.setAttribute("content", bbs.getBbsContent());
	%>
	    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
            aria-controls="bs-example-navbar-collapse-1" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link " href="../main.do">메인</a>
                </li>
                <li class="nav-item ">
                    <a class="nav-link active" href="./BBS/list.do">게시판</a>
                </li>
            </ul>
        </div>
    </nav>
	<div class="container">
		<div class="row">
			<form method="post" action="../controller/updateAction.jsp?bbsID=${bbsID}">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 수정 양식</th>

						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50" value="${title}" ></td>
						</tr>

						<tr>
							<td><textarea type="text" class="form-control"
									placeholder="글 내용" name="bbsContent" maxlength="2048"
									style="height: 350px; "><c:out value="${content}"/></textarea></td>
						</tr>
					</tbody>

				</table>
				<input type="submit" href="bbs.jsp"
					class="btn btn-primary pull-right" value="글 수정">
			</form>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>

</html>