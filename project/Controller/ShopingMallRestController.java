package com.example.project.Controller;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import com.example.project.DAO.ShopingMallDAO;
import com.example.project.Model.ArticlePage;
import com.example.project.Model.ShopingMall;
import com.example.project.Model.ShopingMallUser;
import com.example.project.Model.ShopingMallProduct;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/shopingmall")
public class ShopingMallRestController {

	private final ShopingMallDAO dao;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// 파일이 저장될 디렉토리 경로를 application.properties에서 주입
	@Value("${shop.img.dir}")
	String fdir;

	// DAO 객체를 주입받아 사용
	public ShopingMallRestController(ShopingMallDAO dao) {
		this.dao = dao;
	}

	/**
	 * 게시글 목록 조회 (페이지 처리)
	 * @param page 현재 페이지 번호 (기본값: 1)
	 * @param size 페이지당 게시글 수 (기본값: 10)
	 * @param session 현재 사용자 세션
	 * @return 게시글 목록 페이지 객체와 상태 코드
	 */
	@GetMapping("/articles")
	public ResponseEntity<?> getShopingList(
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size,
			HttpSession session
	) {
		try {
			// 페이징 처리를 위한 오프셋 계산
			int offset = (page - 1) * size;

			// DAO를 통해 게시글 목록과 총 개수 가져오기
			List<ShopingMall> ShopingList = dao.getAll(offset, size);
			int totalCount = dao.getTotalCount();
			int totalPages = (int) Math.ceil((double) totalCount / size);

			// 페이지 객체 생성
			ArticlePage<ShopingMall> articlePage = new ArticlePage<>(
					ShopingList,
					totalCount,
					totalPages,
					page,
					size
			);

			return ResponseEntity.ok(articlePage);
		} catch (Exception e) {
			// 에러 로그와 응답 처리
			logger.error("게시글 목록 생성 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("게시글 목록이 정상적으로 처리되지 않았습니다.");
		}
	}

	/**
	 * 게시글 상세 조회
	 * @param aid 게시글 ID
	 * @return 게시글 객체와 상태 코드
	 */
	@GetMapping("/articles/{aid}")
	public ResponseEntity<?> getShoping(@PathVariable int aid) {
		try {
			// 게시글을 ID로 조회
			ShopingMall s = dao.getShoping(aid);
			return ResponseEntity.ok(s);
		} catch (SQLException e) {
			// 에러 로그와 응답 처리
			logger.error("게시글을 가져오는 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("게시글을 정상적으로 가져오지 못했습니다!");
		}
	}

	/**
	 * 게시글 등록
	 * @param shopingmall 게시글 객체
	 * @param file 업로드된 이미지 파일
	 * @param session 현재 사용자 세션
	 * @return 상태 코드와 메시지
	 */
	@PostMapping("/articles")
	public ResponseEntity<?> addShoping(@ModelAttribute ShopingMall shopingmall, @RequestParam("file") MultipartFile file, HttpSession session) {
		// 현재 로그인한 사용자 정보를 세션에서 가져오기
		ShopingMallUser user = (ShopingMallUser) session.getAttribute("user");

		try {
			// 파일 저장 처리
			String fileName = file.getOriginalFilename();
			String sysName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
			File dest = new File(fdir + "/" + sysName);
			file.transferTo(dest);

			// 게시글 정보 설정
			shopingmall.setImg("/img/" + dest.getName());
			shopingmall.setName(user.getUsername());

			// DAO를 통해 게시글 데이터베이스에 저장
			dao.addShoping(shopingmall);

			return ResponseEntity.status(HttpStatus.CREATED).body("게시글이 등록되었습니다.");
		} catch (Exception e) {
			// 에러 로그와 응답 처리
			logger.error("게시글 등록 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("게시글이 정상적으로 등록되지 않았습니다!");
		}
	}

	/**
	 * 게시글 삭제
	 * @param aid 게시글 ID
	 * @return 상태 코드와 메시지
	 */
	@DeleteMapping("/articles/{aid}")
	public ResponseEntity<?> delShoping(@PathVariable int aid) {
		try {
			// 게시글 삭제 처리
			dao.delShoping(aid);
			return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
		} catch (SQLException e) {
			// 에러 로그와 응답 처리
			logger.error("게시글 삭제 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("게시글이 정상적으로 삭제되지 않았습니다!");
		}
	}

	/**
	 * 제품 목록 조회
	 * @return 제품 목록과 상태 코드
	 */
	@GetMapping("/products")
	public ResponseEntity<?> getProductList() {
		try {
			// DAO를 통해 제품 목록 가져오기
			List<ShopingMallProduct> ProductList = dao.getAllproduct();
			return ResponseEntity.ok(ProductList);
		} catch (Exception e) {
			// 에러 로그와 응답 처리
			logger.error("제품 목록 생성 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("제품 목록이 정상적으로 처리되지 않았습니다!");
		}
	}

	/**
	 * 제품 등록
	 * @param product 제품 객체
	 * @param file 업로드된 이미지 파일
	 * @return 상태 코드와 메시지
	 */
	@PostMapping("/products")
	public ResponseEntity<?> addProduct(@ModelAttribute ShopingMallProduct product, @RequestParam("file") MultipartFile file) {
		try {
			// 파일 저장 처리
			String fileName = file.getOriginalFilename();
			String sysName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
			File dest = new File(fdir + "/" + sysName);
			file.transferTo(dest);

			// 제품 정보 설정
			product.setImg("/img/" + dest.getName());

			// DAO를 통해 제품 데이터베이스에 저장
			dao.addProduct(product);

			return ResponseEntity.status(HttpStatus.CREATED).body("제품이 등록되었습니다.");
		} catch (Exception e) {
			// 에러 로그와 응답 처리
			logger.error("제품 등록 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("제품이 정상적으로 등록되지 않았습니다!");
		}
	}

	/**
	 * 제품 삭제
	 * @param aid 제품 ID
	 * @param session 현재 사용자 세션
	 * @return 상태 코드와 메시지
	 */
	@DeleteMapping("/products/{aid}")
	public ResponseEntity<?> delProduct(@PathVariable int aid, HttpSession session) {
		// 현재 로그인한 사용자 정보를 세션에서 가져오기
		ShopingMallUser user = (ShopingMallUser) session.getAttribute("user");
		if (user == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
		}

		try {
			// 제품 삭제 처리
			dao.delProduct(aid);
			return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
		} catch (SQLException e) {
			// 에러 로그와 응답 처리
			logger.error("제품 삭제 과정에서 문제 발생!", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("제품이 정상적으로 삭제되지 않았습니다!");
		}
	}

	/**
	 * 회원가입 처리
	 * @param username 사용자 이름
	 * @param password 사용자 비밀번호
	 * @return 상태 코드와 메시지
	 */
	@PostMapping("/register")
	public ResponseEntity<?> register(@RequestParam("username") String username, @RequestParam("password") String password) {
		try {
			// 사용자 정보를 데이터베이스에 저장
			dao.registerUser(new ShopingMallUser(username, password));
			return ResponseEntity.status(HttpStatus.CREATED).body("회원가입이 완료되었습니다.");
		} catch (Exception e) {
			// 에러 로그와 응답 처리
			logger.error("회원가입 중 문제가 발생했습니다.", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("회원가입 중 문제가 발생했습니다.");
		}
	}
}