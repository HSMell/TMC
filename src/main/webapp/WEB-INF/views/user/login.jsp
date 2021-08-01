<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="description" content="">
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>TMC 로그인</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- xe아이콘 -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<!-- 폰트  -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){		
		//이메일 유효성 검사
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		
		$("#btn_signIn").on("click", function(){
			//이메일 입력X
		if($('#inputname2').val() == ""){
	          alert("이메일을 입력하지 않았습니다");
	          $('#inputname2').focus();
	          return false;
	      }
			
			//이메일 형식
		if(!regex.test($("#inputname2").val())){
			alert("이메일 형식에 맞게 입력해주세요")
			$('#inputname2').val("");
			$('#inputname2').focus();
			return false;
		}
			
			//비밀번호 입력X
		if($('#inputpass2').val() == ""){
		     alert("비밀번호를 입력하지 않았습니다");
		     $('#inputpass2').focus();
		     return false;
		 }
		});
		
		// 클릭시 회원가입
		$("#btn_signUp").on("click", function(){
			location.href="/signup";
		})
		// 클릭시 비밀번호 찾기
		$("#btn_findpw").on("click", function(){
			location.href="/findpw";
		})	
		
	});
	
	
	
</script>

</head>
<body>



<form action="/startlogin" method="post">
<div class="con_wrap100">
  <div class="box_wrap" >
    <div class=" py-5 text-center">
      <p class=" mt-5"><object  class="logo2" type="image/svg+xml" data="./img/logo_c.svg"></object></p>
      <p class="f-size19 mt-2 f-sizem14"> TMC홈페이지 방문을 환영합니다. </p>
    </div>
    <div class="p-4 login_wrap m-auto">
      <div class="form-group mb-1">
        <input type="email" class="form-control  " id="inputname2" placeholder="E-MAIL" name = "user_id" required/>
      </div>
      <div class="form-group ">
        <input type="password" class="form-control  "  id="inputpass2" placeholder="PASSWORD" name = "user_pw" required/>
      </div>
      <div class="mt-1">
        <button class="btn btn-lg btn-pup btn-block" type="submit" id="btn_signIn"><b>SIGN IN</b></button>
      </div>
      <div class="d-flex mt-2 mb-1">
        <p> 
         <div class="form-check form-check-inline checks">
			<input type="checkbox" class ="form-check-input" id="inlineRadio1" value="option1" name ="useCookie">
			<label lass="form-check-label" for="inlineRadio1">로그인 상태 유지</label>
        </div>
        </p>
        
        <a href="#" class="ml-auto" id="btn_findpw">패스워드 찾기</a>
      </div>
      <p class="mt-5 text-center mb-2 ">아직 가입되지 않은 회원입니까? <a href="#" class="pup_st ml-2 t_underline" id="btn_signUp">회원가입</a> </p>
    </div>
  </div>
</div>
</form>
<!-- 본문내용 끝  -->


<!-- 하단 -->

</body>
</html>