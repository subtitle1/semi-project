<%@page import="service.StockService"%>
<%@page import="dao.StockDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int stockAmount = Integer.parseInt(request.getParameter("amount"));
int productDetailNo = Integer.parseInt(request.getParameter("no"));

StockDao stockDao = StockDao.getInstance();
StockService stockService = new StockService();

stockService.UpdateStockAmount(productDetailNo, stockAmount);

//전체 글목록을 제공하는 list.jsp를 재요청하게 하는 응답을 보낸다.
response.sendRedirect("stock-management.jsp");

%>