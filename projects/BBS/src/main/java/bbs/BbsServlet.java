package bbs;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import com.util.MyUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BbsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	// 포워드 메서드 만들어서 호출해서 쓰기
	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url)
			throws ServletException, IOException {

		// 포워딩될 페이지 지정 - 주소대신 String url을 써주면 우리는 forward를 호출할때 url을 써주면 된다.
		RequestDispatcher rd = req.getRequestDispatcher(url);

		rd.forward(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		BbsDAO bbsDAO = new BbsDAO();

		String cp = req.getContextPath(); // cp는 -> /study 이다
		String uri = req.getRequestURI(); // -> /study/sboard/sboard/created.do (uri는 전체 주소)

		String url;

		MyUtil myUtil = new MyUtil(); // 애는 페이징 처리 클래스이다.

		if (uri.indexOf("created.do") != -1) {
			System.out.println("서블릿 통해서 넘어온 작성 페이지");
			url = "/view/write.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("created_complates") != -1) {
			Bbs dto = new Bbs();
			Random ran = new Random();
			Random ran2 = new Random();
			String tempID = ran.nextInt(100) + "." + ran2.nextInt(100);

			String userID = null;
			dto.setBbsTitle(req.getParameter("bbsTitle"));
			dto.setUserID(tempID);
			dto.setBbsContent(req.getParameter("bbsContent"));
			dto.setBbsCategory(req.getParameter("bbsCategory"));

			bbsDAO.insertData(dto);
			System.out.println("입력 성공");
			url = "list.do";
			resp.sendRedirect(url);
		}
		// 만약에 created_ok.do가 있으면
		else if (uri.indexOf("list.do") != -1) {
			System.out.println("서블릿 통해서 넘어온 리스트 페이지");
			String pageNumber = req.getParameter("pageNumber");

			int currentPage = 1;

			if (pageNumber != null)
				currentPage = Integer.parseInt(pageNumber);

			String category = req.getParameter("category");
			System.out.println(category);
			int dataCount = 0;
			try {
				dataCount = bbsDAO.getNextPage(category);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			int numPerPage = 5;
			int totalPage = myUtil.getPageCount(numPerPage, dataCount);

			if (currentPage > totalPage)
				currentPage = totalPage;
			ArrayList<Bbs> lists = new ArrayList<Bbs>();
			// 이제 데이터를 가져온다
			lists = null;
			try {
				lists = bbsDAO.getList(currentPage, category);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String articleUrl = cp + "/BBS/view.do?pageNum=" + currentPage;
			// 포워딩 페이지에 데이터 넘기기
			req.setAttribute("lists", lists);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("dataCount", dataCount);
			System.out.println(lists);
			System.out.println(articleUrl);
			System.out.println(dataCount);

			url = "/view/BBS.jsp";
			forward(req, resp, url);

		}

		else if (uri.indexOf("search.do") != -1) {
			System.out.println("서블릿 통해서 넘어온 검색 페이지");
			url = cp + "/view/BBSSearch.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("search_ok") != -1) {
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			System.out.println("서블릿 통해서 넘어온 검색 기능 작동 페이지");
			String searchKeyword = req.getParameter("searchKeyword");
			String bbsCategory = req.getParameter("category");
			System.out.println(searchKeyword);
			System.out.println(bbsCategory);
			list = null;
			try {
				list = bbsDAO.search(bbsCategory, searchKeyword);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			req.setAttribute("lists", list);
			System.out.println(list);

			url = "/view/BBSSearch.jsp";
			forward(req, resp, url);

		}

		else if (uri.indexOf("main.do") != -1) {
			System.out.println("서블릿 통해서 넘어온 메인 페이지");
			url = "../main.jsp";
			resp.sendRedirect(url);

		} else if (uri.indexOf("view.do") != -1) {
			System.out.println("서블릿 통해서 넘어온 상세 페이지");
			int bbsId = Integer.parseInt(req.getParameter("bbsId"));
			System.out.println("bbsid는" + bbsId);

			Bbs bbs = new BbsDAO().getBbs(bbsId);
			req.setAttribute("title", bbs.getBbsTitle());
			req.setAttribute("category", bbs.getBbsCategory());
			req.setAttribute("content", bbs.getBbsContent());
			req.setAttribute("time", bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
					+ bbs.getBbsDate().substring(14, 16) + "분");
			req.setAttribute("view", bbs.getBbsView() + 1);

			System.out.println(bbs.getBbsTitle());
			System.out.println(bbs.getBbsCategory());
			System.out.println(bbs.getBbsContent());
			System.out.println(bbs.getBbsDate());
			System.out.println(bbs.getBbsView() + 1);
			url = "../view/view.jsp";
			forward(req, resp, url);
		}

//
//	}
	}
}
