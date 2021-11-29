package service;

public class OrderService {

//	detail.jsp에서 바로 구매하기 버튼을 눌렀을 때 purchase.jsp로 이동
//
//	purchase.jsp?productNo=
//	&amount=
//	&size=
//
//	-----------------------------------------------------------
//	purchase.jsp
//
//	int memberNo = loginUserInfo.getNo();
//	int productNo = Integer.parseInt(request.getParameter("productNo"));
//	int amount = Integer.parseInt(request.getParameter("amount"));
//	int size = Integer.parseInt(request.getParameter("size")); // 230
//
	//service 페이지에서
//	productNo랑 size로 stockNo를 구함(=productDetailNo)
//	orderNewItemThroughDetailPage(orderItem, memberNo);
//
//	
//	 1. 주문번호 얻어서 orderNo에 저장
//	   int orderNo = OrderDao.getOrderNo();
//	
//	 2. size, amount, orderNo까지 해서 orderItem 객체는 완성된 상태
//		OrderItem orderItem = new OrderItem();
//		orderItem.setStockNo(size);
//		orderItem.setAmount(amount);
//    	orderItem.setOrderNo(orderNo);
//
//	  3.public Order orderNewItemThroughDetailPage(OrderItem orderItem, int productNo, int memberNo) {
//	
//	   Order order = new Order();
//
//	   4. 멤버정보, 상품정보 얻어오기
//	   Member member = MemberDao.selectMemberByMemberNo(memberNo);
//	   Product product = ProductDao.selectProductByNo(productNo);
////  
//	
//		int price = product.getPrice();
//		if (product.getDisPrice() != 0) {
//			price = product.getDisPrice();
//		}
//	   5. 총 주문가격 계산
//	   int totalPrice = orderItem.getAmount() * product.getDisPrice();
//
//	   5. order 객체 채우기
//	   order.setNo(orderNo);
//	   order.setMember(member);
//	   order.setTotalPrice(totalPrice);
//		insert(order, order item)	
//
//	   6. 재고 조정하기
//		stock 객체 만든 뒤 update
//
//		7. 포인트
// int point = member.getPct+ price*0.01
// member.setPct(point);
	
	
}
