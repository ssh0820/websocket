<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>게시글 ${article==null?"쓰기":"수정"}</title>
<c:import url="/WEB-INF/template/link.jsp"/>	
<link rel="stylesheet" href="/css/form.css" />
</head>
<body>
<c:import url="/WEB-INF/template/header.jsp"/>	
	<h2 class="title"><i class="fas fa-pen-nib"></i> 게시글 ${article==null?"쓰기":"수정"}</h2>
	<div id='formBox'>
		<!--서버로 데이터를 보내는 폼 -->
		<form id="writeForm" action="/article" method="post">
			<c:if test="${article!=null}">
			<input type="hidden" name="no" value="${no}"/>
			<input type="hidden" name="_method" value="PUT"/>
			</c:if>
			<input type="hidden" name="writer" value="${loginUser.nickname}"/>
			<input type="hidden" name="writerNo" value="${loginUser.no}"/>
			<input type="hidden" name="profile" value="${loginUser.profile}"/>
			<fieldset>
				<legend class="screen_out">글${article==null?"쓰기":"수정"}폼</legend>
				<div id="titleBox">
					<label for="title">제 목</label>
					<input type="text" id="title"
					value="${article.title }"
					 name="title" placeholder="제목을 입력하세요"/>
				</div>
				<textarea id="contents"
				name="contents" placeholder="내용을 입력하세요.">${article.contents}</textarea>
				<div class="box_btn">
					<button class="btn" type="submit"><i class="fas fa-pen-nib"></i> 글${article==null?"쓰기":"수정"}</button>
					<button class="btn" type="reset"><i class="fas fa-redo"></i> 취 소</button>
					<a class="btn" href="/"><i class="far fa-list-alt"></i> 게시판으로</a>
				</div>
			</fieldset>
		</form>
	</div>
<c:import url="/WEB-INF/template/footer.jsp"/>
</body>
</html>
    