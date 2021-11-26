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
    <title>관리자페이지</title>
</head>

<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">   

<%
int no = Integer.parseInt(request.getParameter("no"));

MemberDao memberDao = MemberDao.getInstance();
Member member = memberDao.selectMemberByNo(no);

%>
<div class="row">
		<div class="col p-0 page-title">
			<h1>관리자페이지</h1>
		</div>
	</div>
<div class="row mypage">
 	<div class="col-2 p-0 aside">
			<span class="aside-title">관리자 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="" class="nav-link p-0">회원목록 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">탈퇴회원 목록 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">전체 상품 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">신규 상품 등록</a></li>
				<li class=""><a href="" class="nav-link p-0">재고 관리</a></li>
				<li class=""><a href="" class="nav-link p-0">주문 관리</a></li>
			</ul>
	</div>	

	<div class="col-9">
	<table class="table table-hover">
				<tbody>
					<tr class="d-flex">
						<th class="col-2">번호</th>
						<td class="col-4"><%=member.getNo() %></td>
						<th class="col-2">이름</th>
						<td class="col-4"><%=member.getName() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">연락처</th>
						<td class="col-4"><%=member.getTel() %></td>
						<th class="col-2">이메일</th>
						<td class="col-4"><%=member.getEmail() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">주소</th>
						<td class="col-4"><%=member.getAddress() %></td>
						<th class="col-2">포인트</th>
						<td class="col-4">
							<%=member.getPct() %>
					</tr>
					<tr class="d-flex">
						<th class="col-4">가입일</th>
						<td class="col-8"><%=member.getRegisteredDate() %></td>
					</tr>
				</tbody>				
	</table>
</div>	
			<h2>최근 구매 내역</h2>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>