<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Member loginUserInfo = (Member) session.getAttribute("LOGIN_USER_INFO");
%>
<nav class="navbar navbar-expand-lg navbar-light bg-top">
	<div class="container p-0">
		<div class="collapse navbar-collapse" id="navbar-1">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					 <a class="navbar-brand" href="/semi-project/main.jsp">
				      <img src="/semi-project/resources/images/logo-sm.png" alt="" class="d-inline-block align-text-top">
				    </a>
				</li>
			</ul>
			<ul class="navbar-nav">
<%
	if (loginUserInfo == null) {
%>
				<li class="nav-item"><a href="/semi-project/loginform.jsp" class="nav-link " >로그인</a></li>
				<li class="nav-item"><a href="/semi-project/member/member-join.jsp" class="nav-link ">회원가입</a></li>
<%
	} else {
%>
				<li class="nav-item"><a href="/semi-project/logout.jsp" class="nav-link ">로그아웃</a></li>
<%
	}
%>
			</ul>
		</div>
	</div>
</nav>
<nav class="navbar navbar-expand-lg navbar-light bg-middle">
	<div class="container">
		<div class="collapse navbar-collapse row" id="navbar-1">
			<div class="col">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="navbar-brand" href="/semi-project/main.jsp">
					      <img src="/semi-project/resources/images/logo.png" alt="" class="d-inline-block align-text-top">
					    </a>
					</li>
				</ul>
			</div>
			<div class="col search-box">
				<form>
	     		 	<input class="form-control" type="search" placeholder="아디다스 오젤리아" aria-label="Search">
	      			<button class="btn btn-outline-success btn-sm" type="submit"></button>
	    		</form>				
			</div>
			<div class="col">
				<ul class="navbar-nav util-list">
					<li class="nav-item">
<%
	if(loginUserInfo == null) {		
%>
						<a href="#" onclick="javascript=alert('로그인이 필요한 페이지입니다.'); location.href='/semi-project/member/member-join.jsp';" class="nav-link util-mypage" ></a>
<%
	} else {
%>
						<a href="/semi-project/mypage/main.jsp?memberNo=<%=loginUserInfo.getNo() %>" class="nav-link util-mypage" ></a>
<%
	}
%>
					</li>
					<li class="nav-item">
 <%
	if(loginUserInfo == null) {		
%>
						<a href="#" onclick="javascript=alert('로그인이 필요한 페이지입니다.'); location.href='/semi-project/member/member-join.jsp';" class="nav-link util-cart" ></a>
<%
	} else {
%>
						<a href="/semi-project/mypage/cart.jsp?memberNo=<%=loginUserInfo.getNo() %>" class="nav-link util-cart" ></a>
<%
	}
%>
					</li>
				</ul>
			</div>
		</div>
	</div>
</nav>
<nav class="navbar navbar-expand-lg navbar-ligth bg-bottom">
	<div class="container">
		<div class="collapse navbar-collapse" id="navbar-1">
			<ul class="navbar-nav">
				<li class="nav-item"><a href="/semi-project/brand.jsp" class="nav-link active" >BRAND</a></li>
				<li class="nav-item"><a href="/semi-project/list.jsp?category=SNEAKERS" class="nav-link " >SNEAKERS</a></li>
				<li class="nav-item"><a href="/semi-project/list.jsp?category=SPORTS" class="nav-link ">SPORTS</a></li>
				<li class="nav-item"><a href="/semi-project/list.jsp?category=SANDALS" class="nav-link ">SANDALS</a></li>
				<li class="nav-item"><a href="/semi-project/list.jsp?category=LOAFERS" class="nav-link ">LOAFERS</a></li>
				<li class="nav-item"><a href="/semi-project/sale.jsp" class="nav-link ">SALE</a></li>
			</ul>
		</div>
	</div>
</nav>