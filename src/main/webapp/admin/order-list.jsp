
<%@page import="vo.Pagination2"%>
<%@page import="dao.OrderDao"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
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
<%@ include file="admin-common.jsp" %>

<% 

OrderDao orderDao = OrderDao.getInstance();

String pageNo = request.getParameter("pgno");

// 총 데이터 갯수를 조회한다.
int totalRecords = orderDao.selectTotalOrderCount();

// 페이징 처리 필요한 값을 계산하는 Paginatition객체를 생성한다.
Pagination2 pagination = new Pagination2(pageNo, totalRecords);

List<Order> orderList = orderDao.selectAllOrders(pagination.getBegin(), pagination.getEnd());



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
				<li class=""><a href="registerform.jsp" class="nav-link p-0">신규 상품 등록</a></li>
				<li class=""><a href="stock-management.jsp" class="nav-link p-0">재고 관리</a></li>
				<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
				<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>
			</ul>
		</div>	
		<div class="col-9">
		<h4>주문 목록</h4>
		<table class="table table-hover">
		<colgroup>
			<col width="5%">
			<col width="5%">
			<col width="12%">
			<col width="10%">
			<col width="10%">
			<col width="5%">
			<col width="8%">
		</colgroup>
		<thead>
			<tr>
				<th>주문번호</th>
				<th>회원번호</th>
				<th>총액</th>
				<th>주문상태</th>
				<th>주문일</th>
				<th>취소사유</th>
				<th>취소일</th>
				
			</tr>
		</thead>
		<tbody>
			<% 
	for (Order order : orderList) {
%>	
			<tr>
			
				<td><a href="order-detail.jsp?no=<%=order.getNo() %>"> </td>		
				<td><%=order.getMemberNo() %></td>		
				<td><%=order.getTotalPrice() %></td>
				<td><%=order.getStatus()%></td>
				<td><%=order.getOrderDate() %></td>
				<td><%=order.getCancelReason() %></td>
				<td><%=order.getCanceledDate() %></td>
				<td><%=order.getOrderDate() %></td>
				
			</tr>
<% 
	}
%>			
		</tbody>
	</table>
	<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="order-list.jsp?pgno=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="order-list.jsp?pgno=<%=num%>"><%=num %></a></li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="order-list.jsp?pgno=<%=pagination.getNextPage()%>" >다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
		</div>
		
</div>	
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>