<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
  <link rel="stylesheet" href="resources/css/style.css" />
    <title></title>
</head>
<style>
.title {font-family:'Montserrat', Noto Sans KR; font-weight:500; color:black; font-size:50px; text-align:center; }
.nonestyle{text-decoration:none; color:black;}
.a{text-decoration:none; color:black;}
</style>
<body>
<%@ include file = "common/navbar.jsp" %>
	<div class="container">
		<div class="mb-5 p-2 ">
			<a class="nonestyle" href="main.jsp">HOME</a> <select
				class="border-0"
				onchange="if(this.value) location.href=(this.value);">
				<option value="main.jsp">BRAND</option>
				<option value="main.jsp">SNEAKERS</option>
				<option value="main.jsp">SPORTS</option>
				<option value="main.jsp">SANDALS</option>
				<option value="main.jsp">LOAFERS</option>
			</select>
		</div>
		<div class="title mb-5 p-3">BRAND</div>
		<nav class="navbar navbar-expand-lg navbar-ligth ">
			<div class="container">
				<div class="collapse navbar-collapse " id="navbar-1">
					<ul class="navbar-nav" style="width:100%">
						<li class="nav-item me-auto">총 <strong>product_stock</strong>개의
							상품이 있습니다.
						</li>
						<li class="nav-item text-end"><select class=" border-0">
								<option>브랜드 전체</option>
								<option>아디다스</option>
								<option>퓨마</option>
								<option>휠라</option>
						</select> <select class="border-0">
								<option>남녀공용</option>
								<option>남자</option>
								<option>여자</option>
						</select> <select class="border-0">
								<option>신상품순</option>
								<option>할인상품</option>
								<option>낮은가격순</option>
								<option>높은가격순</option>
								<option>베스트상품순</option>
						</select></li>
					</ul>
				</div>
			</div>
		</nav>
		<hr>
		<div class="row row-cols-4 g-3 mx-auto">
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>
			<div class="col">
				<a href="" class="a">
					<div class="card h-100 border-white">
						<img src="resources/images/운동화_아키클래식_1.jpg" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h6 class="card-title">
								<strong>product_brand</strong>
							</h6>
							<p class="card-text">product_name</p>
							<h5 class="card-text">
								<strong>price</strong> 원
							</h5>
							<h5 class="card-text">
								<strong>discountprice</strong> 원
							</h5>
						</div>
					</div>
				</a>
			</div>

		</div>
<%@ include file="common/footer.jsp" %>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>