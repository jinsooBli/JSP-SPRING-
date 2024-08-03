<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="/css/order.css">
  <link rel="stylesheet" type="text/css" href="/css/common.css">
  <link rel="stylesheet" type="text/css" href="/css/footer.css">
  <title>제품 등록</title>
</head>
<body>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <a class="navbar-brand" href="/shopingmall/main">쇼핑몰 중계</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/shopingmall/main">메인 홈</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">BEST</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">NEW</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              OUTER
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">점퍼</a></li>
              <li><a class="dropdown-item" href="#">코트</a></li>
              <li><a class="dropdown-item" href="#">자켓</a></li>
              <li><a class="dropdown-item" href="#">가디건</a></li>
              <li><a class="dropdown-item" href="#">패딩</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              TOP
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">티셔츠</a></li>
              <li><a class="dropdown-item" href="#">맨투맨/후드</a></li>
              <li><a class="dropdown-item" href="#">반팔티</a></li>
              <li><a class="dropdown-item" href="#">니트</a></li>
              <li><a class="dropdown-item" href="#">블라우스</a></li>
              <li><a class="dropdown-item" href="#">셔츠</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              BOTTOM
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">데님</a></li>
              <li><a class="dropdown-item" href="#">코튼</a></li>
              <li><a class="dropdown-item" href="#">슬렉스</a></li>
              <li><a class="dropdown-item" href="#">레깅스</a></li>
              <li><a class="dropdown-item" href="#">반바지</a></li>
              <li><a class="dropdown-item" href="#">조거팬츠/카고바지</a></li>
              <li><a class="dropdown-item" href="#">롱스커트</a></li>
              <li><a class="dropdown-item" href="#">미니스커트</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              게시판
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="inquiry">문의사항</a></li>
              <li><a class="dropdown-item" href="#">착용 후기</a></li>
              <li><a class="dropdown-item" href="#">요청 사항</a></li>
            </ul>
          </li>
        </ul>
        <nav class="navbar navbar-expand-sm bg-primary navbar-dark">
          <div class="container-fluid">
            <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
              <ul class="navbar-nav">
                <c:if test="${not empty user}">
                  <li class="nav-item">
                    <p>${user.username} 님</p>
                    <a class="nav-link" href="/shopingmall/main/logout">로그아웃</a>

                  </li>
                </c:if>
                <c:if test="${empty user}">
                  <li class="nav-item">
                    <a class="nav-link" href="/shopingmall/main/login">로그인</a>
                  </li>
                </c:if>
              </ul>
            </div>
          </div>
        </nav>
        <form class="d-flex" role="search">
          <input class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
          <button class="btn btn-outline-success" type="submit" style="width: 50px; height: 50px;"><img src="/images/71403.png" alt="" style="width: 15px; height: 15px; object-fit: cover;"></button>
        </form>
      </div>
    </div>
  </nav>
  <h1>제품 등록하기</h1>
  <div id="container">
    <form method="post" action="/shopingmall/main/addProduct/addShop" enctype="multipart/form-data">
      <fieldset style="border: 1px solid #0000;">
        <label class="form-label">제품 이름</label>
        <input class="form-control" type="text" name="name" />
        <label class="form-label">이미지</label>
        <input class="form-control" type="file" name="file"  /> <br>
        <td>카테고리</td> 
        <td>
          <select id="email">
            <option value="" selected>선택</option>
            <option value="점퍼">점퍼</option>
            <option value="코트">코트</option>
            <option value="자켓">자켓</option>
            <option value="가디건">가디건</option>
            <option value="티셔츠">티셔츠</option>
            <option value="맨투맨">맨투맨</option>
            <option value="후드">후드</option>
            <option value="반팔티">반팔티</option>
            <option value="블라우스">블라우스</option>
            <option value="셔츠">셔츠</option>
            <option value="데님">데님</option>
            <option value="슬렉스">슬렉스</option>
            <option value="반바지">반바지</option>
            <option value="조거팬츠">조거팬츠</option>
            <option value="카고바지">카고바지</option>
            <option value="롱스커트">롱스커트</option>
            <option value="미니스커트">미니스커트</option>
          </select>
        </td> <br>

        <label class="form-label">제품 설명</label>
        <textarea name="content" class="form-control" cols="50" rows="5"></textarea>  
        <label class="form-label">쇼핑몰 구매 링크</label>
        <input class="form-control" type="text" name="link" />
      </fieldset>
      <div>
        <input type="submit" value="등록하기"> 
        <a href="javascript:history.back()"><input type="button" value="취소하기"></a>
      </div>        
    </form>
  </div>
  <footer>
    <ul id="address">
      <li>서울특별시 금천구 가산디지털2로 101 (가산동) 한라원앤원타워 B동 3층</li>  
      <li>TEL : 031-123-1234  Email : email@domain.com</li>
      <li>COPYRIGHT (C) 코스모 ALL RIGHTS RESERVED</li>
    </ul> 
</body>
</html>