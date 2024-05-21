package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CategoryVo;
import bookmall.vo.UserVo;
import bookshop.vo.AuthorVo;

public class CategoryDao {
	
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
	
	public int insert(CategoryVo vo) {
		int result = 0;
		
		try (
				Connection conn = getConnection();
				PreparedStatement pstmt1 = conn.prepareStatement("insert into category(category_name) values(?)");
				PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
         	   
			) {
			    pstmt1.setString(1, vo.getCategory_name());
			    result = pstmt1.executeUpdate();
				ResultSet rs = pstmt2.executeQuery();
				vo.setNo(rs.next() ? rs.getLong(1) : null);
				
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
			
			return result;
	}
	
	// findAll 
	
	public List<CategoryVo> findAll() {
		List<CategoryVo> result = new ArrayList<>();
		
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement("select no, category_name from category");
			ResultSet rs = pstmt.executeQuery();
		) {
			while(rs.next()) {
				Long no = rs.getLong(1);
				String category_name = rs.getString(2);
				
				CategoryVo vo = new CategoryVo();
				vo.setNo(no);
				vo.setCategory_name(category_name);
				
				result.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("error:" + e);
		}
		
		return result;
	}
	
	
	
	// deleteByNo 
	
	 public int deleteByNo(Long no) {
	        int result = 0;
	        
	        try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from category where no = ?");
	        ) {
	            pstmt.setLong(1, no);

	            result = pstmt.executeUpdate();
	            
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	        return result;
	    }
	
	
}
