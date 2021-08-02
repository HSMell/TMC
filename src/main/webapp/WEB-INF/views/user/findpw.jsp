<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<title>TMC 비밀번호 찾기 </title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- xe아이콘 -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<!-- 폰트  -->
</head><script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){		
		//이메일 유효성 양식
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		
		$("#btn_send").on("click", function(){
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
		});
});
</script>
</head>
<body>

<form action="findpwd" method="post">
<!-- 본문내용 시작   -->
<div class="con_wrap100">
  <div class="box_wrap" >
    <div class="   box_topst ">
     
      <p class="  join_wrap m-auto"> <b>비밀번호가 기억나지않나요?</b><br>가입하신 이메일을 입력하세요. </p>
    </div>

    <div class=" join_wrap02 m-auto ">
      <div class="form-group mb-1">
        <input type="text" class="form-control  " name="user_id" id="inputname2" placeholder="E-MAIL을 입력하세요" required/>
      </div>
       
      <div class="mt-3 ">
        <button class="btn btn-lg btn-pup02 btn-block" id = "btn_send" type="submit"><b>이메일 확인</b></button>
      </div>
    
     </div>
  </div>

</div>
</form>
<!-- 본문내용 끝  -->


<!-- 하단 -->

</body>
</html>