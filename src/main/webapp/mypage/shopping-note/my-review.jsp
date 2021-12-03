<%@page import="vo.Pagination"%>
<%@page import="dto.ReviewDetailDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.ReviewDao"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link rel="stylesheet" href="/semi-project/resources/css/style.css" />
    <title>상품 리뷰</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">    
<%
	MemberDao memberDao = MemberDao.getInstance();
	Member member = memberDao.selectMemberByNo(loginUserInfo.getNo());
%>
	<div class="row">
		<div class="col breadcrumb">
			<ul class="nav">
				<li class="crumb home"><a href="" class="nav-link p-0">HOME</a></li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">마이페이지</li>
				<li class="crumb">마이페이지</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col p-0 page-title">
			<h1>마이페이지</h1>
		</div>
	</div>
	<div class="row mypage">
		<!-- aside 시작 -->
		<div class="col-2 p-0 aside">
			<span class="aside-title">마이 페이지</span>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">마이페이지</a></li>
				<li class=""><a href="" class="nav-link p-0">개인정보 수정</a></li>
				<li class=""><a href="" class="nav-link p-0">비밀번호 변경</a></li>
				<li class=""><a href="../claim/claim-order-main.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">주문현황 조회</a></li>
				<li class=""><a href="" class="nav-link p-0">주문 취소</a></li>
				<li class=""><a href="" class="nav-link p-0">회원 탈퇴</a></li>
			</ul>
			<ul class="nav flex-column p-0">
				<li class=""><a href="../shopping-note/my-review.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">나의 상품후기</a></li>
				<li class=""><a href="../shopping-note/my-qna.jsp?memberNo=<%=member.getNo() %>" class="nav-link p-0">상품 Q&A</a></li>
			</ul>
		</div>
		<!-- //aside 끝 -->
		<div class="offset-md-1 col-9 p-0">
			<div class="card member-box p-0">
				<div class="row g-0">
					<div class="col-2 p-0">
						<span class="icon-grade"></span>
					</div>
					<div class="col-6 p-0 middle-box">
						<p><%=member.getName() %> 님은 <strong>통합멤버십 회원</strong>입니다.</p>
						<span class="member-info">MEMBERSHIP <span class="member-number"><%=member.getNo() %></span></span> 
						<span class="member-info">멤버십 회원 가입일 <span class="member-number"><%=member.getRegisteredDate() %></span></span> 
					</div>
					<div class="col-4 p-0 right-box">
						<span class="text-center"><img src="" alt="" />포인트</span>
						<span class="point"><%=member.getPct() %><span class="unit">p</span></span>
					</div>
				</div>
			</div>
			<div class="order-list">
			<p>상품 후기</p>
				<div class="inquiry-box">
					<div class="row">
<%
	String pageNo = request.getParameter("pageNo");	
	ReviewDao reviewDao = ReviewDao.getInstance();
	int totalRecords = reviewDao.selectTotalReviewCountByMemberNo(member.getNo());
	Pagination pagination = new Pagination(pageNo, totalRecords);
	

	List<ReviewDetailDto> reviewDetails = reviewDao.getReviewListByMemberNo(pagination.getBegin(), pagination.getEnd(), member.getNo());

	if (reviewDetails.isEmpty()) {
%>
						<div class="p-5">
							<p class="text-center order-font">작성된 상품 후기가 없습니다.</p>
						</div>
<%
	} else {
		
%>
						<div class="col mt-2">
							<span style="margin-left:5px;">총 <%=totalRecords%>건의 상품 후기가 있습니다.</span>
						</div>
					</div>
					<hr>
	<% 
			for (ReviewDetailDto detail : reviewDetails) {
	%>
					<div class="row">
			            <div>
			                <div class="accordion accordion-flush" id="faqlist">
			                    <div class="accordion-item">
			                   	    <div class="row p-2">
										<div class="col-3">
											<img class="order-img me-2" src="../../resources/images/products/<%=detail.getPhoto()%>">
											<div>
												<div>
													<span><strong>상품명</strong></span>
												</div>
												<div>
													<span><%=detail.getProductName() %></span>
												</div>
											</div>
										</div>
										<div class="col mt-4 text-end">
											<span>review</span>
										</div>
										<div class="col mt-4 text-end">
											<span style="font-weight: bold;"><%=detail.getReviewDate() %></span>
										</div>
										<div class="col mt-3 text-end">
										<h2 class="accordion-header" id="faq-heading-<%=detail.getReviewNo()%>">
				                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq-content-<%=detail.getReviewNo()%>">
				                            </button>
			                        	</h2>
										</div>
									</div>
			                        <div id="faq-content-<%=detail.getReviewNo()%>" class="accordion-collapse collapse" data-bs-parent="#faqlist">
			                            <div class="accordion-body">
			                                <strong>review : </strong><%=detail.getContent() %>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
		        	</div>
		        	<hr>
				
<%
		}
	}
%>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="/common/footer.jsp" %>
</body>
</html>