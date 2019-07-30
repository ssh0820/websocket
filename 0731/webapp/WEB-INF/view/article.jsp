<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>게시글 보기</title>
	<c:import url="/WEB-INF/template/link.jsp"/>
	<link rel="stylesheet" href="/css/article.css">
</head>
<body>
<c:import url="/WEB-INF/template/header.jsp"/>
	<h2 class="title"><i class="far fa-eye"></i> 게시물 보기</h2>
	<article id="contentsBox">
		<div id="infoBox">
			<dl>
				<dt class="screen_out">번호</dt>
				<dd id="no">${article.no }</dd>
				<dt class="screen_out">글쓴이정보</dt>
				<dd class="card_user">
					<img src="/profile/${article.profile }" width="100" />
					<strong>${article.writer}</strong>
				</dd>
				<dt class="screen_out">글쓴시간</dt>
				<dd>
					<time id="regdate">
					<fmt:formatDate value="${article.regdate }"
					pattern="YYYY년 MM월 dd일 HH시 mm분 ss.SSS초"/>
					</time>
				</dd>
				<dt class="screen_out">조회수</dt>
				<dd id="hit">
					<i class="fa fa-eye"></i> ${article.hit }
				</dd>
			</dl>
			<h3 id="title">${article.title }</h3>
		</div>
		<div id="viewerSection">${article.contents }</div>
		<div class="box_btn">
				<button class="btn_like like">
				<i class="fas fa-heart"></i>
				<i class="far fa-heart"></i>
				<span class="screen_out">좋아요</span>
				<strong class="num_like">${article.likes }</strong>
				</button>
			<div id="boxBtn">
				<c:if test="${loginUser.no==article.writerNo }">
				<a href="/article/${no}/update" class="btn" id="modifyBtn"><i class="far fa-edit"></i> 수 정</a>
				<button form="deleteForm" class="btn" id="deleteBtn"><i class="far fa-trash-alt"></i> 삭 제</button>
				</c:if>
				<a href="${header.referer}" class="btn"><i class="far fa-list-alt"></i> 게시판으로</a>
				<form id="deleteForm" action="/article/${no}" method="post">
					<input type="hidden" name="_method" value="DELETE"/>
				</form>
			</div>
		</div>
	</article>
	<div id="replyBox">
		<h3><i class="fa fa-comment"></i> 댓글 <span id="replies">${article.replies }</span>개</h3>
		<c:if test="${loginUser!=null}">
		<div id="formBox">
		<form action="/ajax/reply" method="post">	
			<input type="hidden" name="articleNo" value="${no}">
			<input type="hidden" name="writer" value="${loginUser.nickname}">
			<input type="hidden" name="writerNo" value="${loginUser.no}">
			<input type="hidden" name="profile" value="${loginUser.profile}">
			<textarea maxlength="140" name="contents"
			id="contentsField" placeholder="새 글을 입력합니다."></textarea>
			<button id="writeBtn" class="btn"><i class="fas fa-pencil-alt"></i> 댓글쓰기</button>
		</form>
		</div><!--//formBox-->
		</c:if>
	<div id="replyListBox">
		
	</div><!--//replyListBox -->
	</div><!--//replyBox-->
<c:import url="/WEB-INF/template/footer.jsp"/>
<script type="text/template" id="repliesTmp">
<@ if(replies.length==0) {@>
<p class="no_reply"><i class="fas fa-skull-crossbones"></i> 댓글이 아직 없습니다.</p>
<@}else {@>
<ul>
<@ _.each(replies,function(reply){@>
<li>
	<div class="card_user">
		<img src="/profile/<@=reply.profile@>" width="100"/>
		<strong><@=reply.writer@></strong>
	</div><!-- //card_user -->
	<div class="box_reply">
		<div class="comments"><@=reply.contents@></div>
		<@ if(reply.writerNo == ${loginUser!=null && loginUser.no!=0?loginUser.no:0})  {@>
		<button class="btn delete" data-no="<@=reply.no@>">
			<i class="fas fa-times"></i>
			<span class="screen_out">삭제</span>
		</button>
		<@}@>
		<time class="time" data-time=""><@=moment(reply.regdate).fromNow()@></time>
	</div><!--//box_reply-->
</li>
<@})@>	
</ul>
<@=paginate@>
<@ }@>
</script>
<script src="/js/underscore-min.js"></script>
<script src="/js/moment-with-locales.js"></script>
<script>
	moment.locale("ko");
	_.templateSettings = {interpolate: /\<\@\=(.+?)\@\>/gim,evaluate: /\<\@([\s\S]+?)\@\>/gim,escape: /\<\@\-(.+?)\@\>/gim};

	const repliesTmp = _.template($("#repliesTmp").html());
	const $replyListBox = $("#replyListBox");
	const $replies = $("#replies");
	let pageNo = 1;
	//댓글을 불러오는 함수	
	function getReplyList() {
		
		$.ajax({
			url:"/ajax/article/${no}/reply/page/"+pageNo,
			type:"get",
			dataType:"json",
			error:function(){
				alert("서버 점검중");
			},
			success:function(json) {
				
				$replies.text(json.total);
				
				$replyListBox.html(repliesTmp({paginate:json.paginate,replies:json.replies}));
				
			}
		})
		
	}//getReplyList() end
	
	getReplyList();
	
	
	//페이징 클릭시 페이지 이동(ajax)
	$replyListBox.on("click",".paginate a",function(e) {
		e.preventDefault();
		
		//클릭한 페이지번호
		pageNo = this.dataset.no;
		getReplyList();
	});
	
	<c:if test="${loginUser!=null}">	
	
	const $deleteBtn = $("#deleteBtn");
	
	$deleteBtn.on("click",function() {
		return confirm("정말로 삭제하시겠습니까?");
	});
	
	const $writeForm = $("#formBox form");
	
	const $contentsField = $("#contentsField");
	
	$writeForm.submit(function(e) {
		e.preventDefault();
		
		if($contentsField.val().trim().length==0) {
			alert("내용을 입력해주세요!");
			return;
		}
		
		//form의 정보를 객체로(직렬화)
		let formData = $writeForm.serialize();
		
		$.ajax({
			url:"/ajax/reply",
			type:"post",
			data:formData,
			error:function() {
				alert("서버 점검중!");
			},
			success:function(json) {
				
				if(json) {
					//글쓴 부분 지우기
					$contentsField.val("");	
					getReplyList();
					
				}else {
					alert("입력되지 않았습니다.");
				}//if~else end
				
			}//success end
		})//ajax() end
	});//submit() end
	
	
	//댓글 삭제시 삭제(ajax)
	$replyListBox.on("click",".delete",function(e) {
		e.preventDefault();
		
		//클릭한 페이지번호
		const no= this.dataset.no;
		
		$.ajax({
			url:"/ajax/reply/"+no,
			type:"delete",
			dataType:"json",
			error:function() {
				alert("서버 점껌중!")
			},
			success:function(json) {
				if(json) {
					getReplyList();
				}else {
					alert("삭제되지 않았습니다.");
				}//if~else end
			}//success end
		})//$.ajax end
		
	});//click() end
	</c:if>
</script>

</body>
</html>
    