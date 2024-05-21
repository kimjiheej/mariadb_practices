package bookmall.vo;

public class CategoryVo {

	private Long no;
	private String category_name;
	
	  public CategoryVo() {
	    }
	  
	
	public CategoryVo(String category_name) {
		this.category_name = category_name;
	}
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	@Override
	public String toString() {
		return "CategoryVo [no=" + no + ", category_name=" + category_name + "]";
	}
	
	
}
