<%@page import="vo.QnA"%>
<%@page import="dto.QnADetailDto"%>
<%@page import="dao.QnaDao"%>
<%@page import="dto.ReviewDetailDto"%>
<%@page import="dao.ReviewDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="dto.OrderDetailDto"%>
<%@page import="vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="dao.OrderDao"%>
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
	 <title>ABC마트 관리자페이지</title>
	 <style>
	 
	.today-list-box {
    padding: 10px 0;
    border-top: 2px solid #000;
    border-bottom: 2px solid #000;
}
	.progress-box {
	margin: 10px
	}
	 
	 </style>
	</head>
	
	<body>
	<%@ include file="admin-common.jsp" %>
	<div class="container">   
	
	<%

	MemberDao memberDao = MemberDao.getInstance();
	List<Member> memberList = memberDao.selectTodayJoinMember();
	
	OrderDao orderDao = OrderDao.getInstance();
	ReviewDao reviewDao =ReviewDao.getInstance();
	QnaDao qnADao =QnaDao.getInstance();
	DecimalFormat priceDF = new DecimalFormat("###,###");
	
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
					<li class=""><a href="main.jsp" class="nav-link p-0">관리자페이지</a></li>
					<li class=""><a href="member-list.jsp" class="nav-link p-0">회원목록 조회</a></li>
					<li class=""><a href="member-left-list.jsp" class="nav-link p-0">탈퇴회원 목록 조회</a></li>
					<li class=""><a href="product-list.jsp?pgno=1" class="nav-link p-0">전체 상품 조회</a></li>
					<li class=""><a href="registerform.jsp" class="nav-link p-0">신규 상품 등록</a></li>
					<li class=""><a href="stock-management.jsp" class="nav-link p-0">재고 관리</a></li>
					<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
					<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
					<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>
				</ul>
		</div>	
	
		<div class="col-9">
			<div class="today">
				<p>오늘 xxxx.xx.xx 기준</p>
				<div class="today-list-box">
					<div class="row">
						<div class="col">
							신규회원
		                    <span class="count" id="todayJoinMember"></span>
							명
						</div>
						<div class="col">

							<span class="count" id="todayLeftMember"></span>
							탈퇴한 회원
						</div>
						<div class="col">

							<span class="count" id="finishCount"></span>
							신규주문
						</div>
						<div class="col">

		                    <span class="count" id="standByCount"></span>
							탈퇴한 회원
						</div>
						<div class="col">

							<span class="count" id="completeCount"></span>
							새로운 REVIEW
						</div>
						<div class="col">

							<span class="count" id="finishCount"></span>
							새로운 QnA
						</div>
					</div>
				</div>
			</div>
			
			<div class="progress-box">
			<p>배송 완료된 주문 현황</p>
			<div class="progress" style="height: 10px; width: 400px;" >
 			<div class="progress-bar bg-dark" role="progressbar" style="width: 25%"></div>
			</div>
			</div>
			<div class="progress-box">
			<p>답변 완료된 QnA 현황</p>
			<div class="progress" style="height: 10px; width: 400px;" >
 			<div class="progress-bar bg-dark" role="progressbar" style="width: 25%"></div>
			</div>
			</div>
			
			<div="row">
				<div="col-3">
					<h4>오늘 가입한 회원</h4>
			<table class="table table-hover mb-5" style="border-top: 2px solid #000; border-bottom: 1px solid #000" >
					<tbody>
<%
		if (memberList.isEmpty()) { 
%>			
			<h6>오늘 가입한 회원이 없습니다.</h6>
				</tbody>				
		</table>
<%
} else {

	for (Member member : memberList) {
			
%>					
						<tr>
							<td><a href="member-detail.jsp?no=<%=member.getNo()%>"><%=member.getId() %></a>
						    <%=member.getName()%>	
						    </td>
						</tr>   	
<% 
	}
}
%>						
						
					</tbody>				
				</table>
				
				</div>
				<div="col-3">
			
				</div>
				<div="col-3"></div>
				<div="col-3"></div>
			</div>
			
			<div="row">
				<div="col-6"></div>
				<div="col-6"></div>
			</div>
			
			
			
	</div>	
	</div>	
	</div>
	<%@ include file="../common/footer.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	
	
	</script>
	</body>
	</html>