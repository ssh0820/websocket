<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${loginUser==null}">
	<c:redirect url="/index"/>
</c:if>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>까까오톡</title>
<c:import url="/WEB-INF/template/link.jsp"/>	
<link rel="stylesheet" href="/css/chat.css" />
</head>
<body>
<c:import url="/WEB-INF/template/header.jsp"/>	
<h2 class="title"><i class="far fa-comment-dots"></i> 까까오톡</h2>
<div id="chattingSection">
	<div id="chatList">
			<h3 class="screen_out">채팅목록</h3>
			<div id="chatListWrap">
			<ul>
		
			</ul>
			</div>
		</div>
		<!--//.chatList -->
		<div id="inputChatBox">
			<form id="msgForm" action=" " method="post">
				<fieldset>
					<legend class="screen_out">메세지 입력폼</legend>
					<label for="msg" class="screen_out">메세지 입력</label> <input
						name="message" autocomplete="off" id="msg" type="text"
						placeholder="메세지를 입력해주세요" />
					<button id="inputBtn" class="btn" type="submit">입력</button>
				</fieldset>
			</form>
		</div>
		<!--//#inputChatBox -->
		</div>
<c:import url="/WEB-INF/template/footer.jsp"/>
</body>
</html>
    