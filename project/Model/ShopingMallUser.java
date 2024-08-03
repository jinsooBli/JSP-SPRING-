package com.example.project.Model;

public class ShopingMallUser {
    private int userId;
    private String username;
    private String password;

    public ShopingMallUser(){}
    // 생성자
    public ShopingMallUser(String username, String password) {
        this.username = username;
        this.password = password;
    }



    // 게터 와 세터

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
