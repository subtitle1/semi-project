<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link rel="stylesheet" href="resources/css/style.css" />
   <link rel="stylesheet" href="resources/css/style2.css" />
   <link rel="stylesheet" href="resources/css/default.css" />
    <title></title>
</head>
<body data-spy='scroll' data-target='.navbar' data-offset='50'>
<%@ include file = "common/navbar.jsp" %>
<div class="container">    
		
	<div class="product_view mt-5 mb-5">
		<h2>그립샷</h2>
	
		<table style="border-top: 2px solid #000">

			<tbody>
			<tr>
				<th>판매가</th>
				<td class="price">129,000</td>
			</tr>
			<tr>
				<th>상품코드</th>
				<td>C004843</td>
			</tr>
			<tr>
				<th>브랜드</th>
				<td>아디다스</td>
			</tr>
			<tr>
				<th>구매수량</th>
				<td>
					<div class="length">
						<input id="count" type="number" min="1" value="1" >
						<a href="#a" onclick="plus()">증가</a>
						<a href="#a" onclick="minus()">감소</a>
					</div>
				</td>
			</tr>
			<tr>
				<th>사이즈</th>
				<td>
					<select>
						<option value=210 >210</option>
						<option value=220 >220</option>
						<option value=230 >230</option>
						<option value=240 >240</option>
						<option value=250 >250</option>
						<option value=260 >260</option>
						<option value=270 >270</option>
						<option value=280 >280</option>
						<option value=290 >290</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>결제금액</th>
				<td class="total"><b>129,000</b>원</td>
			</tr>
			</tbody>
		</table>
		<div class="img">
			<img src="resources/images/운동화_아키클래식_1.jpg" alt="">
		</div>
		<div class="btns ">
			<a href="#a" class="btn1">장바구니</a>
			<a href="#a" class="btn2">구매하기</a>
		</div>
	</div>
	<hr>
	<nav class="navbar justify-content-center">
		<ul class="nav nav-tabs">
		  <li class="nav-item">
		    <a class="nav-link active" aria-current="page" href="#content1">리뷰</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="content2">문의/QNA</a>
		  </li>
		</ul>				
	</nav>
	
	
</div>

<%@ include file ="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function plus() {
		var count = document.getElementById('count').value;
		count++;
		document.getElementById('count').value = count;
	}
	
	
	
	function minus() {
		var count = document.getElementById('count').value;
		if(count > 1) {
			count--;
		} else {
			count;
		}
		document.getElementById('count').value = count;
	}
</script>
</body>
</html>

