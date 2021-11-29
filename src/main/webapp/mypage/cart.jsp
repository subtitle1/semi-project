<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="dto.CartDetailDto"%>
<%@page import="vo.Cart"%>
<%@page import="dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="../resources/css/style.css" />
   <title></title>
</head>
<style>
	.cart-table{margin-top:20px; width:100%; overflow-x:scroll;}
	.cart-table:first-child{margin-top:50px;}
	.cart-table tr th{background:#f0f0f0; border-top:2px solid #000; border-bottom:1px solid #d5d5d5;}
	.cart-table tr th p{margin:0; font-family:"Montserrat","Noto Sans KR",sans-serif; font-weight:500; font-size:15px;}
	.cart-table tbody{border-top:none !important;}
	.cart-table tr th, .cart-table tr td{vertical-align:middle; height:48px; padding:0 20px;}
	.cart-table tr td{padding:20px 20px 15px;}
	.cart-table .product-stock{position:relative;}
	.cart-table .product-stock span::before{position:absolute; display:block; content:''; width:24px; height:24px; border:1px solid #d5d5d5; color:#d5d5d5; cursor:pointer;}
	.cart-table .product-stock span.minus::before{background:url(../resources/images/ico_down.png) no-repeat center center; top:1px; left:-24px;}
	.cart-table .product-stock span.plus::before{background:url(../resources/images/ico_up.png) no-repeat center center; top:1px; right:17px;}
	.cart-table .product-stock input{width:29px; height:24px; margin:0; padding:0; border:none; border-top: 1px solid #d5d5d5; border-bottom: 1px solid #d5d5d5; text-align:center;}
	/* Chrome, Safari, Edge, Opera */
	input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {-webkit-appearance: none; margin: 0;}
	.cart-table .td-img img{width:100px; height:100px;}
	.cart-table .sidebar{display:inline-block;}
	.cart-table .sidebar::before{display:inline-block; content:""; width:1px; height:7px; margin:9px 9px 0 7px; background:#999; vertical-align:top;}	
	.cart-table .num{font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:17px; font-weight:600; color:#ee1c25;}
	.cart-table .text-product-name{font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:14px; color:#000;}
	.cart-table .text-size{font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:13px; color:#666;}
	.cart-table .text-price-line-through{font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:13px; color:#999; text-decoration:line-through;}
	.cart-table .text-price{font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:18px;}
	.cart-table .text-disprice{font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:18px; color:#EE1C25;}
	.cart-table .unit{font-size:14px;}
	.cart-table .btn{min-width: 110px; height:38px; border-radius:0; font-family:"Montserrat","Noto Sans KR",sans-serif; font-size:13px; text-align:center;}
	.cart-table .btn-light{margin-top:10px; border:1px solid #000;}
</style>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">
<%
	// 클라이언트 전용의 세션객체에서 사용자정보 조회
	Member member = (Member)session.getAttribute("LOGIN_USER_INFO");
	// 클라이언트 전용의 세션객체에서 사용자 정보가 조회되지 않으면 로그인하지 않은 사용자임
	// 로그인폼 페이지를 재요청하는 URL을 응답으로 보낸다.
	if (member == null) {
		String encodedText = URLEncoder.encode("장바구니담기", "utf-8");
		response.sendRedirect("../loginform.jsp?fail=deny&job=" + encodedText);
		return;
	}
	// 조회된 사용자정보에서 사용자 아이디 조회
	int memberNo = member.getNo();
	
	CartDao cartDao = CartDao.getInstance();
	
	List<CartDetailDto> cartList = cartDao.selectCartList(memberNo);
	
	//response.sendRedirect("cartform.jsp?no=" + no);
	
%>
	<div class="row">
		<div class="col">
			<form action="order.jsp">
<%
	for (CartDetailDto cart : cartList) {
%>
				<table class="table cart-table">
					<colgroup>
						<col width="110px" />
						<col />
						<col width="110px" />
						<col width="150px" />
						<col width="150px" />
					</colgroup>
					<thead>
						<tr>
							<th colspan="5">
								<p><%=cart.getProductBrand() %> 배송 상품 <span class="sidebar"><span class="num"><%=cart.getAmount() %></span> <span class="unit">개</span></span></p>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="td-img"><img src="../resources/images/products/<%=cart.getProductImg() %>" alt="" /></td>
							<td>
								<span class="text-product-name"><%=cart.getProductName() %></span><br>
								<span class="text-size"><%=cart.getProductSize() %></span>
							</td>
							<td>
								<div class="product-stock">
									<span class="minus" onclick="minus()"></span>
									<input type="number" id="count" value="<%=cart.getProductStock() %>" min="1" max="20" />
									<span class="plus" onclick="plus()"></span>
								</div>
							</td>
							<td class="text-end">
	<%
		if (cart.getProductDisprice() > 0) {
			
	%>							
								<span class="text-price-line-through"><%=cart.getProductPrice() %> 원</span><br>
								<span class="text-disprice fw-bolder"><%=cart.getProductDisprice() %></span> <span class="unit">원</span>
	<%
		} else {
	%>
								<span class="text-price fw-bolder"><%=cart.getProductPrice() %></span>  <span class="unit">원</span>
	<%
		}
	%>
							</td>
							<td>
								<button class="btn btn-dark" type="submit">바로구매</button><br>
								<button class="btn btn-light" type="button">삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
<%
	}
%>			
			</form>
		</div>
	</div>
</div>
<%@ include file ="../common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function plus() {
		var count = Number(document.querySelector('#count').value);
		if(count < 20) {
		count ++;
		}
		document.querySelector('#count').value = count;
	}
	
	function minus() {
		var count = document.querySelector('#count').value;
		if(count > 1) {
			count--;
		} else {
			count;
		}
		document.querySelector('#count').value = count;
	}
</script>
</body>
</html>