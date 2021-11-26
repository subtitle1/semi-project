package vo;

public class OrderItem {

	private int orderNo;
	private int stockNo;
	private int amount;
	
	public OrderItem() {}

	
	public int getOrderNo() {
		return orderNo;
	}


	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}


	public int getStockNo() {
		return stockNo;
	}


	public void setStockNo(int stockNo) {
		this.stockNo = stockNo;
	}


	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}
