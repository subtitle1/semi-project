package dto;

/**
 * 주문 취소 시에 필요한 정보들을 모아놓은 Dto다
 * @author Mars
 *
 */
public class CancelProductDto {
	private int productNo;
	private String productName;
	private int price;
	private int disprice;
	private int amount;
	private int size;
	private int productDetailNo;
	private int stock;
	
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDisprice() {
		return disprice;
	}
	public void setDisprice(int disprice) {
		this.disprice = disprice;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public int getProductDetailNo() {
		return productDetailNo;
	}
	public void setProductDetailNo(int productDetailNo) {
		this.productDetailNo = productDetailNo;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	@Override
	public String toString() {
		return "CancelProductDto [productNo=" + productNo + ", productName=" + productName + ", price=" + price
				+ ", disprice=" + disprice + ", amount=" + amount + ", size=" + size + ", productDetailNo="
				+ productDetailNo + ", stock=" + stock + "]";
	}
}
