<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
 $(function(){
	 $('#search').click(function(){
		 pagelist(1);
	 })
	 <c:if test="${!empty param.key}">
	 	$('#key').val("${param.key}")
	 </c:if>
	 	$('#word').val("${param.word}")
		$('#pageNo').val("${param.pageNo}")
 })
 
 function pagelist(cpage){
		var frm = document.getElementById('frm');
		var pageNo = document.getElementById('pageNo');
		pageNo.value=cpage;
		frm.action="/notice"
		frm.submit();
	}
 
 function mvNoticeInfo(no){
	 location.href="/noticeinfo?no="+no
 }
 
 function writeNotice(){
	 if($('#title').val() == ''){
		 alert('제목을 입력하세요!')
		 $('#title').focus()
		 return;
	 }else if($('#contents').val() == ''){
		 alert('내용을 입력하세요!')
		 $('#contents').focus()
		 return;
	 }else{
		 $('#writeForm').attr("action", "/writeNotice")
		 $('#writeForm').submit()
	 }
 }
</script>
<body>
  <jsp:include page="include/header.jsp"/>

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
        <div class="mb-2">
        <c:if test="${userinfo.userid  == 'admin' }">
          <button type="button" id="write-notice" class="btn btn-warning" data-toggle="modal" data-target="#postModal" >글쓰기</button>
        </c:if>
          <form class="form-inline float-right" id="frm">
            <div class="form-group mr-sm-2">
              <select class="form-control" id="key" name="key">
              <option selected value="title">제목</option>
                <option value="contents">내용</option>
                <option value="no">글 번호</option>
              </select>
            </div>
            <div class="form-group mr-sm-2">
                <input type="text" class="form-control" id="word" name="word" onkeypress="if(event.keyCode==13){pagelist(1)}">
                <input type="hidden" 	id="pageNo" 	name="pageNo"   value='${bean.pageNo}'/>
            </div>
            <button type="button" class="btn btn-primary" id="search">검색</button>
          </form>
        </div>
        <div class="p-2 mb-5">        
            <table class="table table-hover mt-3">
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <c:choose>
            <c:when test="${not empty list }">
            <c:forEach var="notice" items="${list }">
            <tbody>
                <tr onclick="mvNoticeInfo(${notice.no})">
                    <td>${notice.no }</td>
                    <td class="selectPost">${notice.title }</td>
                    <td>관리자</td>
                    <td>${notice.viewCnt }</td>
                    <td>${notice.regdate }</td>
                </tr>
            </c:forEach>
            </tbody>
            </c:when>
            <c:otherwise>
            <tbody>
            	<td colspan="5" class="text-center text-danger"><h3>공지사항이 없습니다.</h3></td>
            </tbody>
            </c:otherwise>
            </c:choose>
            </table>
        </div>  
        <div class="mt-3">
            <ul class="pagination justify-content-center">
                <li>${bean.pageLink }</li>
            </ul>
        </div>
    </div>
    </section><!-- End About Section -->
    
  </main><!-- End #main -->

  <jsp:include page="include/footer.jsp"/>

  <a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

  <div class="modal" id="postModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">공지사항 글쓰기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
            <form action="" id="writeForm">
                <div class="form-group">
                  <label for="title">제목:</label>
                  <input type="text" class="form-control" id="title" name="title">
                </div>
                <div class="form-group">
                  <label for="content">내용:</label>
                  <textarea rows="8" class="form-control" id="contents" name="contents"></textarea>
                </div>
                <div class="text-center">
                    <button type="button" class="btn btn-primary" onclick="writeNotice()">글작성</button>
                    <button type="reset" class="btn btn-warning">초기화</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">목록</button>
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

  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <!-- Template Main JS File -->
  <script src="/assets/js/main.js"></script>
  <script src="/assets/js/user.js"></script>

</body>

</html>