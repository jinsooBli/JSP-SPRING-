package com.example.project.Model;

import java.util.List;

public class ArticlePage<T> {
    private List<T> items;     // 페이지에 표시할 아이템 리스트
    private int totalItems;    // 전체 아이템 수
    private int totalPages;    // 전체 페이지 수
    private int currentPage;   // 현재 페이지 번호
    private int pageSize;      // 페이지당 아이템 수

    public ArticlePage(List<T> items, int totalItems, int totalPages, int currentPage, int pageSize) {
        this.items = items;
        this.totalItems = totalItems;
        this.totalPages = totalPages;
        this.currentPage = currentPage;
        this.pageSize = pageSize;
    }

    // Getters and Setters

    public List<T> getItems() {
        return items;
    }

    public void setItems(List<T> items) {
        this.items = items;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
