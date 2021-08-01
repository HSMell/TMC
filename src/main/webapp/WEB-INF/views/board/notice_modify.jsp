<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">

<title>TMC 게시판글쓰기</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<!-- xe아이콘 -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
	<!-- 폰트  -->
<script>
$(document).ready(function(){

	   fileNum = ${getFileList.size() + 1};
	   fileCount = ${getFileList.size()};
	   
	   for(f = 0; f < fileNum; f++){
	      content_files.push(["${getFileList}"]);
	   }

	   $('#btn_cancel').click(function(){
	      var result = confirm("작성한 내용이 저장되지 않습니다.");
	      
	      if(result) {
	         location.replace('/notice_list')
	      }
	   });   
	   
	   $("#input_file").on("change", fileCheck);
	   $("#btn_add_files").click(function(e){
	      e.preventDefault();
	        $("#input_file").click();
	   });
	   
	   $('#btn_add').click(function(e){
	      e.preventDefault();
	      if(!fnValidation()) return false;
	      formAction();
	   });
	});

	//파일 현재 필드 숫자 totalCount랑 비교값
	let fileCount = 0;
	//해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
	const totalCount = 5;
	//파일 현재 필드 크기 totalSize랑 비교값
	let fileSize = 0;
	//해당 숫자를 수정하여 전체 업로드 크기를 정한다.
	const totalSize = 10485760;
	// 파일 고유넘버
	let fileNum = 0;
	// 첨부파일 배열
	let content_files = new Array();

	fileCheck = function(e){
	   let files = e.target.files;
	    
	    // 파일 배열 담기
	    let filesArr = Array.prototype.slice.call(files);
	    
	    // 파일 개수 확인 및 제한
	   if (fileCount + filesArr.length > totalCount) {
	      alert("파일은 최대 "+totalCount+"개까지 업로드 할 수 있습니다.");
	      return;
	    } else {
	      fileCount = fileCount + filesArr.length;
	    }
	    
	    // 각각의 파일 배열담기 및 기타
	    filesArr.forEach(function (f) {
	       //파일 크기 확인 및 제한
	       if (fileSize + f.size > totalSize) {
	         $.alert("파일은 최대 10MB까지 업로드 할 수 있습니다.");
	         return;
	       } else {
	          fileSize = fileSize + f.size;
	       }
	       
	      let reader = new FileReader();
	      reader.onload = function (e) {
	         content_files.push(f);
	         let innerHtml =
	            '<input type="hidden" id="hdn1_file'+fileNum+'" name="original_file_name" value="'+ f.name+'">'
	         + '<input type="hidden" id="hdn2_file'+fileNum+'" name="save_file_name" value="'+ f.name+'">'
	         + '<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
	         + '<font style="font-size:12px">' + f.name + '</font>'  
	         + '<img src="/img/icon_minus.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
	         + '<div/>' + '<div id="div_file' + fileNum + '" >'
	         + '<img id="img' + fileNum + '" src="' + e.target.result + '" style="width:150px; height:150px; vertical-align: middle;"/>'
	         + '<div/>';
	         
	         $("#articlefileChange").append(innerHtml);
	         
	         fileNum ++;
	      };
	      
	      reader.readAsDataURL(f);
	   });
	   //console.log(content_files);
	   //초기화 한다.
	   $("#input_file").val("");
	};

	//파일 부분 삭제 함수
	fileDelete = function(fileNum){
	   //debugger;
	   let no = fileNum.replace(/[^0-9]/g, "");
	   content_files[no].is_delete = true;
	   $("#" + fileNum).remove();
	   $("#div_" + fileNum).remove();
	   $("#hdn1_" + fileNum).remove();
	   $("#hdn2_" + fileNum).remove();
	   fileCount --;
	   fileSize = fileSize - content_files[no].size;
	   //console.log(content_files);
	};

	//파일 부분 삭제 함수
	fileDelete1 = function(fileNum){
	   //debugger;
	   let no = fileNum.replace(/[^0-9]/g, "");   
	   $("#" + fileNum).remove();
	   $("#div_" + fileNum).remove();
	   $("#hdn1_" + fileNum).remove();
	   $("#hdn2_" + fileNum).remove();
	   fileCount --;   
	   //console.log(content_files);
	};

	/*
	 * 폼 submit 로직
	 */
	formAction = function(){
	   //debugger;
	   let form = $("form")[0];        
	   let formData = new FormData(form);
	   
	   for (let x = 0; x < content_files.length; x++) {
	      // 삭제 안한것만 담아 준다. 
	      if(!content_files[x].is_delete){
	         formData.append("article_file", content_files[x]);
	      }
	   }
	   
	   /*그려진 파일 디비정보들을 FileDto 정보를 리스트로 formData에 넣는다*/
	   
	   $.ajax({
	      type: "POST",
	      enctype: "multipart/form-data",
	      url: "reupload",
	      data : formData,
	      processData: false,
	      contentType: false,
	      success: function (data) {         
	            alert("수정 완료");
	            location.href = "/notice_list";         
	      },
	      error: function (xhr, status, error) {
	         alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
	         return false;
	      }
	   });
	};

	//유효성체크
	fnValidation = function(){   
	   
		if($('#text_title').val() == "") {
			alert("글 제목을 입력해 주세요.");
			return false;
		}
		
		else if($('#text_title').val().length > 100){
			alert("제목이 100글자가 넘으면 안됩니다.");
			return false;
		}
		
	   if($('#text_content').val() == "") {
	      alert("글 내용을 입력해 주세요.");
	      return false;
	   }
	   
	   if(content_files.length == 0){
	      alert("파일을 첨부해주세요.!");
	      return false;
	   }else if(content_files.length > 0){
	      let not_del_cnt = 0;
	      for(let i=0; i < content_files.length; i++){
	         if(content_files[i].is_delete == null || content_files[i].is_delete == undefined){
	            not_del_cnt++;
	         }
	      }
	      if(not_del_cnt < 1){
	         alert("파일을 첨부해주세요.!!");
	         return false;
	      }
	   }
	   return true;
	};
</script>
</head>
<body>

			<header class="navbar   head_wrap  ">

					<div class="container px-0 pt-xl-2">
						<div>
						<a href="/notice_list"  class="btn svg  p-0" alt="로고"><object  class="d-block logo" type="image/svg+xml" data="img/logo.svg"></object></a>
						</div>
						
						<div><a href="/mypage"   class="   topmenu_ico"> <i class="xi-profile-o xi-2x xi-x"></i> <span class="d-none d-lg-inline-block d-xl-inline-block">${user_id}</a><!-- 마이페이지 -->
						 <a href="/logout" class="topmenu_ico t_underline">Log out</a>
						</div>
					</div>
					<div class="container sub_tit01">Inspiration for the future society, <br>
creating a new future</div>
				</header>
 

<!-- 본문내용 시작   -->

<div class="container-lg mt-5   ">
	<form name="fileForm" id="fileForm" class="image-upload-wrap">
		<input type="hidden" id="post_num" name="post_num" value="${viewPost.post_num }" />
	<input type="hidden" id="boardNum" name="boardNum" value="B0000001" />
	<input type="hidden" id="user_id" name="user_id" value="tjdwns7761" />
	<h2>게시판 글쓰기</h2>
	<div class="board_w">
		<div class="form-group  mt-3">
		  
		 
			<input type="text" class="form-control" name="text_title" id="text_title" placeholder="제목을 입력하세요" value="${viewPost.post_title}" required/>
		  </div>

		  <div class="form-group  mt-3">
		  
			
    <textarea class="form-control" id="text_content" name="text_content" rows="10"  placeholder="내용을 입력하세요">${viewPost.post_content}</textarea>
		  </div>

		  <!-- 첨부파일 -->
		  <div class="form-group  mt-3">
		  		
        
        
		 
		
		<div class="upload-button" id="btn_add_files">	
		  <p><b class="">첨부파일</b></p>
		  </div>
		  <input id="input_file" multiple="multiple" type="file" name="file" accept="image/*" style="display:none;">
		  <span style="font-size:10px; color: gray;"></span>
		  <div id="data_file_txt">		
			<div id="articlefileChange" class="article">
			<c:forEach var="data" items="${getFileList}" varStatus="num">
         <input type="hidden" id="hdn1_file${num.count}" name="original_file_name" value="${data.original_file_name}">
         <input type="hidden" id="hdn2_file${num.count}" name="save_file_name" value="${data.save_file_name}">
            <div id="div_file${num.count}" onclick="fileDelete1('file${num.count}')">
               <font style="font-size:12px">"${data.original_file_name}"</font>
               <img id="del_img${num.count}" src="/img/icon_minus.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;" />
               <div id="div_file${num.count}">
                  <img id="img${num.count}" src="${data.file_path}${data.save_file_name}" style="width:150px; height:150px; vertical-align: middle;">
               </div>
            </div>
         </c:forEach>			
			</div>
			
		</div>		  	
			<input type="text" class="form-control" id="inputname2" placeholder="첨부파일을 업로드할수있게 해주세요" />
		  </div>

	</div>
	</form>
	<div class="text-center mt-4">       
		<button type="button" class="btn  btn-outline-dark" id="btn_cancel">취소</button> 
		<button type="button" class="btn  btn-pup" id="btn_add">작성완료</button>
	</div>
</div>


<!-- 본문내용 끝  -->

 
<!-- 하단 -->
 
</body>
<div class="footer">
	상호명 : TMC | 대표자 : 홍길동 | 사업자번호 :123-123-12324 | 서울시 종로구 새문안로11 | 대표전화 : 01-123-4546<br>
COPYRIGHT (C) 2021 TMC. ALL RIGHTS RESERVED
</div>
</html>