<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Lost City</title>
    <c:import url="/WEB-INF/template/link.jsp"/>
    <link rel="stylesheet" href="/css/index.css" /> 	
</head>
<body>
<div id="bg"></div>
<div id="content">
<div class="wrap_sign">
     <div class="box_img">
     </div><!--//box_img -->
   <div class="section_signin">
       <h1>로스트 시티</h1>
       <div id="signinBox">
           <h2 class="screen_out">로그인</h2>
           <form id="signinForm" action="/session" method="post">
               <fieldset>
                  <legend class="screen_out">로그인 폼</legend>
                  <div class="area_login">
                     <div class="row">
                       <label for="id" class="screen_out">아이디</label>
                       <input type="text" placeholder="아이디 입력"
                       id="id" tabindex="1"
                       accesskey="i"
                       name="id"/>
                   </div><!--//row -->
                   <div class="row">
                    <label for="pwd" class="screen_out">비밀번호</label>
                    <input type="password" accesskey="p"
                    placeholder="비밀번호 입력"
                    id="pwd" name="password" tabindex="2" />
                                        
                </div><!--//row -->
            </div><!--//area_login-->
            <div class="msg" >${msg }</div>        
            <button class="btn" accesskey="l"
            tabindex="3" type="submit"><i class="fas fa-sign-in-alt"></i> 로그인</button>
        </fieldset>
    </form>
</div><!--// signinBox -->
 <div class="link_join">
    <span>계정이 없으신가요? </span> <a href="/join" tabindex="4" accesskey="j"
    class="join">회원가입</a>
</div><!--//link_join -->
</div><!--//section_signin -->
</div><!--//wrap_sign -->
</div><!--//content -->
<div id="footer">
<address>&copy; 2019 <a href="">jbp.org</a></address>
</div><!--// footer  -->
<script src="/js/fix-footer.js"></script>
<script>
    const $id = $("#id");
    const $pwd = $("#pwd");
    const $img = $(".box_img");
    const $msg = $("div.msg"); 
  // console.log($img);
   $id.on({
        "focus" :function(){
            $img.addClass("step1");
        },
        "blur" : function(){
        	$img.removeClass("step1");
        }
    });
   $pwd.on({
       "focus" :function(){
           $img.addClass("step2");
       },
       "blur" : function(){
    	   $img.removeClass("step2");
       }
   });
   
   
   
   
</script>
</body>
</html>