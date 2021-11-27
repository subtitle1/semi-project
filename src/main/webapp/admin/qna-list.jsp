<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDao"%>
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
QnaDao qnaDao = QnaDao.getInstance();

List<QnADetailDto> qnaDetailList = qnaDao.selectAllQnADetail(1, 20);


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
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>	</ul>
		</div>	
		<div class="col-9">
		<h4>QnA 목록</h4>
		<table class="table table-hover">
		<colgroup>
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="15%">
			<col width="25%">
			<col width="10%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<th>제품이미지</th>
				<th>제품</th>
				<th>아이디</th>
				<th>제목</th>
				<th>내용</th>
				<th>답변여부</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<% 
	for (QnADetailDto qnaDetail : qnaDetailList) {
%>	
			<tr>
				<td><img src = "/semi-project/resources/images/products/<%=qnaDetail.getPhoto() %> " width="60" height="60"></td>	
				<td><%=qnaDetail.getProductName() %></td>
				<td><%=qnaDetail.getMemberId() %></td>
				<td><%=qnaDetail.getTitle() %></td>
				<td><%=qnaDetail.getQuestionContent() %></td>
				<td><%=qnaDetail.getQuestionAnswered() %></td>
				<td><%=qnaDetail.getQuestionDate() %></td>
			</tr>
<% 
	}
%>			
		</tbody>
	</table>
		</div>
		
</div>	
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>