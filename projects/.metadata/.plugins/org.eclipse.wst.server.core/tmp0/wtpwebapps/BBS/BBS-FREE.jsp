<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="css/custom-font.css">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JSP 게시판 웹 사이트</title>
<link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style type="text/css">
/* Custom CSS styles can go here */
#bbs-table {
    box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.1);
}

#bbs-table th, #bbs-table td {
    vertical-align: middle;
}

.btn-arrow-left {
    margin-right: 10px;
}

/* Custom style for button container */
.btn-container {
    display: flex;
    justify-content: center; /* Center align buttons */
    margin-bottom: 20px; /* Add bottom margin for spacing */
}
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

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#bs-example-navbar-collapse-1"
            aria-controls="bs-example-navbar-collapse-1" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse"
            id="bs-example-navbar-collapse-1">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link" href="main.jsp">메인</a>
                </li>
                <li class="nav-item active"><a class="nav-link" href="BBS.jsp">게시판</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">

        <div class="btn-container" >
        <button type="button" class="btn btn-light " onclick="location.href='BBS.jsp'">전체</button>
            <button type="button" class="btn btn-light " onclick="location.href='BBS-NOTICE.jsp'">공지</button>
            <button type="button" class="btn btn-light" onclick="location.href='BBS-QUESTION.jsp'">질문</button>
            <button type="button" class="btn btn-light active" onclick="location.href='BBS-FREE.jsp'">자유</button>
        </div>

        <div class="row">
            <table class="table table-striped" id="bbs-table">
                <thead>
                    <tr>
                        <th scope="col" style="width: 15%">No.</th>
                        <th scope="col" style="width: 15%">종류</th>
                        <th scope="col" style="width: 30%">제목</th>
                        <th scope="col" style="width: 10%">작성자</th>
                        <th scope="col" style="width: 20%">작성일</th>
                        <th scope="col">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<Bbs> list = bbsDAO.getListFree(pageNumber);
                    for (int i = 0; i < list.size(); i++) {
                    %>
                    <tr>
                        <td><%=list.get(i).getBbsId()%></td>
                        <td><%=list.get(i).getBbsCategory()%></td>
                        <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsId()%>"><%=list.get(i).getBbsTitle()%></a></td>
                        <td><%=list.get(i).getUserID()%></td>
                        <td><%=list.get(i).getBbsDate().substring(0, 16).replace(" ", "<br>")%></td>
                        <td><%=list.get(i).getBbsView()%></td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>

            <div class="d-flex justify-content-between align-items-center">
                <a href="BBS.jsp?pageNumber=<%=pageNumber - 1%>"
                    class="btn btn-success btn-arrow-left">이전</a> <a
                    href="BBS.jsp?pageNumber=<%=pageNumber + 1%>"
                    class="btn btn-success btn-arrow-left">다음</a> <a href="write.jsp"
                    class="btn btn-primary">글쓰기</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
    <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
