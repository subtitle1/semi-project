package service;

import java.sql.SQLException;
import java.util.Date;

import dto.OrderDetailDto;
import vo.Order;

public class Service {
	
//	// 1. 주문취소하기
//	// 2. QNA 답달기
//	// 3. 리뷰 좋아요
//	
//	/**
//	 * 주문 취소하기
//	 * @param orderNo
//	 * @param cancelReason
//	 * @throws SQLException
//	 */
//	public void cancelOrder (int orderNo, String cancelReason) throws SQLException {
//		//todo 주문 취소시 재고 복구하기..
//		OrderDetailDto orderDetailDto = new OrderDetailDto();
//		OrderDao orderDao = OrderDao.getInstance();
//		Order order = orderDetailDto.selectOrderDetailByOrderNo(orderNo);
//		order.setStatus("주문취소");
//		order.setCancelStatus("Y");
//		order.setCancelReason(cancelReason);
//		order.setCanceledDate(new Date());
//		orderDao.updateOrder(order);
//	}
}
