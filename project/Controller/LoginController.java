package com.example.project.Controller;

import com.example.project.DAO.ShopingMallDAO;
import com.example.project.Model.ShopingMallUser;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.SQLException;

@Controller
@RequestMapping("/shopingmall/main")
public class LoginController {

    private final ShopingMallDAO dao;

    @Autowired
    public LoginController(ShopingMallDAO dao) {
        this.dao = dao;
    }

    // 세션 정보에서 유저 정보를 받아 db에 있는지 확인 하는 로직
    @PostMapping("/login")
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session, Model m) {
        try {
            ShopingMallUser user = dao.getUserByUsernameAndPassword(username, password);
            if ( user != null) {
                // 로그인 성공 시 세션에 사용자 정보 저장
                session.setAttribute("user", user);
                return "redirect:/shopingmall/main";
            } else {
                // 로그인 실패 시 오류 메시지 추가
                m.addAttribute("error", "로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
                return "shoping/login";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            m.addAttribute("error", "로그인 중 오류가 발생했습니다.");
            return "shoping/login";
        }
    }
}
