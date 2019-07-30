<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<c:import url="/WEB-INF/template/link.jsp"></c:import>
<link rel="stylesheet" href="/css/join.css" />
<style>
	#profileRow {
		padding-bottom:10px;
	}
</style>
</head>
<body>
<div id="header">
    <h1><a href="/"><img src="/img/logo.png" width="40"/><strong>ODEL2</strong> Board</a></h1>
</div>
<div id="content">
    <div class="aux">
     <h2 class="title"><i class="fas fa-hat-wizard"></i> 회원가입 폼</h2>
        <div id="joinBox">
        <%-- 
        프로필 사진은 벌써 업로드 되어있기 때문에 
        multipart/form-data가 아니라
        application/x-www-form-urlencoded 입니다. --%>
            <form  method="post" action="/join">
            	<input type="hidden" id="profileName" name="profile" />
            	<input type="hidden" id="birthDate" name="birthDate" />
                <fieldset>
                    <legend class="screen_out">회원가입폼</legend>
                    <div class="row">
                        <label class="label" for="id">아이디</label>
                        <input id="id" name="id"
                               autocomplete="off"
                               placeholder="영어,숫자로 4~20자 입력"
                               title="영어,숫자로 4~20자 입력"
                               />
                        <div class="msg id"></div>
                    </div><!--//row-->
                    <div class="row">
                        <label class="label" for="nickname">별 명</label>
                        <input id="nickname"
                        autocomplete="off"
                               placeholder="10자 내로 한글,숫자 입력"
                               title="10자 내로 한글,숫자 입력"
                               name="nickname"/>
                        <div class="msg nickname"></div>
                    </div><!--//row-->
                    <div class="row">
                        <label class="label" for="pwd">비밀번호</label>
                        <input type="password" id="pwd"
                               placeholder="4~32자로 입력"
                               title="4~32자로 입력"
                               name="password"/>
                        <div class="msg pwd"></div>
                    </div><!--//row-->
                    <div class="row">
                        <label class="label" for="confirm">비밀번호 확인</label>
                        <input type="password" id="confirm"
                               placeholder="위와 동일하게 입력"
                               title="위와 동일하게 입력"/>
                        <div class="msg confirm"></div>
                    </div><!--//row-->
                    <div class="row">
                        <span class="label">생년월일</span>
                        <div id="birthDate">
                            <label>
                                <input type="text" id="year" 
                                       maxlength="4"
                                       autocomplete="off"
                                       title="태어난 년도를 입력"
                                       placeholder="년(4자리)"/></label>
                            <label>
                                <input type="text" id="month" 
                                       maxlength="2"
                                       autocomplete="off"
                                       title="태어난 월을 입력"
                                       placeholder="월"/>
                            </label>
                            <label>
                                <input type="text" id="date"
                                       autocomplete="off"
                                       title="태어난 일을 입력"
                                       maxlength="2"
                                       placeholder="일"/>
                            </label>
                        </div>
                        <div class="msg birth"></div>
                    </div><!--//row-->
                    <div class="row" id="profileRow">
                        <span class="label">프로필사진</span>
                        <div id="profileBox" class="fas fa-user-circle no_image">
                        <img src="/profile/jw.jpg" width="140" height="140" id="profileImg"/>
                        <label class="fas fa-camera">
                            <input type="file" id="profile"/>
                        </label>
                            <button type="button" class="delete fas fa-times"><span class="screen_out">삭제</span></button>
                        </div><!-- //profileBox -->
                        <div class="msg profile"></div>
                    </div><!--//profileRow -->
                    <div class="box_btn">
                        <button class="btn" type="submit"><i class="fas fa-sign-in-alt"></i> 회원가입</button>
                        <button class="btn" type="reset"><i class="fas fa-redo"></i> 초기화</button>
                        <a class="btn" href="/index"><i class="far fa-list-alt"></i> index으로</a>
                    </div><!--//box_btn -->
                </fieldset>
            </form>
        </div><!--// joinBox -->
<c:import url="/WEB-INF/template/footer.jsp"></c:import>
<script src="/js/jquery.js"></script>
<script src="/js/fix-footer.js"></script>  
<script src="/js/moment-with-locales.js"></script>
<script>

//form
var $joinForm = $("#joinBox>form");

/* 정규 표현식 */

//아이디가  첫글자는 영어로, 영어와 숫자로 4~20글자까지라면
var idReg = /^[a-z|A-Z][\w]{3,19}$/;
//비밀번호가 4~32자로 영어, 숫자
var pwdReg = /^[\w]{4,32}$/;
//image인지 확인하는 정규표현식
var profileReg = /^image/;
//닉네임 정규표현식
var nicknameReg = /^[ㄱ-힣|0-9]{1,10}$/;

//id
var $id = $("#id");
//id msg
var $idMsg = $(".msg.id");

//nickname
var $nickname = $("#nickname");
//nickname msg
var $nicknameMsg = $(".msg.nickname");

//pwd
var $pwd = $("#pwd");
//pwd msg
var $pwdMsg = $(".msg.pwd");

//confirm 
var $confirm = $("#confirm");
//confirm msg
var $confirmMsg = $(".msg.confirm");

//year
var $year = $("#year");
//month
var $month = $("#month");
//date
var $date = $("#date");

var $birthDate = $("#birthDate");

//birth msg
var $birthMsg = $(".msg.birth");

//profile input요소(type file)
var $profile = $("#profile");
//profile msg 
var $profileMsg = $(".msg.profile");
//profileName
var $profileName = $("#profileName");
//profileImg
var $profileImg = $("#profileImg");
//profileBox
var $profileBox = $("#profileBox");

//유저가 이전에 입력한 값(ajax경우 중복 요청을 막기 위해서)
var oldId = null;
var oldNickname = null;
var oldProfile = null;

//유효성검사가 되었는지 확인하는 변수
var isValidId = false;
var isValidNickname = false;
var isValidPwd = false;
var isConfirmPwd = false;
var isValidBirth = false;

/*유효성검사 함수들 */

//년월일이 제대로 되었는지 확인하는 함수
function checkBirthDate() {
	
	var year = $year.val();
	var month = $month.val();
	var date = $date.val();
	
	var birth = moment([year,month-1,date]);
	
	if(birth.isValid()) {
		isValidBirth = true;
		$birthMsg.addClass("ok")
		         .text("아주 좋은 생년월일입니다.");
	}else {
		isValidBirth = false;
		$birthMsg.removeClass("ok")
                 .text("제대로 된 생년월일을 입력해주세요.");
	}//if~else end
	
}//checkBirthDate() end

function checkConfirmPwd() {
	
	var value = $confirm.val();
	
	if(value.length!=0 && value==$pwd.val()) {
		isConfirmPwd = true;
		$confirmMsg.addClass("ok")
		           .text("비밀번호와 일치합니다.");
	}else {
		isConfirmPwd = false;
		$confirmMsg.removeClass("ok")
        .text("비밀번호와 동일하게 입력해주세요.");
		//$confirm.val("").focus();
	}//if else end
	
}//checkConfirmPwd() end

function checkProfile() {
	
	//jquery객체에서 순수자바스크립트요소객체 얻기
	var profile = $profile.get(0);
	
	//input type=file요소(순수자바스크립트)는 무조건
	//files배열을 가지고 있습니다.
	
	//한 개의 파일
	var file = profile.files[0];
		
	//File 객체의 속성
	//- type : MIME( image/jpeg, audio/mp3, video/mp4...)
	//- name : 파일명
	//- lastModified : 최종수정일
	//- size : 파일 크기
	
	if(file==null||file.size<=0) {
		
		$profileMsg.removeClass("ok")
		           .text("제대로 된 파일을 선택해주세요.");
		
		return;
	}//if end
	
	//이미지인지 확인!!
	if(!profileReg.test(file.type)) {
		
		$profileMsg.removeClass("ok")
        .text("이미지 파일을 선택해주세요.");
		
		return;
	}else {
		
		$profileMsg.text("");
		
	}//if~else end
	
	if(oldProfile!=file.name) {
		
	oldProfile = file.name;
	
	//여기에 넘어왔다는 뜻은 유저가 선택한 파일이
	//1바이트이상의 크기이고 이미지 파일이라는 뜻입니다.
	
	//ajax로 넘길 폼을 생성하고
	var form = new FormData();
	
	//우리가 선택한 파일을 붙임
	form.append("type","P");//일반적인 데이터
	
	//1)파라미터명, 2) 파일 3) 파일명
	form.append("uploadImg",file,file.name);
	
	//multipart/form-data로 ajax처리
	$.ajax({
		url:"/ajax/upload",
		dataType:"json",
		type:"POST",//multipart/form-data
		processData:false,//multipart/form-data
		contentType:false,//multipart/form-data
		data:form,
		error:function() {
			alert("사진 서버 점검중!");
		},
		success:function(json) {
			$profileImg.attr("src","/profile/"+json.src);
			$profileName.val(json.src);
			$profileBox.removeClass("no_image");
			
		}//success end
		
	});//ajax() end
	
	}//if end
	
}//checkProfile() end

//비밀번호 유효성검사하는 함수
function checkPwd() {
	
	if(pwdReg.test($pwd.val())) {
		$pwdMsg.addClass("ok").text("좋은 비밀번호입니다.");
		isValidPwd = true;
	}else {
		$pwdMsg.removeClass("ok").text("영어,숫자 4~32글자로 입력해주세요.");
		isValidPwd = false;
	}//if~else end
	
	checkConfirmPwd();
	
}//checkPwd() end

function checkNickname() {
	
    //유저가 입력한 값을 얻어옴
   var value = $nickname.val();
    
    //이전 글자와 현재 글자가 같지 않을때만
   if(oldNickname!=value) { 
	   //현재 글자를 이전글자로 업데이트
	   oldNickname = value;
   
	   if(nicknameReg.test(value)) {
		   
		 	//체크를 다시 시작하니까 무조건 false로
			isValidNickname = false;
		   
		   //ajax작동시작
		   $nicknameMsg.removeClass("ok")
		         .text("확인중...");
		   
		   //application/x-www-form-urlencoded
		   $.ajax({
			   url:"/ajax/user/nickname/"+value,
			   type:"get",
			   dataType:"json",
			   error:function() {
				   
				  alert("서버 점검중!");
				  
			   },
			   success:function(json) {
				   
				   if(json) {
					   isValidNickname = true;
					   $nicknameMsg.addClass("ok").text("아주 좋은 별명입니다.");
				   }else {
					   isValidNickname = false;
					   $nicknameMsg.removeClass("ok").text("이미 사용중이거나 탈퇴한 별명입니다.");
				   }//if~else end
				   
			   }//success end
		   });//$.ajax() end
	        
	   }else {
	        $nicknameMsg.removeClass("ok").text("한글로 1~10글자로 입력해주세요.");
	   }//if~else end
   
   }//if end
	
}//checkNickname() end

//아이디 유효성검사용 함수
function checkId() {
	
    //유저가 입력한 값을 얻어옴
   var value = $id.val();
    
    //이전 글자와 현재 글자가 같지 않을때만
   if(oldId!=value) { 
	   //현재 글자를 이전글자로 업데이트
	   oldId = value;
   
	   if(idReg.test(value)) {
		   
		 	//체크를 다시 시작하니까 무조건 false로
			isValidId = false;
		   
		   //ajax작동시작
		   $idMsg.removeClass("ok")
		         .text("확인중...");
		   
		   $.ajax({
			   url:"/ajax/user/id/"+value,
			   dataType:"json",
			   type:"get",
			   error:function() {
				   
				  alert("서버 점검중!");
				  
			   },
			   success:function(json) {
				   
				   if(json) {
					   isValidId = true;
					   $idMsg.addClass("ok").text("아주 좋은 아이디입니다.");
				   }else {
					   isValidId = false;
					   $idMsg.removeClass("ok").text("이미 사용중이거나 탈퇴한 아이디입니다.");
				   }//if~else end
				   
			   }//success end
		   });//$.ajax() end
	        
	   }else {
	        $idMsg.removeClass("ok").text("첫글자를 영어로, 영어,숫자 4~20글자로 입력해주세요.");
	   }//if~else end
   
   }//if end

}//checkId end

$id.keyup(checkId)
   .blur(checkId)
   .focus();//id에 포커스 지정
   
$nickname.keyup(checkNickname)
         .blur(checkNickname);
   
$pwd.keyup(checkPwd);
   
$confirm.keyup(checkConfirmPwd);  

$year.keyup(checkBirthDate);
$month.keyup(checkBirthDate);
$date.keyup(checkBirthDate);
   
//profile사진이 변경되면
$profile.change(checkProfile);//change() end

//사진 x버튼 눌렀을때 사진 초기화
$(".delete").click(function() {
	$profile.val("");
	$profileName.val("");
	$profileBox.addClass("no_image");
});//click() end

//form submit
$joinForm.submit(function() {

	checkNickname();
	checkPwd();
	checkBirthDate();
	checkProfile();
	
	/*
	console.log("submit 할때");
	console.log(isValidId);
	console.log(isValidNickname);
	console.log(isValidPwd);
	console.log(isConfirmPwd);
	console.log(isValidBirth);
	console.log(!$profileBox.hasClass("no_image"));
	*/
	
	if(!isValidId ||
	   !isValidPwd ||
	   !isConfirmPwd ||
	   !isValidNickname ||
	   !isValidBirth ||
	   $profileBox.hasClass("no_image")
	   ) {
		//console.log("서브밋 안됨");
		return false;
	}//if end
	
	$birthDate.val($year.val()+"-"+$month.val()+"-"+$date.val());
	
});//submit() end

</script>
</body>
</html>