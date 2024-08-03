<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/css/common.css"> -->
  <link rel="stylesheet" type="text/css" href="/css/footer.css">
  <style>
  	#container {
  		margin: 10px 600px;
  	}
  	ul {
  		list-style: none;
  	}

    /* 기본 폼 스타일 */
    .form-control {
      border-radius: 0.5rem;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .form-control:focus {
      box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
      border-color: #007bff;
    }

    .btn {
      border-radius: 0.5rem;
    }

    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }

    .btn-primary:hover {
      background-color: #0056b3;
      border-color: #004085;
    }

    .btn-primary:focus, .btn-primary.focus {
      box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.5);
    }

    /* 추가 스타일 */
    .container {
      max-width: 600px;
    }

    h2 {
      color: #333;
      font-weight: 600;
    }

    .mb-3 {
      margin-bottom: 1.5rem;
    }

    .form-text {
      font-size: 0.875rem;
    }

    small {
      font-size: 0.875rem;
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
  <div class="container mt-5">
    <h2 class="text-center mb-4">회원가입</h2>
    <form action="/shopingmall/register" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">사용자 이름</label>
        <input type="text" class="form-control form-control-lg" id="username" name="username" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" class="form-control form-control-lg" id="password" name="password" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" class="form-control form-control-lg" id="email" name="email" required>
      </div>
      <div class="mb-3">
        <label for="inputPassword6" class="col-form-label">비밀번호 (확인용)</label>
        <input type="password" id="inputPassword6" class="form-control form-control-lg" aria-describedby="passwordHelpInline">
        <small id="passwordHelpInline" class="form-text text-muted">
          비밀번호는 8-20자 이내로 설정해주세요.
        </small>
      </div>
      <button type="submit" class="btn btn-primary btn-lg w-100">가입하기</button>
    </form>
  </div>
  <footer>
    <ul id="address">
      <li>서울특별시 금천구 가산디지털2로 101 (가산동) 한라원앤원타워 B동 3층</li>  
      <li>TEL : 031-123-1234  Email : email@domain.com</li>
      <li>COPYRIGHT (C) 코스모 ALL RIGHTS RESERVED</li>
    </ul>       
</footer>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
