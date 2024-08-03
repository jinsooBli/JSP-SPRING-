package com.example.project.Controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shopingmall/main")
public class LogoutController {

    // 세션에서 접속한 유저 정보를 비워 버려서 로그아웃 구현
    @GetMapping("/logout")
    public String logout(HttpSession session){
        // 로그아웃 시 세션 무효화
        session.invalidate();
        // 메인 페이지로 리다이렉트
        return "redirect:/shopingmall/main";
    }
}
