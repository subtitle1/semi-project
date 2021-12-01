<%@page import="dao.MemberDao"%>
<%@page import="vo.Stock"%>
<%@page import="vo.Order"%>
<%@page import="dto.CancelProductDto"%>
<%@page import="vo.Member"%>
<%@page import="vo.Product"%>
<%@page import="dao.StockDao"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%
	Member member = (Member) session.getAttribute("LOGIN_USER_INFO");

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String values[] = request.getParameterValues("stockNo");
	String reason = request.getParameter("cancelReason");
	
	OrderDao orderDao = OrderDao.getInstance();
	ProductDao productDao = ProductDao.getInstance();
	StockDao stockDao = StockDao.getInstance();
	
	int stockNo = 0;
	for (int i = 0; i < values.length; i++) {
		stockNo = Integer.parseInt(values[i]);
	}

	// product, order, stock 정보 조회
	CancelProductDto product = productDao.selectProductDetailByOrderNoAndStockNo(orderNo, stockNo);
	Order order = orderDao.selectOrderByOrderNo(orderNo);
	Stock stock = stockDao.selectStockByProductDetailNo(stockNo);
	
	System.out.println(product);
	System.out.println(order);
	System.out.println(stock);
	
	// 아래 메소드로 stock, order_item, product 총 세개의 테이블 조회 가능
	List<OrderDetailDto> orderDetails = orderDao.selectOrderDetailByItems(orderNo, stockNo);
	for (OrderDetailDto orderDetail : orderDetails) {
		order.setStatus("주문취소");
		order.setCancelReason(reason);
		order.setCancelStatus("Y");
		
		if (product.getDisprice() > 0) {
			order.setTotalPrice(order.getTotalPrice() - product.getDisprice());
		} else {
			order.setTotalPrice(order.getTotalPrice() - product.getPrice());
		}
		
		stock.setNo(orderDetail.getProductDetailNo());
		stock.setStock(stock.getStock() - orderDetail.getAmount());
		
		// orderDao.updateOrder(order);
		// stockDao.updateStock(stock);
		
		System.out.println();
		System.out.println(order);
		System.out.println(stock);
	}
%>