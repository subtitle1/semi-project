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
<%@ include file="admin-common.jsp" %>

<% 

MemberDao memberDao = MemberDao.getInstance();

List<Member> memberList = memberDao.selectAllMembers(1, 10);
List<Member> leftMemberList = memberDao.selectAllLeftMembers(1, 10);

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
		
		<h4>탈퇴한 회원 리스트</h4>
	<table class="table table-hover table-striped">
		<colgroup>
			<col width="5%">
			<col width="7%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="5%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>주소</th>
				<th>포인트</th>
				<th>가입일</th>
				<th>탈퇴일</th>
			</tr>
		</thead>
		<tbody>
			<% 
	for (Member member : leftMemberList) {
%>	
			<tr>
				<td><%=member.getNo() %></td>		
				<td><a href="member-detail.jsp?no=<%=member.getNo()%>"><%=member.getName() %></td>
				<td><%=member.getTel() %></td>
				<td><%=member.getEmail() %></td>
				<td><%=member.getAddress() %></td>
				<td><%=member.getPct() %></td>
				<td><%=member.getRegisteredDate() %></td>
				<td><%=member.getDeletedDate() != null ? member.getDeletedDate() : ""%></td>
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