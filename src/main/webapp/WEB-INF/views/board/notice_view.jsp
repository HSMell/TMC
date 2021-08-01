<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<title>TMC 게시판 보기</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- xe아이콘 -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<!-- 폰트  -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){		
	$('#boardList').click(function(){
		location.replace('/notice_list')
	});
	
	
	$('#btn_delete').click(function(){
	      var result = confirm("정말로 삭제 하시겠습니까?") ;
	      
	      if(!result) return;
	      
	      var post_num = $("#hdn_postNum").val();
	      
	      var data = {"post_num":post_num};
	      
	      data = JSON.stringify(data);
	      $.ajax({
	         url:"deleteFiles",
	         type:"POST",
	         data:data,
	         dataType:"json",
	         contentType:"application/json; charset=UTF-8",
	         async:false,
	         success:function(data){
	            //console.log(JSON.stringify(data));
	            if(data.succesed == "success")
	               alert("삭제되었습니다.");
	            else
	               alert("삭제되지 않았습니다.");
	            
	            location.href = "/notice_list";
	         },
	         error:function(err){
	            $("#txt_postContents").val("삭제 못함");
	         }
	      });
	   });
	
	$('#btn_modify').click(function(){		
	      $("#frm_postInfo").submit();
	   }); 
});

</script>
</head>
<body>

<header class="navbar   head_wrap  ">

<div class="container px-0 pt-xl-2">
  <div>
    <a href="/notice_list"  class="btn svg  p-0" alt="로고"><object  class="d-block logo" type="image/svg+xml" data="img/logo.svg"></object></a>
  </div>

  <div>
    <a href="/mypage"   class="topmenu_ico"> <i class="xi-profile-o xi-2x xi-x"></i> <span class="d-none d-lg-inline-block d-xl-inline-block">${user_id}</a><!-- 마이페이지 -->
    <a href="/logout" class="topmenu_ico t_underline">Log out</a>
  </div>
</div>
<div class="container sub_tit01">
  Inspiration for the future society, <br>
  creating a new future
</div>
</header>


<!-- 본문내용 시작   -->
<div class="container-lg mt-0  mt-md-5  con_wrap">

<form id="frm_postInfo" action="notice_modify" method="post">
<div class="board_list">
<!-- 			공지사항일경우
<h3><span class="pup_st">[공지]</span> -->

<input type="hidden" id="hdn_postNum" name="hdn_postNum" value="${result.post_num }">

  <div class="board_list_tit">
    <h3><!--공지사항일경우  <span class="pup_st">[공지]</span> --> ${result.post_title } </h3>
    <p class="mt-1 cgray01 f-size13">
    	<fmt:parseDate value="${result.update_date}" var="dateFmt" pattern="yyyy-MM-dd HH:mm"/>
		<fmt:formatDate value="${dateFmt}" pattern="MM dd. yy   HH:mm"/></p>
  </div>

   <div class="board_list_body">
   <c:forEach var="data" items="${getFileList}" varStatus="num">
    <img src="${data.file_path}${data.save_file_name}">
    </c:forEach>
    <p class=" mt-4">
    ${result.post_content }</p>
  </div>

</div>
</form>

  <!-- 게시판 쓰기/수정 버튼등-->
<div class="mt-5 mb-5 text-right pr-1">

	<button type="button" class="btn btn-outline-dark" id="btn_modify">수정</button>
	<button type="button" class="btn btn-dark" id="btn_delete">삭제</button>
	<button type="button" class="btn btn-outline-dark" id="boardList">목록 가기</button>
	
	
</div>


</div>
<!-- 공지사항 끝 -->

<!-- 본문내용 끝  -->


<!-- 하단 -->

</body>

<div class="footer">
  상호명 : TMC | 대표자 : 홍길동 | 사업자번호 :123-123-12324 | 서울시 종로구 새문안로11 | 대표전화 : 01-123-4546<br>
  COPYRIGHT (C) 2021 TMC. ALL RIGHTS RESERVED
</div>
</html>