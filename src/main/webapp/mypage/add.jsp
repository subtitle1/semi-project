<%@page import="dao.StockDao"%>
<%@page import="dao.CartDao"%>
<%@page import="vo.Member"%>
<%@page import="vo.Cart"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");	

	// todo
	// 상품 번호와 size를 가져올 것
	
	// product_detail_no를 cart db에 넣음

	int memberNo = loginUserInfo.getNo();
	// 장바구니에 담은 상품 no값을 가져온다.
	int no = Integer.parseInt(request.getParameter("no"));
	// 장바구니 상품의 size 값을 가져온다.
	int size = Integer.parseInt(request.getParameter("size"));
	
	StockDao stockDao = StockDao.getInstance();
	
	CartDao cartDao = CartDao.getInstance();
	
	List<Cart> cartList = cartDao.selectAllCartList();
	
	// productNo와 size로 product_detail_no를 반환한다 StockDao selectStockNoByProductNoAndSize 활용
	//int detailNo = stockDao.selectStockNoByProductNoAndSize(no, size);
	
	// 조회한값을 cart 변수를 만들어서 대입
	Cart cart = new Cart();
	cart.setMemberNo(memberNo);
	//cart.setStockNo(detailNo);
	
	// 장바구니 수량을 확인함. no값과 상품번호가 일치하는 경우, amount 값을 증가시키고 그렇지 않은경우 상품 수량을 1로 변경후 추가
	int cnt = 0;
	for(int i = 0; i < cartList.size(); i++){
		cart = cartList.get(i);
		if(cart.getStockNo() == no) {
			cnt++;
			int orderAmount = cart.getAmount() + 1;
			cart.setAmount(orderAmount);
			
		}
	}
	
	if (cnt == 0) {
		cart.setAmount(1);
		cartDao.insertCartInfo(cart);
	}
	
	//cartDao.updateCartAmount(cart);
	
	// 대입한값을 cart_db에 저장
	
	
	//response.sendRedirect("../detail.jsp?no=" + no);
%>