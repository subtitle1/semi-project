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
   <title></title>
</head>
<style>
.img1{height:285px; width:285px;}
h1 {font-family:'Montserrat', Noto Sans KR; font-weight:550; font-size:30px color:black; }
a{text-decoration:none; color:black;}
</style>
<body>
<%@ include file="common/navbar.jsp" %>
<div class="container"> 

<%
ProductDao productDao = ProductDao.getInstance();

List<Product> saleProductList = productDao.selectProductsOnSale(1, 3);
List<Product> newProductList = productDao.selectAllProducts(1, 8);

%>

	<!-- 
		세일상품목록
		3개만 출력.
	 -->   
	<div class="row mb-5 mt-5">
		<div class="col-3">
			<h1 class="mb-3">HOT DEAL</h1>
			<div>기간한정 특가할인!</div>				
			<div  class="mb-3" >지금 특별한 가격을 만나보세요!</div>
			<a href="" class="mt-5"><ins><strong>more</strong></ins></a>				
		</div>
<%
	for(Product product : saleProductList){
%>
		<div class="col-3">
			<a href="detail.jsp">
				<img src="resources/images/products/<%=product.getPhoto() %>" class="img1" alt="">
				<div class="row mt-3 mb-3 p-2">
					<div class="col">
						<h5><strong><%=product.getBrand() %></strong></h5>
						<span class="mb-5"><%=product.getName() %></span>
						  <div class="mt-3">
					        <span class="col card-text p-2 p"><%=product.getPrice() %> 원</span>
					        <span class="col card-text  p-2 dp"><%=product.getDisPrice() %> 원</span>
		    		   	  </div>
					 </div>
				</div>
			</a>
		</div>
<%
	}
%>	
	</div>
	<!-- 
		신상품순 상품목록
		
	 -->
	<div class="row p-5 mt-5 mb-5 text-center">
		<h1>NEW ARRIVALS</h1>
		<div class="text-end" ><a href=""><ins><strong>more</strong></ins></a></div>	
	</div>
     <div class="row mb-5 mt-5" style="margin: 0 20px 0px">
<%
for(Product product : newProductList){
%>	
		<div class="col-3">
			<a href="detail.jsp">
			<img src="resources/images/products/<%=product.getPhoto()%>" class="img1" alt="">
			<div class="row mt-1 mb-1 p-1">
				<div class="col">
					<h5>
						<strong><%=product.getBrand()%></strong>
					</h5>
					<span class="mb-5"><%=product.getName()%></span>
					<div class="mt-3">
						<span class="col card-text p-2 p"><%=product.getPrice()%>
							원</span> <span class="col card-text  p-2 dp"><%=product.getDisPrice()%>
							원</span>
					</div>
				</div>
			</div>
			</a>
		</div>

<%
}
%>
	</div>
</div>
<%@ include file ="common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>