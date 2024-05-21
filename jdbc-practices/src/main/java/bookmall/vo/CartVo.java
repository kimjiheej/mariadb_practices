package bookmall.vo;

public class CartVo {
	
	
	private Long userNo;
	private Long bookNo;
	private int quantity;
	private String bookTitle;
	
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	@Override
	public String toString() {
		return "CartVo [userNo=" + userNo + ", bookNo=" + bookNo + ", quantity=" + quantity + ", bookTitle=" + bookTitle
				+ "]";
	}
	
	
	
}
