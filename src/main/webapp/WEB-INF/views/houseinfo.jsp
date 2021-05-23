<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value='${pageContext.request.contextPath}' />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>HappyHouse</title>
<!-- Favicons -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="/assets/img/favicon.png" rel="icon">
<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
<link href="/assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="/assets/vendor/owl.carousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="/assets/vendor/venobox/venobox.css" rel="stylesheet">
<link href="/assets/vendor/aos/aos.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91faec44501a2bd12af0827ba9208626&libraries=services,clusterer,drawing"></script>
<!-- Template Main CSS File -->
<link href="/assets/css/style.css" rel="stylesheet">


<!-- 
<script type="text/javascript">
	$(function() {
		//검색 버튼에 이벤트 연결
		$('#submitBtn').click(
				function() {
					pagelist(1);
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
						level : 3
					// 지도의 확대 레벨
					};

					// 지도를 생성합니다    
					var map = new kakao.maps.Map(mapContainer, mapOption);

					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다
					geocoder.addressSearch('${param.gugun} ${param.dong}', function(result,
							status) {

						// 정상적으로 검색이 완료됐으면 
						if (status === kakao.maps.services.Status.OK) {

							var coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);

							// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							map.setCenter(coords);
						}
					});

				})
	})
</script> -->

<script type="text/javascript">
function pagelist(cpage) {
	//input 양식의 hidden으로 선언된 page에 요청된 페이지 정보 셋팅 
	$("#pageNo").val(cpage);
	var frm = $("#form");
	frm.attr('action', "${root}/house/search");
	frm.submit();
}
</script>

</head>

<body>
	<jsp:include page="include/header.jsp" />

	<div class="jumbotron jumbotron-fluid">
		<img src="/assets/img/미세먼지2.jpg" class="jumbotron__background">
		<div class="container text-white text-center">
			<h4 class="display-4">주변 지역의 아파트 거래 정보를 확인하세요</h4>
			<p class="lead"></p>
		</div>
	</div>
	<!-- /.jumbotron -->

	<main id="main">
		<section id="airinfo" class="p-1">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 ml-auto" data-aos="fade-down">
						<form id="form">
							<input type='hidden' name='pageNo' id="pageNo" />
							<input type='hidden' name='dong'  value="${list[0].dong }"/>
							<input type='hidden' name='code' id="code" value="${list[0].code }" />
							<input type='hidden' name='aptName' id="aptName" value="${list[0].aptName }" />
							<div class="form-group d-inline-block">
								<select class="form-control" id="city"
									onchange="getGugunInfo(this.value)">
									<option disabled selected value="all">시/도</option>
								</select>
							</div>
							<div class="form-group d-inline-block">
								<select class="form-control" id="gugun" name="gugun"
									onchange="getDongInfo(this.value)">
									<option disabled selected>시/구/군</option>
								</select>
							</div>
							<div class="form-group d-inline-block">
								<select class="form-control" id="dong" name="dong"
									value="${bean.word}">
									<option disabled selected>동</option>
								</select>
							</div>

							<div class="form-group d-inline-block">
								<button type="button" class="btn btn-primary mb-1"
									onclick="mvLocation()">검색</button>
							</div>
							<button type="button" class="btn btn-info" onclick="commercial()">상권
								정보</button>
							<button type="button" class="btn btn-success" data-toggle="modal"
								data-target="#envModal">환경 정보</button>

						</form>


						<%-- <form id="form">
						<input type='hidden' name='pageNo' id="pageNo"/>
						<div class="form-group d-inline-block">
						  <select class="form-control" id="key" name="key">
							<option value="all">전체 검색</option>
							<option value="dong">동으로 검색</option>
							<option value="AptName">아파트로 검색</option>
						  </select>
						</div>
						<div class="form-group d-inline-block">
						   <input type="text" class="form-control" name="word" value="${bean.word}">
						</div>
				
						<div class="form-group d-inline-block">
						  <button  id="submitBtn" class="btn btn-primary mb-1">검색</button>
						</div>
					  </form>  --%>
						<div id="map"
							style="width: 1200px; height: 450px; margin-left: auto; margin-right: auto"></div>

						<!-- 						<iframe
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3168.5607561223096!2d126.74783201543875!3d37.423855740043976!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b7b13aab9ed93%3A0x3abb0d0829c86fdb!2z7Iqk7YOA67KF7IqkIOyduOyynOyEnOywveygkA!5e0!3m2!1sko!2skr!4v1615476247568!5m2!1sko!2skr"
							width="1200" height="450" style="border: 0" class="mb-3">
						</iframe> -->
					</div>



					<div class="col-lg-12 ml-auto" data-aos="fade-up">
						<c:choose>
							<c:when test="${empty list }">
								<h3 class="text-danger">조회할 상품 정보가 없습니다.</h3>
							</c:when>
							<c:when test="${not empty list}">
								<ul class="nav nav-tabs flex-column mt-3">
									<div>
										<h1 class="title">거래 정보</h1>
										<div class="separator-2"></div>
										<c:forEach var="house" items="${list}">
											<div class="media margin-clear mt-3">
												<div class="media-body">
													<h4>
														<a
															href="${root}/house/search?key=AptName&word=${house.aptName}">${house.aptName}
															아파트</a>
													</h4>
													<h6 class="media-heading" id="">지역 정보 :
														${house.base.city} ${house.base.gugun} ${house.dong}</h6>
													<h6 class="media-heading" id="">아파트 지번 :
														${house.jibun}</h6>
													<h6 class="media-heading" id="">아파트 이름 :
														${house.aptName} 아파트</h6>
													<h6 class="media-heading" id="">거래 가격 (만) :
														${house.dealAmount}</h6>
													<h6 class="media-heading" id="">건축 연도 :
														${house.buildYear}</h6>
													<h6 class="media-heading" id="">거래 날짜 :
														${house.dealYear}년 ${house.dealMonth}월 ${house.dealDay}일</h6>
													<h6 class="media-heading" id="">아파트 평수 :
														${house.area}㎡(제곱 미터)</h6>
													<h6 class="media-heading" id="">아파트 층 :
														${house.floor}층</h6>
												</div>
											</div>
											<hr>
										</c:forEach>
									</div>
									<div>${bean.pageLink}</div>
								</ul>
							</c:when>
							<%-- <c:otherwise>
								<ul class="nav nav-tabs flex-column">
									<div>
										<h3 class="title">거래 정보</h3>
										<div class="separator-2"></div>
										<c:forEach var="house" items="${list}">
											<div class="media margin-clear">
												<div class="media-body">
													<h4>
														<a href="${root}/house/search?key=dong&word=${house.dong}">${house.dong }</a>
													</h4>
													<h6 class="media-heading" id="">지역 정보 :
														${house.base.city} ${house.base.gugun} ${house.dong}</h6>
													<h6 class="media-heading" id="">아파트 지번 :
														${house.jibun}</h6>
													<h6 class="media-heading" id="">아파트 이름 :
														${house.aptName} 아파트</h6>
													<h6 class="media-heading" id="">거래 가격 (만) :
														${house.dealAmount}</h6>
													<h6 class="media-heading" id="">건축 연도 :
														${house.buildYear}</h6>
													<h6 class="media-heading" id="">거래 날짜 :
														${house.dealYear}년 ${house.dealMonth}월 ${house.dealDay}일</h6>
													<h6 class="media-heading" id="">아파트 평수 :
														${house.area}㎡(제곱 미터)</h6>
													<h6 class="media-heading" id="">아파트 층 :
														${house.floor}층</h6>
												</div>
											</div>
											<hr>
										</c:forEach>
									</div>
									<div>${bean.pageLink}</div>
								</ul>
							</c:otherwise> --%>
						</c:choose>
					</div>
				</div>
			</div>
		</section>
		<!-- End About Section -->
	</main>
	<!-- End #main -->
	<jsp:include page="include/footer.jsp" />

	<a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

	<!-- Vendor JS Files -->
	<script src="/assets/vendor/jquery/jquery.min.js"></script>
	<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
	<script src="/assets/vendor/php-email-form/validate.js"></script>
	<script src="/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
	<script src="/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="/assets/vendor/venobox/venobox.min.js"></script>
	<script src="/assets/vendor/aos/aos.js"></script>

	<!-- Template Main JS File -->
	<script src="/assets/js/main.js"></script>
	<script src="/assets/js/user.js"></script>
	<!-- 환경 정보 Modal  -->
	<!-- The Modal -->
	<div class="modal fade" id="envModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">환경 정보</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">Modal body..</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">창
						닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Template Main JS File -->
	<script src="/assets/js/main.js"></script>
	<script src="/assets/js/user.js"></script>
	<script src="/assets/js/map.js"></script>
	<script src="/assets/js/selectbox.js"></script>
</body>

</html>