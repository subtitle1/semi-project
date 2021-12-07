<%@page import="vo.Criteria2"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
<%@page import="vo.Pagination2"%>
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

	// 요청파라미터에 pageNo값이 존재하지 않으면 Pagination객체에서 1페이지로 설정한다.
	int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
	String option = StringUtils.defaultString(request.getParameter("option"), "");
	String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");
	
	Criteria2 criteria = new Criteria2();
	
	// 검색옵션과 검색키워드가 모두 있는 경우에만 Criteria객체에 검색옵션과 검색 키워드를 저장한다.
    if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(keyword)) {
      	criteria.setOption(option);
      	criteria.setKeyword(keyword);
    }
	
	
 // 검색조건에 맞는 게시글의 총 갯수를 조회한다.
    int totalRows = productDao.getTotalProductDetailRows(criteria);
    // 페이징처리에 필요한 정보를 제공하는 Pagination객체를 생성한다.
    Pagination2 pagination = new Pagination2(pageNo, totalRows);
    
    // 게시글 리스틀 조회할 때 필요한 조회범위를 Criteria객체에 저장한다.
    criteria.setBeginIndex(pagination.getBeginIndex());
    criteria.setEndIndex(pagination.getEndIndex());
	
    
	// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
List<ProductDetailDto> productDetailList = productDao.selectAllProductDetail(criteria);
%>


<div class="container">    
<div class="row">
		<div class="col breadc1">
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
				<li class=""><a href="stock-management.jsp?pgno=1" class="nav-link p-0">재고 관리</a></li>
				<li class=""><a href="order-list.jsp" class="nav-link p-0">주문 관리</a></li>
				<li class=""><a href="qna-list.jsp" class="nav-link p-0">QnA 목록</a></li>
				<li class=""><a href="review-list.jsp" class="nav-link p-0">리뷰 목록</a></li>	</ul>
		</div>	
		<div class="col-9">
		<div class="row mb-3">
			<div class="col-2"><h4>재고 관리</h4></div>
			<div>
				<!--  
					페이징처리와 검색에 필요한 값을 서버로 제출할 때 사용하는 폼이다.
					페이지번호를 클릭하거나 검색버튼을 클릭하면 폼의 입력요소에 적절한 값을 설정하고, 폼 입력값을 제출한다.
					
					검색옵션과 검색어가 존재하면 해당 해당 옵션이 선택되고, 검색어가 입력필드에 표시된다.
				-->
				<form id="form-search" class="row" method="get" action="stock-management.jsp">
					<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
					<div class="col-4" style="height: 31px; line-height: 31px;">
						총 <strong><%=totalRows %></strong> 개의 상품이 있습니다.
					</div>
					<div class="col-2 offset-2">
						<div class="input-group">
							<select class="form-select" id="search-option" name="option"
								style="height: 31px; font-size: 14px;">
								<option value="name" <%="name".equals(option) ? "selected" : "" %>>상품이름</option>
								<option value="brand" <%="brand".equals(option) ? "selected" : "" %>>브랜드</option>
								<option value="category" <%="category".equals(option) ? "selected" : "" %>>카테고리</option>
							</select>
						</div>
					</div>
					<div class="col-3">
						<div class="input-group">
							<input type="text" class="form-control" id="search-keyword" name="keyword" value="<%=StringUtils.isBlank(keyword) ? "" : keyword%>" placeholder="검색어를 입력하세요" 
							style="height: 31px; font-size: 14px;">
						</div>
					</div>
					<div class="col-1">
						<div class="input-group justify-content-end">
							<button class="btn btn-sm btn-outline-dark" type="button" id="btn-search" onclick="searchBoards(1)">검색</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<table class="table table-hover align-middle">
		<colgroup>
			<col width="12%">
			<col width="7%">
			<col width="12%">
			<col width="12%">
			<col width="12%">
			<col width="10%">
			<col width="25%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>이미지</th>
				<th>번호</th>
				<th>이름</th>
				<th>브랜드</th>
				<th>카테고리</th>
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
				<td><img src = "/semi-project/resources/images/products/<%=productDetail.getPhoto() %> " width="50" height="50"></td>		
				<td><%=productDetail.getProductNo() %></td>		
				<td><a href="product-detail.jsp?no=<%=productDetail.getProductNo()%>"></a><%=productDetail.getName() %></td>
				<td><%=productDetail.getBrand() %></td>
				<td><%=productDetail.getCategory() %></td>
				<td><%=productDetail.getSize() %></td>
				<td>
        		 <div class="row">
           			 <div class="col">
              			 <button style="margin-right:10px; vertical-align:top;" class="btn btn-outline-danger btn-sm"
               						onclick="minus('stock-<%=productDetail.getProductStockNo()%>')">-10
               			 </button>
              		 	 <input style="width:50px; height:31px; text-align:center;" type="text" name="stock"
                					  id="stock-<%=productDetail.getProductStockNo()%>"
                					  value=<%=productDetail.getStock()%>>
             		  	 <button style="margin-left:10px; vertical-align:top;" class="btn btn-outline-danger btn-sm"
                 				 onclick="plus('stock-<%=productDetail.getProductStockNo()%>');">+10
                  	 	 </button>
            		</div>
            	</div>
 			    </td>
      			<td class="text-end p-0">
         			<button class="btn btn-sm" style="color:white; background-color: black;" 
         			onclick="save(<%=productDetail.getProductStockNo()%>)">저장</button>
     			</td>
			</tr>			
<% 
	}
%>			
		</tbody>
	</table>
	<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getPrev()%>)" >이전</a>
					</li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBegin(); num <= pagination.getEnd(); num++) {
%>					
						<li class="page-item <%=num == pagination.getPage() ? "active" : ""%>">
						<a href="" class="page-link" onclick="moveToPage(event, <%=num%>)"><%=num%></a>
					</li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
					<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getNext()%>)">다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
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
 
//페이지번호를 클릭했을 때 실행되는 함수
	function moveToPage(event, page) {
		event.preventDefault();	// a태그에서 onclick이벤트가 발생하면 href에 정의된 주소로 이동하는 기본동작이 일어나지 않게 함.
		searchBoards(page);
	}
	
	//검색버튼을 클릭했을 때 실행되는 함수
	function searchBoards(page) {
		document.getElementById("page-field").value = page;
		var form = document.getElementById("form-search");
		form.submit();
	}  
   
</script>
</body>
</html>