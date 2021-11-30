<%@page import="dto.ProductDetailDto"%>
<%@page import="vo.Stock"%>
<%@page import="dao.StockDao"%>
<%@page import="vo.Product"%>
<%@page import="dao.ProductDao"%>
<%@page import="java.util.List"%>
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
ProductDao productDao = ProductDao.getInstance();
ProductDetailDto productDetailDto = new ProductDetailDto();
StockDao stockDao = StockDao.getInstance();
List<ProductDetailDto> productDetailList = productDao.selectAllProductDetail(1, 10);
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
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>	</ul>
		</div>	
		<div class="col-9">
		<h4>재고 관리</h4>
		<table class="table table-hover">
		<colgroup>
			<col width="15%">
			<col width="10%">
			<col width="20%">
			<col width="15%">
			<col width="25%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>이미지</th>
				<th>번호</th>
				<th>이름</th>
				<th>사이즈</th>
				<th>재고관리</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		
			<% 
	for (ProductDetailDto productDetail : productDetailList) {
%>	
			<tr>
				<td><img src = "/semi-project/resources/images/products/<%=productDetail.getPhoto() %> " width="60" height="60"></td>		
				<td><%=productDetail.getProductNo() %></td>		
				<td><a href="product-detail.jsp?no=<%=productDetail.getProductNo()%>"></a><%=productDetail.getName() %></td>
				<td><%=productDetail.getSize() %></td>
				<td>
        		 <div class="row">
           			 <div class="col">
              			 <button style="margin-right:10px; background-color:rgb(255, 71, 111); border:1px solid rgb(255, 71, 111);" class="btn btn-danger btn-sm"
               						onclick="minus('stock-<%=productDetail.getProductStockNo()%>')">-10
               			 </button>
              		 	 <input style="width:50px; text-align:center;" type="text" name="stock"
                					  id="stock-<%=productDetail.getProductStockNo()%>"
                					  value=<%=productDetail.getStock()%>>
             		  	 <button style="margin-left:10px; background-color:rgb(255, 71, 111); 
             		  	 border:1px solid rgb(255, 71, 111); " class="btn btn-danger btn-sm"
                 				 onclick="plus('stock-<%=productDetail.getProductStockNo()%>');">+10
                  	 	 </button>
            		</div>
            	</div>
 			    </td>
      			<td>
         			<button class="btn btn-sm" style="color:white; background-color: rgb(57, 209, 146);" 
         			onclick="save(<%=productDetail.getProductStockNo()%>)">저장</button>
     			</td>
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
<script>
function plus(id) {
    var count = Number(document.getElementById(id).value);
    if(count < 1000) {
        count+=10;
     }
    document.getElementById(id).value = count;
 }
 
function save(no) {
	var amount = Number(document.getElementById("stock-"+no).value);
	location.href="save.jsp?no=" + no + "&amount=" + amount;
}


 
 function minus(id) {
    var count = Number(document.getElementById(id).value);
    if(count > 10) {
  	  count-= 10;
    } else {
       count;
    }
    document.getElementById(id).value = count;
 }
   
</script>
</body>
</html>