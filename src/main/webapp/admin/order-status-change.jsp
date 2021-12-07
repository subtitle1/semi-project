<%@page import="vo.Order"%>
<%@page import="dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String status = request.getParameter("status");
int orderNo = Integer.parseInt(request.getParameter("no"));

OrderDao orderDao = OrderDao.getInstance();
Order order = orderDao.selectOrderByOrderNo(orderNo);
order.setStatus(status);

orderDao.updateOrderStatus(order);


//전체 글목록을 제공하는 list.jsp를 재요청하게 하는 응답을 보낸다.
response.sendRedirect("order-list.jsp");

%>