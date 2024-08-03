package com.example.project.Controller;

import com.example.project.Model.ShopingMall;
import com.example.project.Model.ShopingMallUser;
import com.example.project.Model.ShopingMallProduct;
import com.example.project.Service.ShopingMallService;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/shopingmall") // http://localhost:8090/shopingmall
public class ShopingMallWebController {

	private final ShopingMallService shopingMallService;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	public ShopingMallWebController(ShopingMallService shopingMallService) {
		this.shopingMallService = shopingMallService;
	}

	// 게시글 등록 /main/inqiry/boardWrite/addShoping
	@PostMapping("/main/inqiry/boardWrite/addShoping")
	public String addshoping(@ModelAttribute ShopingMall shopingmall, Model m,
							 @RequestParam("file") MultipartFile file, HttpSession session) {
		ShopingMallUser user = (ShopingMallUser) session.getAttribute("user");

		try {
			shopingMallService.addShoping(shopingmall, file, user);
		} catch (Exception e) {
			logger.error("게시글 등록 과정에서 문제 발생!", e);
			m.addAttribute("error", "게시글이 정상적으로 등록되지 않았습니다!");
			return "redirect:/shopingmall/main/inquiry";
		}

		return "redirect:/shopingmall/main/inquiry";
	}

	// 쇼핑 품목 등록 /main/addProduct/addShop
	@PostMapping("/main/addProduct/addShop")
	public String addShop(@ModelAttribute ShopingMallProduct product, Model m,
						  @RequestParam("file") MultipartFile file, HttpSession session) {

		try {
			shopingMallService.addProduct(product, file);
		} catch (Exception e) {
			logger.error("제품 등록 과정에서 문제 발생!", e);
			m.addAttribute("error", "제품이 정상적으로 등록되지 않았습니다!");
			return "redirect:/shopingmall/main";
		}

		return "redirect:/shopingmall/main";
	}

	// 게시글 목록 보기
	@GetMapping("main/inquiry")
	public String ShopingList(@RequestParam(defaultValue = "1") int page,
							  @RequestParam(defaultValue = "10") int size,
							  Model m, HttpSession session) {
		ShopingMallUser user = (ShopingMallUser) session.getAttribute("user");
		int offset = (page - 1) * size;

		try {
			List<ShopingMall> ShopingList = shopingMallService.getShopingList(offset, size);
			int totalCount = shopingMallService.getTotalCount();
			int totalPages = (int) Math.ceil((double) totalCount / size);

			m.addAttribute("ShopingList", ShopingList);
			m.addAttribute("currentPage", page);
			m.addAttribute("totalPages", totalPages);
			m.addAttribute("pageSize", size);
			m.addAttribute("totalItems", totalCount);
		} catch (Exception e) {
			logger.error("게시글 목록 생성 과정에서 문제 발생!", e);
			m.addAttribute("error", "게시글 목록이 정상적으로 처리되지 않았습니다!");
		}
		// 만약 로그인 상태가 아니라면 게시판 접근 불가
		if (user != null) {
			m.addAttribute("user", user);
			return "shoping/inquiry"; // shoping/inquiry.jsp;
		} else {
			return "redirect:/shopingmall/main/login";
		}
	}

	// 제품 목록 보기
	@GetMapping("/main")
	public String ProductList(Model m) {
		try {
			List<ShopingMallProduct> ProductList = shopingMallService.getProductList();
			m.addAttribute("ProductList", ProductList);
		} catch (Exception e) {
			logger.error("제품 목록 생성 과정에서 문제 발생!", e);
			m.addAttribute("error", "제품 목록이 정상적으로 처리되지 않았습니다!");
		}
		return "shoping/index";
	}

	// 게시글 상세 정보 보기
	@GetMapping("/main/inquiry/{aid}")
	public String getShoping(@PathVariable int aid, Model m) {
		try {
			ShopingMall s = shopingMallService.getShoping(aid);
			m.addAttribute("Shopingmall", s);
		} catch (Exception e) {
			logger.error("게시글을 가져오는 과정에서 문제 발생!", e);
			m.addAttribute("error", "게시글을 정상적으로 가져오지 못했습니다!");
		}
		return "shoping/boardView";  // shoping/boardView.jsp;
	}

	// 게시글 삭제
	@GetMapping("/main/inquiry/delete/{aid}")
	public String delShoping(@PathVariable int aid, Model m) {
		try {
			shopingMallService.delShoping(aid);
		} catch (Exception e) {
			logger.error("게시글 삭제 과정에서 문제 발생!", e);
			m.addAttribute("error", "게시글이 정상적으로 삭제되지 않았습니다!");
		}
		return "redirect:/shopingmall/main/inquiry";
	}

	// 쇼핑 품목 삭제
	@GetMapping("main/{aid}")
	public String delProduct(@PathVariable int aid, Model m, HttpSession session) {
		ShopingMallUser user = (ShopingMallUser) session.getAttribute("user");

		try {
			if (user != null) {
				// 로그인 상태면 접근 허용
				shopingMallService.delProduct(aid);
				m.addAttribute("user", user);
			} else {
				// 로그인하지 않은 상태일 때 로그인 페이지로 리다이렉트
				return "redirect:/shopingmall/main/login";
			}
		} catch (Exception e) {
			logger.error("품목 삭제 과정에서 문제 발생!", e);
			m.addAttribute("error", "품목이 정상적으로 삭제되지 않았습니다!");
		}

		return "redirect:/shopingmall/main";
	}

	// 회원가입 처리 메서드
	@PostMapping("/register")
	public String register(@RequestParam("username") String username, @RequestParam("password") String password, Model m) {
		try {
			// 회원 정보 데이터베이스에 저장
			shopingMallService.registerUser(new ShopingMallUser(username, password));
			return "redirect:/shopingmall/main/login"; // 회원가입 후 로그인 페이지로 이동
		} catch (Exception e) {
			logger.error("회원가입 중 문제가 발생했습니다!", e);
			m.addAttribute("error", "회원가입 중 문제가 발생했습니다.");
			return "shoping/register"; // 에러 발생 시 다시 회원가입 페이지로 이동
		}
	}

	// 이후는 페이지 이동 관련 메서드들
	@GetMapping("/main/addProduct")
	public String addProduct(HttpSession session, Model m) {
		ShopingMallUser user = (ShopingMallUser) session.getAttribute("user");

		if (user != null) {
			// 로그인 상태면 제품 등록 페이지 접근 허용
			m.addAttribute("user", user);
			return "shoping/addProduct";
		} else {
			// 로그인하지 않은 상태일 때 로그인 페이지로 리다이렉트
			return "redirect:/shopingmall/main/login";
		}
	}

	@GetMapping("main/login")
	public String login() {
		return "shoping/login";
	}

	@GetMapping("main/register")
	public String register() {
		return "shoping/register";
	}

	@GetMapping("main/inquiry/boardWrite")
	public String boardWrite() {
		return "shoping/boardWrite";
	}
}
