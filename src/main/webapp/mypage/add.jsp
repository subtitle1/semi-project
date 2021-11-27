<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Member"%>
<%@page import="dao.MemberDao"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// no에 저장되어있는 내용을 조회한다.
	int no = Integer.parseInt(request.getParameter("no"));
	
	// 클라이언트 전용의 세션객체에서 사용자정보 조회
	Member member = (Member)session.getAttribute("LOGIN_USER_INFO");
	// 클라이언트 전용의 세션객체에서 사용자 정보가 조회되지 않으면 로그인하지 않은 사용자임
	// 로그인폼 페이지를 재요청하는 URL을 응답으로 보낸다.
	if (member == null) {
		String encodedText = URLEncoder.encode("장바구니담기", "utf-8");
		response.sendRedirect("../loginform.jsp?fail=deny&job=" + encodedText);
		return;
	}
	// 조회된 사용자정보에서 사용자 아이디 조회
	String memberId = member.getId(); 
	
	ProductDao productDao = ProductDao.getInstance();
	
	Product product = productDao.selectProductbyNo(no);
	
	//response.sendRedirect("cartform.jsp?no=" + no);
	
%>
<p>상품번호: <%=no %></p>
<p>회원아이디: <%=memberId %></p>