package com.example.project.Service;

import com.example.project.DAO.ShopingMallDAO;
import com.example.project.Model.ShopingMall;
import com.example.project.Model.ShopingMallUser;
import com.example.project.Model.ShopingMallProduct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

@Service
public class ShopingMallServiceImpl implements ShopingMallService {

    private final ShopingMallDAO dao;

    // 이미지 파일이 저장될 디렉토리 경로를 application.properties에서 주입
    @Value("${shop.img.dir}")
    private String imgDir;

    // DAO 객체를 주입받아 사용
    public ShopingMallServiceImpl(ShopingMallDAO dao) {
        this.dao = dao;
    }

    /**
     * 쇼핑몰 게시글을 등록하는 메서드
     * @param shopingmall 게시글 객체
     * @param file 업로드된 이미지 파일
     * @param user 게시글 작성자 정보
     * @throws Exception 파일 처리 및 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public void addShoping(ShopingMall shopingmall, MultipartFile file, ShopingMallUser user) throws Exception {
        // 파일 이름 생성 및 저장
        String fileName = file.getOriginalFilename();
        String sysName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
        File dest = new File(imgDir + "/" + sysName);
        file.transferTo(dest);

        // 게시글 이미지 경로 설정
        shopingmall.setImg("/img/" + dest.getName());

        // 작성자 이름 설정
        shopingmall.setName(user.getUsername());

        // DAO를 통해 데이터베이스에 저장
        dao.addShoping(shopingmall);
    }

    /**
     * 쇼핑몰 제품을 등록하는 메서드
     * @param product 제품 객체
     * @param file 업로드된 이미지 파일
     * @throws Exception 파일 처리 및 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public void addProduct(ShopingMallProduct product, MultipartFile file) throws Exception {
        // 파일 이름 생성 및 저장
        String fileName = file.getOriginalFilename();
        String sysName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
        File dest = new File(imgDir + "/" + sysName);
        file.transferTo(dest);

        // 제품 이미지 경로 설정
        product.setImg("/img/" + dest.getName());

        // DAO를 통해 데이터베이스에 저장
        dao.addProduct(product);
    }

    /**
     * 쇼핑몰 게시글 목록을 가져오는 메서드
     * @param offset 페이징을 위한 오프셋
     * @param size 한 페이지에 표시할 항목 수
     * @return 쇼핑몰 게시글 목록
     * @throws Exception 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public List<ShopingMall> getShopingList(int offset, int size) throws Exception {
        return dao.getAll(offset, size);
    }

    /**
     * 쇼핑몰 게시글의 총 개수를 가져오는 메서드
     * @return 게시글 총 개수
     * @throws SQLException 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public int getTotalCount() throws SQLException {
        return dao.getTotalCount();
    }

    /**
     * 특정 ID의 쇼핑몰 게시글을 가져오는 메서드
     * @param aid 게시글 ID
     * @return 게시글 객체
     * @throws SQLException 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public ShopingMall getShoping(int aid) throws SQLException {
        return dao.getShoping(aid);
    }

    /**
     * 특정 ID의 쇼핑몰 게시글을 삭제하는 메서드
     * @param aid 게시글 ID
     * @throws SQLException 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public void delShoping(int aid) throws SQLException {
        dao.delShoping(aid);
    }

    /**
     * 쇼핑몰 제품 목록을 가져오는 메서드
     * @return 제품 목록
     * @throws Exception 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public List<ShopingMallProduct> getProductList() throws Exception {
        return dao.getAllproduct();
    }

    /**
     * 특정 ID의 쇼핑몰 제품을 삭제하는 메서드
     * @param aid 제품 ID
     * @throws SQLException 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public void delProduct(int aid) throws SQLException {
        dao.delProduct(aid);
    }

    /**
     * 새로운 사용자를 등록하는 메서드
     * @param user 사용자 객체
     * @throws Exception 데이터베이스 작업 중 발생할 수 있는 예외
     */
    @Override
    public void registerUser(ShopingMallUser user) throws Exception {
        dao.registerUser(user);
    }

}