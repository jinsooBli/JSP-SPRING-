package com.example.project.Service;

import com.example.project.Model.ShopingMall;
import com.example.project.Model.ShopingMallUser;
import com.example.project.Model.ShopingMallProduct;
import org.springframework.web.multipart.MultipartFile;


import java.sql.SQLException;
import java.util.List;


public interface ShopingMallService {
    void addShoping(ShopingMall shopingMall, MultipartFile file, ShopingMallUser User) throws Exception;

    void addProduct(ShopingMallProduct shopingMallProduct, MultipartFile file) throws Exception;

    List<ShopingMall> getShopingList(int offset, int size) throws Exception;

    int getTotalCount() throws SQLException;

    ShopingMall getShoping(int aid) throws SQLException;

    void delShoping(int aid) throws SQLException;

    List<ShopingMallProduct> getProductList() throws Exception;

    void delProduct(int aid) throws SQLException;

    void registerUser(ShopingMallUser user) throws Exception;

}
