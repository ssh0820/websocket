<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<header id="header">
	<h1><a href="/"><img src="/img/logo.png" width="40"/><strong>ODEL2</strong> Board</a></h1>
	<c:choose>
	<c:when test="${loginUser!=null}">
	<div id="loginBox">
        <h2 class="screen_out">유저정보</h2>
        <img
         src="/profile/${loginUser.profile}" width="60" height="60" 
         alt="${loginUser.nickname }" 
         title="${loginUser.nickname }"/>
        <button form="logoutForm" class="btn"><i class="fas fa-sign-out-alt"></i> 로그아웃</button>
		<form id="logoutForm" action="/session" method="post">
			<input type="hidden" name="_method" value="DELETE">
		</form>
    </div><!--// loginBox  -->
    </c:when>
    <c:otherwise>
	<!-- 로그아웃이 되어있으면 보여주는 박스 -->
	<div id="logoutBox">
		<h2 class="screen_out">로그인</h2>
		<form action="/session" method="post">
			<fieldset>
				<legend class="screen_out">로그인 폼</legend>
					<label for="id" class="screen_out">아이디</label>
					<input type="text" placeholder="아이디"
						   id="id" tabindex="1"	
						   accesskey="i"
						   name="id"/>
					<label for="pwd" class="screen_out">비밀번호</label>
					<input type="password" accesskey="p"
						   placeholder="비밀번호"
						   id="pwd" name="password" tabindex="2" />
					<button class="btn" accesskey="l"
							tabindex="3" type="submit"><i class="fas fa-sign-in-alt"></i> 로그인</button>
					<a href="/join" tabindex="4" accesskey="j"
					   class="join">회원가입</a>
			</fieldset>
		</form>
	</div><!--// logoutBox -->
	</c:otherwise>
	</c:choose>
</header>
<main id="content">
	<div class="aux">