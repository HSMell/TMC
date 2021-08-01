<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<title>TMC 게시판 목록</title>

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
	<link rel="stylesheet" href="/css/custom.css">
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	<!-- xe아이콘 -->
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
	<!-- 폰트  -->
</head>
<script>
$(document).ready(function(){	
	$("#btn_detail").on("click", ".media",function(){
		let re = $(this).attr("data-num");
		location.href="/notice_view?post_num="+re;			
	});
	
	$('#writeBtn').click(function(){
		location.replace('/notice_write')
	});
});
</script>
<body>
<header class="navbar   head_wrap  ">

					<div class="container px-0 pt-xl-2">
						<div>
						<a href="/notice_list"  class="btn svg  p-0" alt="로고"><object  class="d-block logo" type="image/svg+xml" data="img/logo.svg"></object></a>
						</div>
						
						<div><a href="/mypage"   class="topmenu_ico"> <i class="xi-profile-o xi-2x xi-x"></i> <span class="d-none d-lg-inline-block d-xl-inline-block">${user_id}</a><!-- 마이페이지 -->
						 <a href="/logout" class="topmenu_ico t_underline">Log out</a>
						</div>
					</div>
					<div class="container sub_tit01">Inspiration for the future society, <br>
creating a new future</div>
				</header>
 

<!-- 본문내용 시작   -->
<div class="container-lg mt-0  mt-md-5  con_wrap">

<form action="/search" method="GET">
	<div class="p-3 py-md-4 bg-light text-dark rounded">
		<div class="input-group input_search">  	
			<input class="form-control" name="search_value" id="search_value" type="text" placeholder="궁금한 점을 검색해 보세요" aria-label="Recipient's username" aria-describedby="button-addon2">
			<div class="input-group-append">
				<button class="btn"><img src="img/ico_search.png" alt="" /></button>
	  		</div>
	  	</div>
	</div>
</form>


			
<!--공지사항 시작 1p에 10개 나오게 해주세요  -->
  <ul class="list-unstyled border01" id="btn_detail">
  <c:forEach var="data" items="${ isResult}" varStatus="num">
  	<!-- <li class="media border-bottom px-3 py-3 align-items-center ">
    <a href="#" class="d-block mr-3 "><i class="xi-info   xi-x pup_st"></i></a>
    <div class="media-body  ">
      <a href="notice_view.html" class="d-block pup_st"><p class="mt-0"><b>공지사항 테스트 공지사항 테스트 </b></p>
      <p class="cgray01 f-size13 mt-1">July 23. 21   16:59 <span class="ml-2">홍길동</span></p></a>
    </div>
    <img src="img/arrow_02.png"   class="ml-3"  alt="화살표" /> 
    </li> -->
	<c:choose>
		<c:when test="${data.file_path eq null}">
			<li class="media border-bottom px-3 py-3 align-items-center" data-num="${data.post_num }">
			<div class="media-body  ">
			  <a class="d-block"><p class="mt-0">${data.post_title } </p>
			<p class="cgray01 f-size13 mt-1">
			<fmt:parseDate value="${data.update_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm"/>
			<fmt:formatDate value="${dateFmt}" pattern="MM dd. yy   HH:mm"/>
			<span class="ml-2">${data.user_id }</span></p></a>
			</div>
			<img src="img/arrow_02.png"   class="ml-3"  alt="화살표" /> 
			</li>
		</c:when>
	<c:otherwise>
		<li class="media border-bottom px-3 py-3 align-items-center" data-num="${data.post_num }">    	
			<a class="d-block"><img src="${data.file_path}" value="${num.count}" class="mr-3 rounded-sm" width="54px" alt="..." /></a>
			<div class="media-body  ">
			  <a class="d-block"><p class="mt-0">${data.post_title } </p>
			<p class="cgray01 f-size13 mt-1">
			<fmt:parseDate value="${data.update_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm"/>
			<fmt:formatDate value="${dateFmt}" pattern="MM dd. yy   HH:mm"/>
			<span class="ml-2">${data.user_id }</span></p></a>
			</div>
			<img src="img/arrow_02.png"   class="ml-3"  alt="화살표" /> 
		</li>
	</c:otherwise>
	</c:choose>
	<!-- 공지로 등록할 경우 -->
	 
	<!-- 공지 끝  -->
	</c:forEach>
  </ul>

  <!-- 게시판 쓰기/수정 버튼등-->
<div class="mt-3 pr-1 text-right">

	<button type="button" class="btn btn-pup" id="writeBtn">글쓰기</button>
</div>
</div>


<!-- 공지사항 끝 -->
<nav aria-label="Page navigation example ">
<ul class="pagination justify-content-center mt-4">
  <li class="page-item">
  <a class="page-link cgray01" href="#" aria-label="Previous">
  <span aria-hidden="true">&laquo;</span>
  </a>
  </li>
  <li class="page-item"><a class="page-link text-dark active " href="#">1</a></li>
  <li class="page-item"><a class="page-link text-dark" href="#">2</a></li>
  <li class="page-item"><a class="page-link text-dark" href="#">3</a></li>
  <li class="page-item">
  <a class="page-link cgray01" href="#" aria-label="Next">
  <span aria-hidden="true">&raquo;</span>
  </a>
  </li>
</ul>
</nav>
<!-- 본문내용 끝  -->

 
<!-- 하단 -->
 
</body>
<div class="footer">
	상호명 : TMC | 대표자 : 홍길동 | 사업자번호 :123-123-12324 | 서울시 종로구 새문안로11 | 대표전화 : 01-123-4546<br>
COPYRIGHT (C) 2021 TMC. ALL RIGHTS RESERVED
</div>
</body>
</html>