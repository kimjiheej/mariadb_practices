package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class InsertEx02 {
	
	public static void main(String[] args) {
		
	  DeptVo vo = new DeptVo();
	  vo.setNo(1L);
	  vo.setName("경영지원2");
	  
	  boolean result = update(vo);
	  System.out.println(result ? "성공" : "실패");
	}

	 public static boolean update(DeptVo vo) {
	        
		    boolean result = false;
		    
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        
	        // 1. JDBC Driver 로딩 
	        
	        try {
	        	
	        	//1. JDBC Driver 로딩 
	            Class.forName("org.mariadb.jdbc.Driver");
	            
	            //2. 연결하기 
	            String url = "jdbc:mariadb://192.168.0.201:3306/webdb?charset=utf8";
	            conn = DriverManager.getConnection(url, "webdb", "webdb");
	            
	            // 3. Statement 준비 
	            String sql = "update dept set name=? where no = ?";
	            pstmt = conn.prepareStatement(sql);
	            
	            // binding 
	            pstmt.setString(1, vo.getName());
	            pstmt.setLong(2, vo.getNo());
	            int count = pstmt.executeUpdate();
	                  
	            
	    
	        } catch(ClassNotFoundException e) {
	            System.out.println("드라이버 로딩 실패: " + e);
	        } catch (SQLException e) {
	            System.out.println("error: " + e);
	        } finally {
	            try {
	            	if(pstmt != null) {
	            		pstmt.close();
	            	}
	                if(conn != null) {
	                    conn.close();
	                }
	            } catch(SQLException e) {
	                System.out.println("error: " + e);
	            }
	        }
	        
	        return result;
	    }
}
