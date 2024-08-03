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
  <link rel="stylesheet" type="text/css" href="/css/common.css">
  <link rel="stylesheet" type="text/css" href="/css/footer.css">
  <link rel="stylesheet" type="text/css" href="/css/board_left.css">
  <link rel="stylesheet" type="text/css" href="/css/board_list_main.css">
  <title>쇼핑몰 중계 메인홈페이지</title>
  <style>
    .card {
      display: grid;
      grid-template-columns: repeat(3, 200px);
      justify-items:auto;
      width: 150px;
      height: 300px;
      margin: 10px;
    }
    .next {
      text-decoration: none;
      color: black;
    }
    
  </style>
</head>
<body>
  <nav class="navbar navbar-expand-lg bg-body-tertiary" id="headernav">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">쇼핑몰 중계</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">메인 홈</a>
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
              <li><a class="dropdown-item" href="main/inquiry">문의사항</a></li>
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
  <a href="main/addProduct"><button class="btn btn-outline-info mb-3" type="button"  aria-expanded="false"
  style="margin-top: 10px; margin-left: 10px;" >
    제품 등록
  </button></a>

  <%-- 사용자 정보 출력 --%>
  <c:if test="${not empty user}">
    <p style="margin-left: 10px">안녕하세요, ${user.username}님!</p>
    <a href="<c:url value='/shopingmall/main/logout'/>"><button class="btn btn-outline-danger mb-3" type="button"  aria-expanded="false"
                                                                style="margin-top: 10px; margin-left: 10px;" >로그아웃</button></a>
  </c:if>
  <c:if test="${empty user}">
    <p>로그인하지 않았습니다.</p>
    <a href="<c:url value='/shopingmall/main/login'/>"><button class="btn btn-outline-success mb-3" type="button"  aria-expanded="false"
                                                               style="margin-top: 10px; margin-left: 10px;" >로그인</button></a>
  </c:if>
  <c:if test="${empty user}">
    <a href="<c:url value='/shopingmall/main/register'/>"><button class="btn btn-outline-success mb-3" type="button"  aria-expanded="false"
                                                                  style="margin-top: 10px; margin-left: 10px;" >회원가입</button></a>
  </c:if>

  <h2 style="margin: 10px 20px;">오늘의 HOT템!</h2>
  <div class="container text-center">
    <div class="row">
      <c:forEach var="product" items="${ProductList}" >
	      <div class="card" style="width: 25rem;">
	        <img src="${product.img}" class="card-img-top" alt="제품 이미지" style="width: 215px; height: 300px;">
	        <div class="card-body">
	          <h5 class="card-title">${product.name}</h5>
	          <p class="card-text">${product.content}</p>
	          <div class="dropdown">
	            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
	              구매 하기
	            </button>
	            <ul class="dropdown-menu">
	              <li><a class="dropdown-item" href="${product.link}">주문하기</a></li>
	              <li><a class="dropdown-item" href="#">장바구니에 담기</a></li>
	              <li><a class="dropdown-item" href="${product.link}">상세 설명 보기</a></li>
	            </ul>
	             <a href="main/${product.aid}"><span class="badge bg-danger">&times;</span></a>
	          </div>
	        </div>
	      </div>
      </c:forEach> 
  </div>
  <div id="buttons">
    <div class="col1"><a href="#" class="next">◀ 이전 페이지 </a>l <a href="#" class="next">다음 페이지 ▶</a></div>
    </div>
  </div>
  <footer>
    <ul id="address">
      <li>서울특별시 금천구 가산디지털2로 101 (가산동) 한라원앤원타워 B동 3층</li>  
      <li>TEL : 031-123-1234  Email : email@domain.com</li>
      <li>COPYRIGHT (C) 코스모 ALL RIGHTS RESERVED</li>
    </ul>       
</footer>
</body>
</html>






