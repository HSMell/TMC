<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<title>TMC 회원가입</title>

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
<script type="text/javascript">
	$(document).ready(function(){		
		//이메일 유효성 양식
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		
		$("#btn_signIn").on("click", function(){
			//이메일 중복검사 Ajax
		var user_id = $("#inputname2").val();
		var data = {"user_id":user_id};
		data = JSON.stringify(data);
		$.ajax({
			url:"/TMC/checkId",
			type:"POST",
			data:data,
			dataType:"json",
			contentType:"application/json; charset=UTF-8",
			async:false,
			success:function(data){
				//아이디 중복시
				if(data.isResult == 1){
					alert("이메일이 중복되었습니다.");
			          $('#inputname2').val("");
			          $('#inputname2').focus();
					return false;
				}
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
			},
			error:function(err){
				alert("error");
			}
		});
	});
		
});
</script>

</head>
<body>

<form action="/TMC/doSignup" method="post" enctype="multipart/form-data">
<!-- 본문내용 시작   -->
<div class="con_wrap100">
  <div class="box_wrap" >
    <div class="   box_topst ">
     
      <p class="mt-2  join_wrap m-auto"> <b>회원가입을 원하시나요?</b><br>회원가입 정보를 입력하세요.  </p>
    </div>

    <div class=" join_wrap02 m-auto">
      <div class="form-group mb-1">
	  <p><b class="pup_st">아이디</b></p>
        <input type="text" class="form-control" id="inputname2" placeholder="이메일을 입력하세요" name="id" required/>
      </div>
	  <div class="form-group  mt-3">
	  <p><b class="pup_st">패스워드</b></p>
        <input type="password" class="form-control" id="inputpass2" placeholder="패스워드를 입력하세요" name="pass" required/>
      </div>
       
      <div class="mt-5">
	    
        <button class="btn btn-lg btn-pup02 btn-block" id="btn_signIn" type="submit" /><b>가입완료</b></button>
      </div>
    
     </div>
  </div>

</div>
</form>
<!-- 본문내용 끝  -->


<!-- 하단 -->

</body>
</html>