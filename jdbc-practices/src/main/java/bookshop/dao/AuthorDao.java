package bookshop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookshop.vo.AuthorVo;

public class AuthorDao {
	
	private Connection getConnection() throws SQLException {
		 Connection conn = null;
		 
		//1. JDBC Driver 로딩
			try {
				Class.forName("org.mariadb.jdbc.Driver");
				
				String url = "jdbc:mariadb://192.168.0.201:3306/webdb?charset=utf8";
				conn = DriverManager.getConnection(url, "webdb", "webdb");
				
			} catch (ClassNotFoundException e) {
				System.out.println("드라이버 로딩 실패:" + e);
			}
			
			return conn;
	}

	public List<AuthorVo> finaAll() {

		List<AuthorVo> result = new ArrayList<>();
		
	
	

		
		try ( 
			Connection 	conn = getConnection();
				PreparedStatement pstmt =  conn.prepareStatement("select no, name from author");
				ResultSet rs = pstmt.executeQuery();
				) {
	
			//6. 결과 처리
			while(rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				
				AuthorVo vo = new AuthorVo();
				
				vo.setNo(no);
				vo.setName(name);
				
				result.add(vo);

			}
			rs.close();
		}  catch (SQLException e) {
			System.out.println("error:" + e);
		} 
		return result;
	}

	
}