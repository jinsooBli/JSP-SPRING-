<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" type="text/css" href="/css/common.css">
  <link rel="stylesheet" type="text/css" href="/css/footer.css">
  <link rel="stylesheet" type="text/css" href="/css/board_left.css">
  <link rel="stylesheet" type="text/css" href="/css/board_list_main.css">
  <style>
    /* 전체 배경 설정 */
    body {
      background-color: #f8f9fa; /* 연한 회색 배경 */
      margin: 0;
    }

    /* 네비게이션 바 스타일 */
    .navbar {
      margin-bottom: 1rem;
    }

    /* 로그인 컨테이너 스타일 */
    .login-container {
      background-color: #ffffff; /* 흰색 배경 */
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      padding: 2rem;
      max-width: 420px;
      width: 100%;
      margin: 2rem auto;
    }

    /* 제목 스타일 */
    .login-title {
      text-align: center;
      margin-bottom: 1.5rem;
      color: #333;
      font-size: 2rem;
      font-weight: 600;
    }

    /* 레이블 및 입력 필드 스타일 */
    .form-label {
      font-weight: 500;
    }

    .form-control {
      border-radius: 0.5rem;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .form-control:focus {
      border-color: #007bff;
      box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
    }

    /* 버튼 스타일 */
    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
      border-radius: 0.5rem;
      padding: 0.75rem 1.25rem;
      font-size: 1rem;
      font-weight: 500;
    }

    .btn-primary:hover {
      background-color: #0056b3;
      border-color: #004085;
    }

    .btn-primary:focus, .btn-primary.focus {
      box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.5);
    }

    .btn-secondary {
      background-color: #6c757d;
      border-color: #6c757d;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
      border-color: #545b62;
    }

    .btn-secondary:focus, .btn-secondary.focus {
      box-shadow: 0 0 0 0.2rem rgba(108,117,125,0.5);
    }

    /* 폼 마진 설정 */
    .mb-3 {
      margin-bottom: 1.5rem;
    }


  </style>

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



        <form class="d-flex" role="search">
          <input class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">검색</button>
        </form>
      </div>
    </div>
  </nav>


  <div class="login-container">
    <h1 class="login-title">로그인</h1>
    <form method="post" action="<c:url value='/shopingmall/main/login'/>">
      <div class="mb-3">
        <label for="username" class="form-label">사용자 이름</label>
        <input id="username" type="text" class="form-control" name="username" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input id="password" type="password" class="form-control" name="password" required>
      </div>
      <button type="submit" class="btn btn-primary">로그인</button>
    </form>
    <c:if test="${not empty error}">
      <p class="text-danger">${error}</p>
    </c:if>
    <a href="register" class="btn btn-secondary mt-3">회원 가입</a>
  </div>


  <footer>
    <ul id="address" class="list-unstyled">
      <li>서울특별시 금천구 가산디지털2로 101 (가산동) 한라원앤원타워 B동 3층</li>
      <li>TEL : 031-123-1234  Email : email@domain.com</li>
      <li>COPYRIGHT (C) 코스모 ALL RIGHTS RESERVED</li>
    </ul>
  </footer>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
