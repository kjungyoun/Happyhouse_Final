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
<c:set var="gugun" value="${list[0].base.gugun}" />
<script type="text/javascript">
$(document).ready(function(){
	var moveLatLon = new kakao.maps.LatLng('${position.lat}', '${position.lng}');
	map.setCenter(moveLatLon)
	
	var city = '${list[0].base.city}'
	var gugun = '${list[0].base.gugun}'
	console.log(city)
	console.log(gugun)
		getCityInfo(city, gugun)
	
})
</script>

<script type="text/javascript">
function getCityInfo(city,gugun){
	
	$.ajax({
		type:'GET',
		url:'/select',
		dataType:'json',
		success: function(result){
			// select box ?????????
			$('#city').find('option').remove().end()
			// List ???????????? option ??????
			$.each(result,function(idx){
				if(city == result[idx]){
				$('#city').append("<option value='"+result[idx]+"' id='"+result[idx]+"' selected>"+result[idx]+"</option>" )					
				}else{
					$('#city').append("<option value='"+result[idx]+"' id='"+result[idx]+"'>"+result[idx]+"</option>" )
				}
			})
			getGugunInfo($('#city').val(),gugun)
		},
		error : function(jqXHR, status, err){
			alert('city ????????? ???????????? ??? ?????? ??????!')
		}
	})
}

function getGugunInfo(city,gugun){
	$.ajax({
		type:'GET',
		url:'/select/'+city,
		dataType:'json',
		success: function(result){
			// select box ?????????
			
			$('#gugun').find('option').remove().end()
			$.each(result,function(idx){
				if(gugun == result[idx]){
					$('#gugun').append("<option value='"+result[idx]+"' id='"+result[idx]+"' selected>"+result[idx]+"</option>" )					
					}else{
						$('#gugun').append("<option value='"+result[idx]+"' id='"+result[idx]+"'>"+result[idx]+"</option>" )
					}
			})
			
			// List ???????????? option ??????
			
		},
		error : function(jqXHR, status, err){
			alert('gugun ????????? ???????????? ??? ?????? ??????!')
		}
	})
}


function getDongInfo(gugun){
	let city = $('#city').val()
	$.ajax({
		type:'GET',
		url:'/select/'+city+'/'+gugun,
		dataType:'json',
		success: function(result){
			// select box ?????????
			$('#dongName').find('option').remove().end().append("<option disabled selected>???</option>")
			
			// List ???????????? option ??????
			$.each(result,function(idx){
				$('#dongName').append("<option value='"+result[idx]+"'>"+result[idx]+"</option>")
			})
		},
		error : function(jqXHR, status, err){
			alert('dong ????????? ???????????? ??? ?????? ??????!')
		}
	})
}
</script>


<script type="text/javascript">
function pagelist(cpage) {
	//input ????????? hidden?????? ????????? page??? ????????? ????????? ?????? ?????? 
	$("#pageNo").val(cpage);
	var frm = $("#form");
	frm.attr('action', "${root}/house/search");
	frm.submit();
}
</script>
<script>
	$.getJSON('http://api.openweathermap.org/data/2.5/weather?lat=${position.lat}&lon=${position.lng}&lang=kr&appid=eac3412e6674fc5eae67a740c821e3f4'
			,function(data){
		var $type = data.weather[0].description;
		var $icon = data.weather[0].icon;
		var $cTemp = Math.round(data.main.temp-273.15);
		var $hTemp = Math.round(data.main.feels_like-273.15);
		var $minTemp = Math.round(data.main.temp_min-273.15);
		var $maxTemp = Math.round(data.main.temp_max-273.15);
		var $humidity = data.main.humidity;
		var $probability = data.clouds.all;
		
		$('.clowtemp').append($minTemp + "??C");
		$('.chightemp').append($maxTemp + "??C");
		$('.chumidity').append($humidity + "%");
		$('.ctype').append($type+" ");
		$('.cprobability').append($probability + "%");	
		$('.chtemp').append($hTemp + "??C");
		$('.ctemp').append(" ("+$cTemp + "??C)");
		$('.icon').append("<img src=http://openweathermap.org/img/wn/"+$icon+"@2x.png>")
	});
</script>

<script>
	$.getJSON('http://api.openweathermap.org/data/2.5/air_pollution?lat=${position.lat}&lon=${position.lng}&appid=eac3412e6674fc5eae67a740c821e3f4'
			,function(data){
		var $airQual = data.list[0].main.aqi;
		var $CO = data.list[0].components.co;
		var $O3 = data.list[0].components.o3;
		var $pm2_5 = data.list[0].components.pm2_5;
		var $pm10 = data.list[0].components.pm10;
		
		var c;
		var o;
		var p25;
		var p10;
				
		if($airQual == 1)
			$airQual = "?????? ??????";
		else if ($airQual == 2)
			$airQual = "??????";
		else if ($airQual == 3)
			$airQual = "??????";
		else if ($airQual == 4)
			$airQual = "??????";
		else if ($airQual == 5)
			$airQual = "?????? ??????";
		
		if($pm10>0 && $pm10<=30)
			p10="??????";
		else if($pm10>30 && $pm10<=80)
			p10="??????";
		else if($pm10>80 && $pm10<150)
			p10="??????";
		else if($pm10>150)
			p10="?????? ??????";
		
		if($pm2_5>0 && $pm2_5<=15)
			p25="??????";
		else if($pm2_5>15 && $pm2_5<=35)
			p25="??????";
		else if($pm2_5>35 && $pm2_5<75)
			p25="??????";
		else if($pm2_5>75)
			p25="?????? ??????";
		
		if($O3>0 && $O3<=80)
			o="??????";
		else if($O3>80 && $O3<=150)
			o="??????";
		else if($O3>150 && $O3<200)
			o="??????";
		else if($O3>200)
			o="?????? ??????";
		
		if($CO>0 && $CO<=300)
			c="??????";
		else if($CO>300 && $CO<=900)
			c="??????";
		else if($CO>900 && $CO<1500)
			c="??????";
		else if($CO>1500)
			c="?????? ??????";
		
		$('.airQ').append($airQual);
		$('.co').append($CO + " ???/???" + " (" + c +")");
		$('.o3').append($O3 + " ???/???" + " (" + o +")");
		$('.pm25').append($pm2_5 + " ???/???" + " (" + p25 +")");
		$('.pm10').append($pm10 + " ???/???" + " (" + p10 +")");
	});
</script>

</head>

<body>
	<jsp:include page="include/header.jsp" />

	<div class="jumbotron jumbotron-fluid">
		<img src="/assets/img/????????????2.jpg" class="jumbotron__background">
		<div class="container text-white text-center">
			<h4 class="display-4">?????? ????????? ????????? ?????? ????????? ???????????????</h4>
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
							<input type='hidden' name='pageNo' id="pageNo" /> <input
								type='hidden' name='dong' id="dong" value="${list[0].dong }" /> <input
								type='hidden' name='code' id="code" value="${list[0].code }" />
							<input type='hidden' name='aptName' id="aptName"
								value="${list[0].aptName }" /> <input type='hidden' name='lat'
								id="lat" value="${position.lat }" /> <input type='hidden'
								name='lng' id="lng" value="${position.lng }" />
							<div class="form-group d-inline-block">
								<select class="form-control" id="city"
									onchange="getGugunInfo(this.value)">
									<option disabled selected>???/???</option>
								</select>
							</div>
							<div class="form-group d-inline-block">
								<select class="form-control" id="gugun" name="gugun"
									onchange="getDongInfo(this.value)">
									<option disabled selected>???/???/???</option>
								</select>
							</div>
							<div class="form-group d-inline-block">
								<select class="form-control" id="dongName" name="dongName">
									<option selected value="${bean.dong }">${bean.dong }</option>
								</select>
							</div>

							<div class="form-group d-inline-block">
								<button type="button" class="btn btn-primary mb-1"
									onclick="mvLocation()"><i class="bx bx-search mr-1"></i>??????</button>
							</div>
							<button type="button" class="btn btn-danger" onclick="commercial()"><i class="bx bx-store mr-1"></i>??????</button>
							<button type="button" class="btn btn-success" data-toggle="modal"
								data-target="#weatherModal"><i class="bx bx-cloud mr-1"></i>??????</button>
							<button type="button" class="btn btn-warning" data-toggle="modal"
								data-target="#airpollutionModal"><i class="bx bx-health mr-1"></i>?????????</button>
							<button type="button" class="btn" id="subwayBtn" style="background-color: violet; color:white" value="false" onclick="subwayInfo(this.value)"><i class="bx bx-trip mr-1"></i>????????? ???</button>
							<button type="button" class="btn" style="background-color: pink" id="busBtn" value="false" onclick="busInfo(this.value)"><i class="bx bx-bus mr-1"></i>?????? ?????????</button>

						</form>
						
						<div class="map_wrap">

						<ul id="category" style="display:none">
							<li id="BK9" data-order="0"><span class="category_bg bank"></span>
								??????</li>
							<li id="MT1" data-order="1"><span class="category_bg mart"></span>
								??????</li>
							<li id="PM9" data-order="2"><span
								class="category_bg pharmacy"></span> ??????</li>
							<li id="OL7" data-order="3"><span class="category_bg oil"></span>
								?????????</li>
							<li id="CE7" data-order="4"><span class="category_bg cafe"></span>
								??????</li>
							<li id="CS2" data-order="5"><span class="category_bg store"></span>
								?????????</li>
						</ul>
					</div>
					<div id="map"
							style="width: 1200px; height: 450px; margin-left: auto; margin-right: auto; "></div>
					</div>



					<div class="col-lg-12 ml-auto mt-5" data-aos="fade-up" style="margin-left: auto; margin-right: auto;">
						<c:choose>
							<c:when test="${empty list }">
								<h3 class="text-danger">????????? ?????? ????????? ????????????.</h3>
							</c:when>
							<c:when test="${not empty list}">
								<ul class="nav nav-tabs flex-column">
									<div>
										<h1 class="title">?????? ??????</h1>
										<div class="separator-2"></div>
										<c:forEach var="house" items="${list}">
											<div class="media margin-clear mt-3">
												<div class="media-body" id='houseInfo'>
													<h4 class="text-success">${house.aptName}?????????</h4>
													<h6 class="media-heading" id="">?????? ?????? :
														${house.base.city} ${house.base.gugun} ${house.dong}</h6>
													<h6 class="media-heading" id="">????????? ?????? :
														${house.jibun}</h6>
													<h6 class="media-heading" id="">????????? ?????? :
														${house.aptName} ?????????</h6>
													<h6 class="media-heading" id="">?????? ?????? (???) :
														${house.dealAmount}</h6>
													<h6 class="media-heading" id="">?????? ?????? :
														${house.buildYear}</h6>
													<h6 class="media-heading" id="">?????? ?????? :
														${house.dealYear}??? ${house.dealMonth}??? ${house.dealDay}???</h6>
													<h6 class="media-heading" id="">????????? ?????? :
														${house.area}???(?????? ??????)</h6>
													<h6 class="media-heading" id="">????????? ??? :
														${house.floor}???</h6>
												</div>
											</div>
											<hr>
										</c:forEach>
									</div>
									<div style="margin-left: auto; margin-right: auto;">${bean.pageLink}</div>
								</ul>
							</c:when>
							<%-- <c:otherwise>
								<ul class="nav nav-tabs flex-column">
									<div>
										<h3 class="title">?????? ??????</h3>
										<div class="separator-2"></div>
										<c:forEach var="house" items="${list}">
											<div class="media margin-clear">
												<div class="media-body">
													<h4>
														<a href="${root}/house/search?key=dong&word=${house.dong}">${house.dong }</a>
													</h4>
													<h6 class="media-heading" id="">?????? ?????? :
														${house.base.city} ${house.base.gugun} ${house.dong}</h6>
													<h6 class="media-heading" id="">????????? ?????? :
														${house.jibun}</h6>
													<h6 class="media-heading" id="">????????? ?????? :
														${house.aptName} ?????????</h6>
													<h6 class="media-heading" id="">?????? ?????? (???) :
														${house.dealAmount}</h6>
													<h6 class="media-heading" id="">?????? ?????? :
														${house.buildYear}</h6>
													<h6 class="media-heading" id="">?????? ?????? :
														${house.dealYear}??? ${house.dealMonth}??? ${house.dealDay}???</h6>
													<h6 class="media-heading" id="">????????? ?????? :
														${house.area}???(?????? ??????)</h6>
													<h6 class="media-heading" id="">????????? ??? :
														${house.floor}???</h6>
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
	<!-- ?????? ?????? Modal  -->
	<!-- The Modal -->
	<div class="modal fade" id="weatherModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title"><i class="bx bx-sun mr-1" style="color:red"></i>${list[0].dong } ?????? ??????</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<h4 class="icon ctype ctemp"></h4>
					<div class="cprobability">????????????: </div>
					<div class="chumidity">??????: </div>
					<div class="chightemp">????????????: </div>
					<div class="clowtemp">????????????: </div>
					<div class="chtemp">????????????: </div>
					<br>
					<h6 class="link">
       					<a href="https://www.weather.go.kr/w/index.do" target="_blank">?????? ?????? ????????? ????????????</a>
    				</h6>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">???
						??????</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="airpollutionModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title"><i class="bx bx-run mr-1"></i>${list[0].dong } ????????? ??????</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<h4 class="airQ">????????? ??????: </h4>
					<br>
					<div class="pm10">???????????? ??????: </div>
					<div class="pm25">??????????????? ??????: </div>
					<div class="co">??????????????? ??????: </div>
					<div class="o3">?????? ??????: </div>
					<br>
					<h6 class="link">
       					<a href="https://www.airkorea.or.kr/web" target="_blank">????????? ?????? ????????? ????????????</a>
    				</h6>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">???
						??????</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Template Main JS File -->
	<script src="/assets/js/main.js"></script>
	<script src="/assets/js/user.js"></script>
	<script src="/assets/js/map.js"></script>
</body>

</html>