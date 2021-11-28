<%@page import="vo.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
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
<%
//요청파라미터에서 pageNo값을 조회한다.
	// 요청파라미터에 pageNo값이 존재하지 않으면 Pagination객체에서 1페이지로 설정한다.
//	String pageNo = request.getParameter("pageNo");

	// 제품 정보 관련 기능을 제공하는 ProductDao객체를 획득한다.
	
	int no = Integer.parseInt(request.getParameter("no"));
	
	ProductDao productDao = ProductDao.getInstance();
	StockDao stockDao = StockDao.getInstance();
	
	Product product = productDao.selectProductbyNo(no);
	List<Stock> stockList = stockDao.selectStocksbyProductNo(no);
	// 페이징 처리 필요한 값을 계산하는 Paginatition객체를 생성한다.
//	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
//	List<Board> boardList = boardDao.getBoardList(pagination.getBegin(), pagination.getEnd());
%>
		
	<div class="product_view mt-5 mb-5">
		<h2><%=product.getName() %></h2>
	
		<form method="post" action="">
			<table style="border-top: 2px solid #000">
				<tbody>
						<tr>
							<th>판매가</th>
							<td class="price"><%=product.getPrice() %></td>
						</tr>
						<tr>
							<th>상품코드</th>
							<td><%=product.getNo() %></td>
						</tr>
						<tr>
							<th>브랜드</th>
							<td><%=product.getBrand() %></td>
						</tr>
						<tr>
							<th>구매수량</th>
							<td>
								<div class="length">
									<input id="count" type="number" min="1" max="20" value="1" >
									<a href="#a" onclick="plus()">증가</a>
									<a href="#a" onclick="minus()">감소</a>
								</div>
							</td>
						</tr>
						<tr>
							<th>사이즈</th>
							<td>
								<select>
									<option value=230>230</option>
									<option value=240>240</option>
									<option value=250>250</option>
									<option value=260>260</option>
									<option value=270>270</option>
									<option value=230>280</option>
									<option value=230>290</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>결제금액</th>
							<td class="total"><b><%=product.getPrice() %></b>원</td>
						</tr>
				</tbody>
			</table>
				<div class="btns ">
					<a href="#a" class="btn1" type="submit">장바구니</a>
					<a href="#a" class="btn2" type="submit">구매하기</a>
				</div>
			</form>
			<div class="img">
				<img src="resources/images/products/<%=product.getPhoto()%>" alt="">
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
		if(count < 20) {
		count++;
		}
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

