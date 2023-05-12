package com.itwillbs.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDAO {
	
	// 공통변수 선언
	private Connection con = null;			// DB 연결정보 저장(관리)
	private PreparedStatement pstmt = null;	// SQL 작성, 실행
	private ResultSet rs = null;			// select결과 데이터 저장
	private String sql = "";				// SQL구문 저장
	
	// 디비연결에 대한 모든 처리 
	private Connection getCon() throws Exception {
		// 0 - 디비 연결정보 (context.xml)
		// 1 드라이버로드 2 디비연결
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/class7_230118_team1");
		con = ds.getConnection();
		System.out.println(" DAO : 디비 연결 성공(CP) ");
		System.out.println(" DAO : "+con);
		return con;
	}
	
	// DB 자원해제
	private void closeDB() {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//productWrite()
	public void productWrite(ProductDTO dto) {
		try {
			// 1.2 DB 연결
			getCon();
			// 3. SQL 작성 & pstmt 객체
			sql = "insert into product(title,model,content,price,product_image,grade,city,parts,method,charge,fee,user_id,reg_date) "
					+ " values (?,?,?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getModel());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getPrice());
			pstmt.setString(5, dto.getProduct_image());
			pstmt.setInt(6, dto.getGrade());
			pstmt.setString(7, dto.getCity());
			pstmt.setString(8, dto.getParts());
			pstmt.setInt(9, dto.getMethod());
			pstmt.setInt(10, dto.getCharge());
			pstmt.setInt(11, dto.getFee());
			pstmt.setString(12, dto.getUser_id());
			// 4. SQL 실행
			pstmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	//productWrite()
	
	//getProductList()
	public List<ProductDTO> getProductList() {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		try {
			con = getCon();
			sql = "select * from product";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductDTO product= new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
	            product.setTitle(rs.getString("title"));
	            product.setModel(rs.getString("model"));
	            product.setContent(rs.getString("content"));
	            product.setPrice(rs.getInt("price"));
	            product.setParts(rs.getString("parts"));
	            product.setProduct_image(rs.getString("product_image"));
	            product.setGrade(rs.getInt("grade"));
	            product.setCity(rs.getString("city"));
	            product.setMethod(rs.getInt("method"));
	            product.setCharge(rs.getInt("charge"));
	            product.setFee(rs.getInt("fee"));
	            product.setReg_date(rs.getDate("reg_date"));
	            product.setRead_count(rs.getInt("read_count"));
	            product.setLike_count(rs.getInt("like_count"));
	            product.setChat_count(rs.getInt("chat_count"));
	            product.setUser_id(rs.getString("user_id"));
				productList.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return productList;
	}
	//getProductList()
	
	//productContent()
	public ProductDTO productContent(int product_id) {
	    ProductDTO product = new ProductDTO();
	    try {
	        con = getCon();
	        sql = "select * from product where product_id=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, product_id);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
	            product.setTitle(rs.getString("title"));
	            product.setModel(rs.getString("model"));
	            product.setContent(rs.getString("content"));
	            product.setPrice(rs.getInt("price"));
	            product.setParts(rs.getString("parts"));
	            product.setProduct_image(rs.getString("product_image"));
	            product.setGrade(rs.getInt("grade"));
	            product.setCity(rs.getString("city"));
	            product.setMethod(rs.getInt("method"));
	            product.setCharge(rs.getInt("charge"));
	            product.setFee(rs.getInt("fee"));
	            product.setReg_date(rs.getDate("reg_date"));
	            product.setUser_id(rs.getString("user_id"));
	        }
	        
	        System.out.println(" DAO : 상품정보 저장완료! ");
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        closeDB();
	    }
	    return product;
	}//productContent()

	//productUpdate()
	public int productUpdate(ProductDTO dto) {
	    int result = -1; // -1 0 1
	    try {
	    	 System.out.println(dto.getProduct_id());
	        //1.2 DB 연결
	        getCon();
	        String sql = "select * from product where product_id=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, dto.getProduct_id());
	        // 4. SQL 실행(select)
	        rs = pstmt.executeQuery();
	        System.out.println(dto.getProduct_id());
	           
	        // 5. 데이터 처리
	        if (rs.next()) {
	            // 상품번호 동일 //수정중
	            // 3. sql작성 (update) & pstmt 객체
	            // 상품명, 가격, 수량 수정
	        	
	            sql = "update product set title=?, model=?, parts=?, product_image=?, content=?, "
	                    + " price=?,grade=?,city=?, method=?, charge=?, fee=?, "
	                    + " user_id=?, reg_date=now() where product_id=?";

	            pstmt = con.prepareStatement(sql);

	            pstmt.setString(1, dto.getTitle());
	            pstmt.setString(2, dto.getModel());
	            pstmt.setString(3, dto.getParts());
	            pstmt.setString(4, dto.getProduct_image());
	            pstmt.setString(5, dto.getContent());
	            pstmt.setInt(6, dto.getPrice());
	            pstmt.setInt(7, dto.getGrade());
	            pstmt.setString(8, dto.getCity());
	            pstmt.setInt(9, dto.getMethod());
	            pstmt.setInt(10, dto.getCharge());
	            pstmt.setInt(11, dto.getFee());
	            pstmt.setString(12, dto.getUser_id());
	            pstmt.setInt(13, dto.getProduct_id());
	            System.out.println(" P : " + dto);
	            // 4. SQL 실행(update)
	            result = pstmt.executeUpdate();
	            System.out.println("DAO : 상품 정보 수정 완료 (" + result + ")");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // 5. DB 연결 해제
	        closeDB();
	    }

	    return result;
	}
	//productUpdate()
	
	// productDelete()
	public int productDelete(int product_id) {
	    int result = -1; // 0: 상품 정보 없음, 1: 상품 삭제 성공
	    
	    try {
	        // 1.2 DB 연결
	        getCon();
	        
	        // 3. SQL 작성 (delete) & pstmt 객체
	        sql = "delete from product where product_id=?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, product_id);
	        
	        // 4. SQL 실행(delete)
	        result = pstmt.executeUpdate();
	        
	        if (result == 0) {
	            System.out.println("DAO : 해당 상품 정보가 존재하지 않습니다.");
	        } else {
	            System.out.println("DAO : 상품 정보 삭제 완료 (" + result + ")");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        // 5. DB 연결 해제
	        closeDB();
	    }
	    
	    return result;
	}
	// productDelete()
	
	// updateReadcount()	
	public void updateReadcount(int product_id) {
		try {
			// 1.2.  디비연결
			con = getCon();
			// 3. sql(update) & pstmt 객체
			// 특정 글의 조회수 기존값 보다 1증가
			sql = "update product set read_count=read_count+1 "
					+ " where product_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product_id);

			// 4. sql 실행
			int cnt = pstmt.executeUpdate();

			if(cnt == 1) {
				System.out.println(" DAO : 글 조회수 1증가 완료!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}	
	// updateReadcount()	
	
}