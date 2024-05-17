package emaillist.dao;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import emaillist.vo.EmaillistVo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class EmailListDaoTest {

	
	@Test
	@Order(1)
	public void testInsert() {
		
		EmaillistVo vo = new EmaillistVo();
		vo.setFirstName("둘");
		vo.setLastName("리");
		vo.setEmail("dooly@gmail.com");
		
		boolean result = new EmaillistDao().insert(vo);
		
		assertTrue(result); // 성공 조건을 단언을 해줘야 한다 

	}
	
	
	@Test
	@Order(2)
    public void testDeleteByEmail() {
    	
    	boolean result = new EmaillistDao().deleteByEmail("dooly@gmail.com");
        assertTrue(result);
    }
	
	@Test
	@Order(3)
    public void testFindAll() {
     List<EmaillistVo>  list = new EmaillistDao().findAll();
     assertEquals(1,list.size());
    }
	
	
}
