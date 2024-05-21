package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.UserVo;

public class CartDao {
	
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			String url = "jdbc:mariadb://192.168.0.201:3306/bookmall?charset=utf8";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		}
		return conn;
	}
	
	
	// 카트 삽입 
	public int insert(CartVo vo) {
		int result = 0;
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into cart(user_no, book_no, quantity) values(?, ?, ?)");
			) {
			    pstmt1.setLong(1, vo.getUserNo());
			    pstmt1.setLong(2,vo.getBookNo());
			    pstmt1.setInt(3, vo.getQuantity());
				result = pstmt1.executeUpdate();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			return result;
	}
	
	
	// userNo 를 기반으로 카트 리스트 조회하기 
	
	public List<CartVo> findByUserNo(Long userNo) {
	    List<CartVo> result = new ArrayList<>();
	    try (
	        Connection conn = getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(
	        		 "SELECT a.user_no, a.book_no, a.quantity, b.title " + 
	        	                "FROM cart a JOIN book b ON a.book_no = b.no " + 
	        	                "WHERE a.user_no = ?"
	        );
	    ) {
	        pstmt.setLong(1, userNo);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Long user_no = rs.getLong(1);
	            Long book_no = rs.getLong(2);
	            int quantity = rs.getInt(3);
	            String title = rs.getString(4);
	            CartVo cart = new CartVo();
	            cart.setUserNo(user_no);
	            cart.setBookNo(book_no);
	            cart.setQuantity(quantity);
	            cart.setBookTitle(title);
	            result.add(cart);
	        }
	        rs.close(); 
	    } catch (SQLException e) {
	        System.out.println("error : " + e);
	    }
	    return result;
	}
	
	
	// userNo 와 bookNo 로 카트 삭제하기 
	 public int deleteByUserNoAndBookNo(Long userNo, Long bookNo) {
		  int result = 0;
		  try ( 
				  Connection conn = getConnection();
				  PreparedStatement pstmt = conn.prepareStatement("delete from cart where user_no = ? and book_no = ?");
				  ) {
			  pstmt.setLong(1, userNo);
			  pstmt.setLong(2, bookNo);
			  result = pstmt.executeUpdate();
		  } catch(SQLException e) {
			  System.out.println("error : "+ e);
		  }
		  return result;
	 }
	 
	 
}
