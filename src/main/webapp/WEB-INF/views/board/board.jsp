<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<h2><a type="hidden" href="postwrite">글 작성</a></h2>
<div>
	<c:forEach var="data" items="${ boardList}" varStatus="num">
		<div class="div_post_num" data-num="${data.post_num }">
		<input type="image" src="${data.file_path}" value="${num.count}" style="width:100px; height:100px;" />
		${data.post_title }<br>
		${data.update_date }<br>
		</div>
		<hr>
	</c:forEach>
</div>
</body>
</html>