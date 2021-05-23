<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91faec44501a2bd12af0827ba9208626&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=91faec44501a2bd12af0827ba9208626&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if('${msg}'){
			alert('${msg}')
			$('#loginModal').modal({
				fadeDuration: 250
			})
		}	
		// 웹 페이지 시작시 city 정보 select box에 담기
		getCityInfo();
		})
</script>

<body>
<jsp:include page="include/header.jsp"/>
  <!-- ======= Hero Section ======= -->
  <section id="hero" class="d-flex flex-column justify-content-center align-items-center">
    <div class="container text-center text-md-left" data-aos="fade-up">
      <h1>Welcome to HappyHouse</h1>
      <h2>HappyHouse에서 주택 실거래가를 검색하고 상권 정보와 환경 정보를 볼 수 있어요!</h2>
      <a href="#features" class="btn-get-started scrollto">실거래가 검색하러 가기</a>
    </div>
  </section><!-- End Hero -->

  <main id="main">
    <!-- ======= About Section ======= -->
    <section id="about" class="about">
      <div class="container">

        <div class="row">
          <div class="col-xl-6 col-lg-7" data-aos="fade-right">
            <img src="/assets/img/about-bg.jpeg" class="img-fluid" alt="">
          </div>
          <div class="col-xl-6 col-lg-5 pt-5 pt-lg-0">
            <h3 data-aos="fade-up">About Happy House</h3>
            <p data-aos="fade-up">
              SSAFY 5기 8반 김정윤 조혜민 SpringBoot Project 입니다.
            </p>
            <div class="icon-box" data-aos="fade-up">
              <i class="bx bx-receipt"></i>
              <h4>관리자 아이디와 비밀번호</h4>
              <p>아이디가 'admin'이면 모두가 관리자입니다.</p>
            </div>

            <div class="icon-box" data-aos="fade-up" data-aos-delay="100">
              <i class="bx bx-cube-alt"></i>
              <h4>SpringBoot</h4>
              <p>SpringBoot를 이용한 웹페이지 입니다.</p>
            </div>
          </div>
        </div>

      </div>
    </section><!-- End About Section -->

    <!-- ======= Services Section ======= -->
    <section id="services" class="services section-bg">
      <div class="container">

        <div class="section-title" data-aos="fade-up">
          <h2>Services</h2>
          <p>저희 HappyHouse에서 제공하는 서비스들은 아래와 같습니다.</p>
        </div>

        <div class="row">
          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0" data-aos="fade-up">
            <div class="icon-box icon-box-pink">
              <div class="icon"><i class="bx bx-tachometer"></i></div>
              <h4 class="title"><a href="">실거래가 검색</a></h4>
              <p class="description">선택한 지역의 아파트 실거래가를 동별로 그리고 아파트별로 검색할 수 있습니다.</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="100">
            <div class="icon-box icon-box-cyan">
              <div class="icon"><i class="bx bxl-dribbble"></i></div>
              <h4 class="title"><a href="">주변 상권 정보</a></h4>
              <p class="description">선택한 아파트 주변 동네업종 정보를 확인할 수 있습니다.</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="200">
            <div class="icon-box icon-box-green">
              <div class="icon"><i class="bx bx-world"></i></div>
              <h4 class="title"><a href="">대기오염 정보</a></h4>
              <p class="description">선택한 지역의 미세먼지 농도 등의 대기오염 정보를 확인할 수 있습니다.</p>
            </div>
          </div>

          <div class="col-md-6 col-lg-3 d-flex align-items-stretch mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="300">
            <div class="icon-box icon-box-blue">
              <div class="icon"><i class="bx bx-file"></i></div>
              <h4 class="title"><a href="">공지사항</a></h4>
              <p class="description">관리자는 공지사항을 작성, 수정, 삭제, 검색할 수 있습니다.</p>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Services Section -->

    <!-- ======= Features Section ======= -->
    <section id="features" class="features">
      <div class="container" data-aos="fade-up">
    <div class="card">
    <div class="card-header bg-dark"><h2 class="text-center text-light card-title">아파트/주택 실거래가 검색</h2></div>
    <div class="card-body">
		<div class="text-center" style="margin-top: 10px;">
            <form>
                  <div class="form-group d-inline-block">
                    <select class="form-control" id="city" name="city" onchange="getGugunInfo(this.value)">
                      <option disabled selected value="">시/도</option>
                    </select>
                  </div>
                  <div class="form-group d-inline-block">
                    <select class="form-control" id="gugun" name='gugun' onchange="getDongInfo(this.value)">
                      <option disabled selected>시/구/군</option>
                    </select>
                  </div>
                  <div class="form-group d-inline-block">
                    <select class="form-control" id="dong" name='dong'>
                      <option disabled selected>동</option>
                    </select>
                  </div>
                  
                  <div class="form-group d-inline-block">
                    <button type="button" class="btn btn-primary mb-1" onclick="mvLocation()">검색</button>
                  </div>
                </form>
            </div>
            
			<!-- ============ Kakao Map API ============ -->
            <div id="map" style="width:1000px;height:600px; margin-left: auto; margin-right: auto"></div>
            
            
	</div> 
    <div class="card-footer">
		<div class="text-center">
                <button type="button" class="btn btn-success" onclick="location.href='/pollutionInfo'">환경정보 보러가기</button>
              <button type="button" class="btn btn-warning ml-2" onclick="location.href='/shopInfo'">주변상권 보러가기</button>
              <button type="button" class="btn btn-primary ml-2" onclick="location.href='/house/search'">상세정보 보러가기</button>
           </div>   
	</div>
  </div>     
 	</div>
  		
    </section><!-- End Features Section -->
   
    <!-- ======= Team Section ======= -->
    <section id="team" class="team section-bg">
      <div class="container">

        <div class="section-title" data-aos="fade-up">
          <h2>Team</h2>
          <p>서울 8반 7조 김정윤 조혜민 입니다.</p>
        </div>

        <div class="row">
          <div class="col-xl-3 col-lg-3 col-md-3" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
            </div>
          </div>
          <div class="col-xl-3 col-lg-3 col-md-3" data-aos="fade-up">
            <div class="member">
              <img src="/assets/img/team/jyyy.jpg" class="img-fluid" alt="">
              <div class="member-info">
                <div class="member-info-content">
                  <h4>김정윤</h4>
                </div>
                <div class="social">
                  <a href="https://www.instagram.com/jungyoun729/"><i class="icofont-facebook"></i></a>
                  <a href="https://www.instagram.com/jungyoun729/"><i class="icofont-instagram"></i></a>
                </div>
              </div>
            </div>
          </div>
          
          <div class="col-xl-3 col-lg-3 col-md-3" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
              <img src="/assets/img/team/hmin.jpg" class="img-fluid" alt="">
              <div class="member-info">
                <div class="member-info-content">
                  <h4>조혜민</h4>
                </div>
                <div class="social">
                  <a href="https://instagram.com/heyming_c"><i class="icofont-facebook"></i></a>
                  <a href="https://instagram.com/heyming_c"><i class="icofont-instagram"></i></a>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-lg-3 col-md-3" data-aos="fade-up" data-aos-delay="100">
            <div class="member">
            </div>
          </div>
        </div>

      </div>
    </section><!-- End Team Section -->

  </main><!-- End #main -->

<jsp:include page="include/footer.jsp"/>
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
  <script src="/assets/js/map.js"></script>
<script   src="/assets/js/selectbox.js"></script>

</body>

</html>