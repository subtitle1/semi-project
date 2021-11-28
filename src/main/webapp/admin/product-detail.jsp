<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="dto.ProductDetailDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../resources/css/style.css" />
    <title></title>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>


<%
int no = Integer.parseInt(request.getParameter("no"));

ProductDao productDao= ProductDao.getInstance();
Product product = productDao.selectProductbyNo(no);

%>
<div class="container">    
<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="" class="nav-link p-0">HOME</a></li>
				<li class="crumb">관리자페이지</li>
				<li class="crumb">관리자페이지</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>관리자페이지</h1>
		</div>
	</div>
	<div class="row mypage">
		<!-- aside 시작 -->
		<div class="col-2 p-0 aside">
			<span class="aside-title">관리자 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="member-list.jsp" class="nav-link p-0">회원목록 조회</a></li>
				<li class=""><a href="member-left-list.jsp" class="nav-link p-0">탈퇴회원 목록 조회</a></li>
				<li class=""><a href="product-list.jsp" class="nav-link p-0">전체 상품 조회</a></li>
				<li class=""><a href="register-product.jsp" class="nav-link p-0">신규 상품 등록</a></li>
				<li class=""><a href="stock-management.jsp" class="nav-link p-0">재고 관리</a></li>
				<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
				<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>
				</ul>
		</div>	
		
		
		 
<div class="product_admin_detail mt-5 mb-5 col-9">
		<div class="row">
 		<div class="img col-4">
			<img src="/semi-project/resources/images/products/<%=product.getPhoto() %>">
		</div>
		<h2><%=product.getName() %> by <%=product.getBrand() %></h2>
	
		<table class="col-4" style="border-top: 2px solid #000">
			<tbody>
			<tr>
				<th>판매가</th>
				<td class="price"><%=product.getPrice() %></td>
			</tr>
			<tr>
				<th>할인가격</th>
				<td><%=product.getDisPrice() %></td>
			</tr>
			<tr>
				<th>상품번호</th>
				<td><%=product.getNo() %></td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td><%=product.getCategory() %></td>
			</tr>
			</tbody>
		</table>	
		</div>	
</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>