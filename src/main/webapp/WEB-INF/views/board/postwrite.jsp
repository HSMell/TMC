<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script>
$(document).ready(function(){
	
	$('#btn_cancel').click(function(){
		var result = confirm("작성한 내용이 저장되지 않습니다.");
		
		if(result) {
			location.replace('/mypage')
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
const totalCount = 1;
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
			let innerHtml = '<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
				+ '<font style="font-size:12px">' + f.name + '</font>'  
				+ '<img src="/img/icon_minus.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
				+ '<div/>' + '<div id="div_file' + fileNum + '" >'
				+ '<img id="img' + fileNum + '" src="' + e.target.result + '" style="width:150px; height:150px; vertical-align: middle;"/>'
				+ '<div/>';
			
			$("#articlefileChange").append(innerHtml);
			
			/* innerHtml = '<div id="div_file' + fileNum + '" >'
				+ '<img id="img' + fileNum + '" src="' + e.target.result + '" style="width:150px; height:150px; vertical-align: middle;"/>'
				+ '<div/>';
			
			$("#articlePreViewChange").append(innerHtml); */
			
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
	fileCount --;
	fileSize = fileSize - content_files[no].size;
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
	
	$.ajax({
		type: "POST",
		enctype: "multipart/form-data",
		url: "requestupload",
		data : formData,
		processData: false,
		contentType: false,
		success: function (data) {			
				alert("작성한 글을 등록 하였습니다.");
				location.href = "/";			
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

	<h2>Board upload_page</h2>
	<form name="fileForm" id="fileForm" class="image-upload-wrap">	
	
	<input type="hidden" id="boardNum" name="boardNum" value="B0000001" />
	<input type="hidden" id="user_id" name="user_id" value="tjdwns7761" />
	<input type="text" name="text_title" id="text_title"placeholder="제목을 입력해주세요">
		<input type="text" name="text_content" id="text_content" placeholder="내용을 입력해주세요">		
        <!-- <i class="fas fa-camera" id="btn_add"></i> -->	
	
		<div class="upload-button" id="btn_add_files">
			<i class="fas fa-camera" aria-hidden="true"></i> 사진 첨부하기
		</div>
        <input id="input_file" multiple="multiple" type="file" name="file" accept="image/*" style="display:none;">
		<span style="font-size:10px; color: gray;"></span> 
		<div id="data_file_txt">		
			<div id="articlefileChange" class="article"></div>	
		</div>	
     </form>
          
     <div class="post_upload_button">       
        <input type="button" value="추가" id="btn_add"/>
        <input type="button" id="btn_cancel" value="취소">
     </div>           

</body>
</html>