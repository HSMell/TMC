<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#logoutBtn").on("click", function(){
		location.href="/logout";
	});
});
</script>
</head>
<body>
<h1>안녕하세요</h1>
<button type="button" id="logoutBtn">로그아웃</button>
</body>
</html>