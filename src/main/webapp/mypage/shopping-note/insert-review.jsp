<%@page import="vo.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.ReviewDao"%>
<%@page import="vo.Review"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member member = (Member)session.getAttribute("LOGIN_USER_INFO");
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int size  = Integer.parseInt(request.getParameter("size"));	
	String content = request.getParameter("content");
	
	if(content == null) {
		response.sendRedirect("my-review-form.jsp?error=contentEmpty");
		return;
	}
	StockDao stockDao = StockDao.getInstance();
	int stockNo = stockDao.selectStockNoByProductNoAndSize(productNo, size);
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	
	Review review = new Review();
	review.setMemberNo(member.getNo());
	review.setStockNo(stockNo);
	
	review.setContent(content);
	
	
	reviewDao.insertReview(review);
	
	response.sendRedirect("/semi-project/mypage/shopping-note/my-review.jsp?memberNo="+ member.getNo());
	

%>