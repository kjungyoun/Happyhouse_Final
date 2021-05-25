<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	if('${msg}'){
		alert('${msg}')
		return;
	}
})

function modifyNotice(){
	 if($('#title').val() == ''){
		 alert('제목을 입력하세요!')
		 $('#title').focus()
		 return;
	 }else if($('#contents').val() == ''){
		 alert('내용을 입력하세요!')
		 $('#contents').focus()
		 return;
	 }else{
		 $('#modifyForm').attr("action", "/modifyNotice")
		 $('#modifyForm').submit()
	 }
}

function deleteNotice(){
	var check = confirm("정말 공지사항을 삭제하시겠습니까?");
	if(check){
		location.href="/deleteNotice?no="+${notice.no};
	}
}
</script>
<body>
	<jsp:include page="include/header.jsp" />

	<div class="jumbotron jumbotron-fluid">
		<img src="/assets/img/bg-index.jpg" class="jumbotron__background">
		<div class="container text-white text-center">
			<h1 class="display-4">공지사항</h1>
			<p class="lead"></p>
		</div>
	</div>
	<!-- /.jumbotron -->

	<main id="main">
		<section id="" class="p-1">
			<div class="container">
					<h2 class="title text-center">${notice.title }</h2>
					<div class="row pt-3 pb-3">
					<h5 class="author col-sm-4">작성자: 관리자</h5>
					<h5 class="date col-sm-4">작성일: ${notice.regdate }</h5>
					<h5 class="date col-sm-4">조회수: ${notice.viewCnt }</h5>
					</div>
					<div class="card container-fluid pt-3 pb-3 border clearfix">
					${notice.contents }
					</div>
					
					<br>
					<div class="container pb-3 text-right">
					<button type="button" class="btn btn-warning">
					<a href="${root}/notice" style="color: black;">목록</a>
					</button>
					<c:if test="${userinfo.userid == 'admin' }">
					<button type="button" class="btn btn-success" data-toggle="modal" data-target="#modifyModal" >수정</button>
					<button type="button" class="btn btn-danger" onclick="deleteNotice()">삭제</button>
					</c:if>
				</div>
			</div>
		</section>
		<!-- End About Section -->

	</main>
	<!-- End #main -->

	<jsp:include page="include/footer.jsp" />

	<a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

	<div class="modal" id="modifyModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">공지사항 수정하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<form action="" id="modifyForm">
					<input type="hidden" id="no" name="no" value="${notice.no }">	
						<div class="form-group">
							<label for="title">제목:</label> <input type="text"
								class="form-control" id="title" name="title" value="${notice.title }">
						</div>
						<div class="form-group">
							<label for="contents">내용:</label>
							<textarea rows="8" class="form-control" id="contents" name="contents">${notice.contents }</textarea>
						</div>
						<div class="text-center">
							<button type="button" class="btn btn-primary" onclick="modifyNotice()">수정</button>
							<button type="button" class="btn btn-warning" data-dismiss="modal">목록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Vendor JS Files -->
	<script src="/assets/vendor/jquery/jquery.min.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
	<script src="/assets/vendor/php-email-form/validate.js"></script>
	<script src="/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
	<script src="/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="/assets/vendor/venobox/venobox.min.js"></script>
	<script src="/assets/vendor/aos/aos.js"></script>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<!-- Template Main JS File -->
	<script src="/assets/js/main.js"></script>
	<script src="/assets/js/user.js"></script>

</body>

</html>