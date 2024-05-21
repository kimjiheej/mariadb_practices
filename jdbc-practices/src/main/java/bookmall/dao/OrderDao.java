package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;
import bookmall.vo.UserVo;

public class OrderDao {
	
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
	
	
	// insert 
	// 주문 삽입하기 
	public int insert(OrderVo vo) {
		int result = 0;
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into orders(orderNum, totalPrice, shipment, status, user_no) values(?, ?, ?, ?,?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
			) {
			    pstmt1.setString(1, vo.getNumber());
			    pstmt1.setInt(2, vo.getPayment());
			    pstmt1.setString(3,vo.getShipping());
			    pstmt1.setString(4, vo.getStatus());
			    pstmt1.setLong(5, vo.getUserNo());
				result = pstmt1.executeUpdate();
				ResultSet rs = pstmt2.executeQuery();
				vo.setNo(rs.next() ? rs.getLong(1) : null);
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			return result;
	}
	
	
	
	
	// insertBook 
	// 주문된 책 삽입하기 
	public int insertBook(OrderBookVo vo) {
                 int result = 0;
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into orders_book(order_no, book_no, quantity, price) values(?, ?, ?, ?)");
			) {
			    pstmt1.setLong(1, vo.getOrderNo());
			    pstmt1.setLong(2, vo.getBookNo());
			    pstmt1.setInt(3,vo.getQuantity());
			    pstmt1.setInt(4, vo.getPrice());
				result = pstmt1.executeUpdate();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			return result;
	}
	
	
	
	// deleteBooksByNo
	
	
	// no 를 바탕으로 책 삭제하기 
	 public int deleteBooksByNo(Long no) {
	        int result = 0;
	        try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from orders_book where order_no = ?");
	        ) {
	            pstmt.setLong(1, no);
	            result = pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	        return result;
	    }
	    
	
	
	
	// no 를 바탕으로 주문 삭제하기 
	 public int deleteByNo(Long no) {
	        int result = 0;
	        try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from orders where no = ?");
	        ) {
	            pstmt.setLong(1, no);
	            result = pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	        return result;
	    }
	    
	    
  
	
	
	
	// findByNoAndUserNo
    // 주문 번호과 유저 넘버로 주문 찾기 
	public OrderVo findByNoAndUserNo(Long order_no, Long user_no) {
		OrderVo result = null; 
		try ( 
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("select no, orderNum, totalPrice, shipment, status, user_no from orders where no = ? and user_no = ? ");
				) {
			pstmt1.setLong(1, order_no);
			pstmt1.setLong(2, user_no);
			ResultSet rs = pstmt1.executeQuery();
			while(rs.next()) {
				Long no = rs.getLong(1);
				String orderNum = rs.getString(2);
				int totalPrice = rs.getInt(3);
				String shipment = rs.getString(4);
				String status = rs.getString(5);
				Long userNo = rs.getLong(6);
				OrderVo vo = new OrderVo();
				vo.setNo(no);
				vo.setNumber(orderNum);
				vo.setStatus(status);
				vo.setPayment(totalPrice);
				vo.setShipping(shipment);
				vo.setUserNo(userNo);
				result = vo;
			}
		} catch(SQLException e) {
			System.out.println("error : "+ e);
		}
		return result;
	}
	
	
	
	// findBooksByNoAndUserNo 
    // orderNo 와 userNo 로 주문된 책 리스트 찾기 
	public List<OrderBookVo> findBooksByNoAndUserNo(Long orderNo, Long userNo) {
	    List<OrderBookVo> result = new ArrayList<>();
	    try (
	    	    Connection conn = getConnection();
	    	    PreparedStatement pstmt = conn.prepareStatement(
	    	    	     "SELECT " +
	    	    	    	        "    a.order_no, " +
	    	    	    	        "    a.book_no, " +
	    	    	    	        "    c.title, " +
	    	    	    	        "    a.quantity, " +
	    	    	    	        "    a.price " +
	    	    	    	        "FROM " +
	    	    	    	        "    orders_book a " +
	    	    	    	        "JOIN " +
	    	    	    	        "    orders b ON a.order_no = b.no " +
	    	    	    	        "JOIN " +
	    	    	    	        "    book c ON a.book_no = c.no " +
	    	    	    	        "WHERE " +
	    	    	    	        "    b.no = ? AND b.user_no = ?;"
	    	    )
	    	)  { 
	        pstmt.setLong(1, orderNo);
	        pstmt.setLong(2, userNo);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Long orderno = rs.getLong(1);
	            Long bookno = rs.getLong(2);
	            String title = rs.getString(3);
	            int quantity = rs.getInt(4);
	            int price = rs.getInt(5);
	            OrderBookVo vo = new OrderBookVo();
	            vo.setOrderNo(orderno);
	            vo.setBookNo(bookno);
	            vo.setBookTitle(title);
	            vo.setQuantity(quantity);
	            vo.setPrice(price);
	            result.add(vo);
	        }
	    } catch (SQLException e) {
	        System.out.println("error : " + e);
	    }
	    return result;
	}
	
	
	
	

    
}