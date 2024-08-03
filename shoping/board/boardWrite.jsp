<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>문의 사항 게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/footer.css">
    <link rel="stylesheet" type="text/css" href="/css/board_left.css">
    <link rel="stylesheet" type="text/css" href="/css/board_write_main.css">
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
              <li><a class="dropdown-item" href="/shopingmall/main/inquiry">문의사항</a></li>
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

  <div id="wrap">
  <section id="main" style="margin: 30px 70px;">
        <h1 style="margin: 30px 160px;">CUSTOMER CENTER</h1>
        <h2 id="board_title">문의사항 </h2>
        <form action="/shopingmall/main/inqiry/boardWrite/addShoping" method="post" enctype="multipart/form-data">
        <div id="write_title"><h3>글쓰기</h3></div>
        <table>
<%--        <tr id="name">--%>
<%--            <td class="col1">이름</td>--%>
<%--            <td class="col2"><input type="text" id="name" name="name"></td>--%>
<%--        </tr>--%>
        <tr id="subject">
            <td class="col1">제목</td>
            <td class="col2"><input type="text" id="title" name="title"></td>
        </tr>      
        <tr id="content">
            <td class="col1">내용</td>
            <td class="col2"><textarea name="content" id="content"></textarea></td>
        </tr>   
        <tr id="upload">
            <td class="col1">업로드 파일</td>
            <td class="col2"><input type="file" id="file" name="file"></td>
        </tr>   
        </table>
        <div id="buttons">
          <button type="submit" >작성</button>
          <button type="reset">취소</button>
        </div> 
        </form>
  </section> <!-- section main -->
  
  <div class="clear">   </div>

<footer>
    <ul id="address">
    <li>서울시 강남구 삼성동 1234 우 : 123-1234</li>  
    <li>TEL : 031-123-1234  Email : email@domain.com</li>
    <li>COPYRIGHT (C) 루바토 ALL RIGHTS RESERVED</li>
    </ul>    
</footer>


</div>    
</body>
</html>