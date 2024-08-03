package com.example.project.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.project.Model.ShopingMall;
import com.example.project.Model.ShopingMallUser;
import com.example.project.Model.ShopingMallProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import javax.sql.DataSource;

@Repository
public class ShopingMallDAO {



	private final DataSource dataSource;

	@Autowired
	public ShopingMallDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	// DB 연결을 가져오기 위한 메서드
	private Connection open() throws SQLException {
		return dataSource.getConnection();
	}




	
	// 게시글 목록 전체를 가지고 오기위한 메서드
	public List<ShopingMall> getAll(int offset, int limit) throws Exception {
		Connection conn = open();
		
		List<ShopingMall> ShopingList = new ArrayList<>();
		String sql = "SELECT aid, name, title, img, DATE_FORMAT(date, '%Y-%m-%d %H:%i:%s') as cdate, content "
				+ "FROM shopingmall "
				+ "ORDER BY date DESC "
				+ "LIMIT ? OFFSET ?"; // 게시글 목록 셀렉트 쿼리 문
		
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, limit);
		pstmt.setInt(2, offset);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			while(rs.next()) {
				ShopingMall s = new ShopingMall();
				s.setAid(rs.getInt("aid"));
				s.setName(rs.getString("name"));
				s.setTitle(rs.getString("title"));
				s.setImg(rs.getString("img"));
				s.setDate(rs.getString("cdate"));
				s.setContent(rs.getString("content"));
				
				ShopingList.add(s);
			}
			return ShopingList;
		}
	}
	// 게시글 총 개수 조회
	public int getTotalCount() throws SQLException {
		Connection conn = open();
		String sql = "SELECT COUNT(*) AS total FROM shopingmall";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		try(conn; pstmt; rs) {
			if(rs.next()) {
				return rs.getInt("total");
			} else {
				return 0;
			}
		}
	}
	
	// 쇼핑 품목 목록 전체를 가지고 오기위한 메서드
	public List<ShopingMallProduct> getAllproduct() throws Exception {
		Connection conn = open();
		
		List<ShopingMallProduct> ShopProductList = new ArrayList<>();
		String sql = "select aid, name, img, category, content, link from shopingproduct"; // 제품 목록 가져오는 셀렉트 쿼리 문
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		try (conn; pstmt; rs) {
			while(rs.next()) {
				ShopingMallProduct p = new ShopingMallProduct();
				p.setAid(rs.getInt("aid"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setCategory(rs.getString("category"));
				p.setContent(rs.getString("content"));
				p.setLink(rs.getString("link"));
				
				ShopProductList.add(p);
			}
			return ShopProductList;
		}
	}
	
	
	
	
	// 게시글 세부 내용 조회 : 게시글 클릭했을때
	public ShopingMall getShoping(int aid) throws SQLException {
		Connection conn = open();
		ShopingMall s = new ShopingMall();
		
		String sql = "select aid, name, title, img, DATE_FORMAT(date, '%Y-%m-%d %H:%i:%s') as cdate,";
		sql += " content from shopingmall where aid = ?"; // 게시글 세부 내용 셀렉트 쿼리 문
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, aid);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		try(conn; pstmt; rs) {
				s.setAid(rs.getInt("aid"));
				s.setName(rs.getString("name"));
				s.setTitle(rs.getString("title"));
				s.setImg(rs.getString("img"));
				s.setDate(rs.getString("cdate"));
				s.setContent(rs.getString("content"));
				
				
			
			return s;
		}
		
	}
	
	
	// 게시글 추가하는 메서드 / 인자로 DO 클래스인 Shopingmall 타입을 받아 sql 완성
	public void addShoping(ShopingMall s) throws Exception {
		Connection conn = open();
		
		String sql = "insert into shopingmall(name, title, img, date, content)";
		sql += " values(?, ?, ?, CURRENT_TIMESTAMP(), ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(conn; pstmt) {
			pstmt.setString(1, s.getName());
			pstmt.setString(2, s.getTitle());
			pstmt.setString(3, s.getImg());
			pstmt.setString(4, s.getContent());
			pstmt.executeUpdate();
		}finally {
			conn.close();
		}
	}

	// 쇼핑 품목 추가하는 메서드 
	public void addProduct(ShopingMallProduct p) throws Exception {
		Connection conn = open();

		String sql = "INSERT INTO shopingproduct(name, img, category, content, link) VALUES(?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(conn; pstmt) {
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getImg());
			pstmt.setString(3, p.getCategory());
			pstmt.setString(4, p.getContent());
			pstmt.setString(5, p.getLink());
			pstmt.executeUpdate();
		}
	}
	
	// 게시글 삭제를 위한 메서드, 삭제할 게시글의 aid를 받아서 삭제함
	public void delShoping(int aid) throws SQLException {
		Connection conn = open();
		String sql = "delete from shopingmall where aid = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt) {
			pstmt.setInt(1, aid);
			// 삭제한 게시글이 없을 경우
			if(pstmt.executeUpdate() == 0 ) {
				throw new SQLException("데이테 삭제 에러");
			}
		}
	}
	
	// 쇼핑 품목 삭제를 위한 메서드, 삭제할 품목의 aid를 받아서 삭제
	public void delProduct(int aid) throws SQLException {
		Connection conn = open();
		String sql = "delete from shopingproduct where aid = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try (conn; pstmt) {
			pstmt.setInt(1, aid);
			// 삭제한 품목이 없을 경우 에러출력
			if(pstmt.executeUpdate() == 0) {
				throw new SQLException("데이터 삭제 에러");
			}
		}
	}

	// 사용자의 로그인 정보 조회 메서드
	public ShopingMallUser getUserByUsernameAndPassword(String username, String password) throws SQLException {
		Connection conn = open();
		ShopingMallUser user = null;

		String sql = "SELECT user_id,username FROM users WHERE username = ? AND password = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, username);
		pstmt.setString(2, password);
		ResultSet rs = pstmt.executeQuery();

		if(rs.next()) {
			user = new ShopingMallUser();
			user.setUserId(rs.getInt("user_id"));
			user.setUsername(rs.getString("username"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		return user;
	}

	// 회원가입 메서드
	public void registerUser(ShopingMallUser user) throws SQLException {
		Connection conn = open();
		String sql = "insert into users(username, password) values(?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		try(conn; pstmt) {
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getPassword());
			pstmt.executeUpdate();
		}
	}


	
	
	
	
}
