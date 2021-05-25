<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <!-- ======= Footer ======= -->
  <footer id="footer">
    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-3 col-md-6">
            <div class="footer-info">
              <h3>HappyHouse</h3>
              <h5>ssafy 5th 서울 8반 </h5>
              <h5>김정윤 조혜민</h5>
            </div>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <div class="container">
      <div class="copyright">
        &copy; Copyright <strong><span>Maxim</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer><!-- End Footer -->
  
    <!-- SignUp Modal -->
  <div class="modal" id="signupModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title text-center mt-3">Create Account</h4>
            <form id="signupform" action="" method="post">
            <input type="hidden" name="type" value="register">
                <div class="form-group input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                </div>
                <input id = "email" name="email" class="form-control" placeholder="Email address" type="email">
                <input id = "emailCheck" name="emailCheck" type="hidden">
                <span class="input-group-btn">
                <button type="button" id="authBtn" onclick="javascript:authentication();" class="btn btn-warning btn-block ml-1"> 인증하기 </button>
                </span>
              </div> <!-- form-group// --> 
              <div class="check_font" id="validId"></div>
              <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                </div>
                <input id = "userid" name="userid" class="form-control" onchange="checkId()" idCheck='' placeholder="ID" type="text"/>
              </div> <!-- form-group// -->
              <div class="form-group input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input id = "userpwd" name="userpwd" class="form-control" placeholder="Create password" type="password">
              </div> <!-- form-group// -->
              <div class="form-group input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input id = "pwdcheck" name="pwdcheck" class="form-control" placeholder="Repeat password" type="password">
              </div> <!-- form-group// -->
              <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="far fa-smile"></i></span>
                </div>
                <input id = "username" name="username" class="form-control" placeholder="Name" type="text">
              </div> <!-- form-group// -->     
              <div class="form-group">
                <button type="button" onclick="javascript:signup();" class="btn btn-primary btn-block"> 가입하기 </button>
              </div> <!-- form-group// -->      
              <p class="text-center">Have an account? <a data-dismiss="modal" data-toggle="modal" href="#loginModal">Log In</a> </p>                                                                 
            </form>
          </article>
        </div>
      </div>
    </div>
  </div>

  <!-- Login Modal -->
  <div class="modal" id="loginModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title text-center mt-3">Login</h4>
            <form id="loginform" action="" method="post">
              <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                </div>
                <input name="userid" id="useridL" class="form-control" placeholder="ID" type="text" onkeypress="if(event.keyCode==13){login()}">
              </div> <!-- form-group// -->
              <div class="form-group input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input name="userpwd" id="userpwdL" class="form-control" placeholder="Password" type="password" onkeypress="if(event.keyCode==13){login()}">
              </div> <!-- form-group// -->
              <div class="form-group">
                <button type="button" onclick="javascript:login();" id="login-btn" class="btn btn-primary btn-block" > 로그인 </button>
              </div> <!-- form-group// -->      
              <p class="text-center">비밀번호를 잊어버리셨나요? <a data-dismiss="modal" data-toggle="modal" href="#findPWModal">비밀번호 찾기</a> </p>                                                                 
            </form>
          </article>
        </div>
      </div>
    </div>
  </div>

  <!-- Find Password Modal -->
  <div class="modal" id="findPWModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title text-center mt-3">비밀번호 찾기</h4>
            <form id="findForm" method="post">
            <input type="hidden" id="type" name="type" value="find">
              <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                </div>
                <input name="useridF" class="form-control" id="useridF" placeholder="ID" type="text">
              </div> <!-- form-group// -->  
              <div class="form-group input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                </div>
                <input name="emailF" class="form-control" id="emailF" placeholder="Email address" type="email">
              </div> <!-- form-group// --> 
              <div class="form-group">
                <button type="button" onclick="findPassword()" class="btn btn-primary btn-block">이메일 전송 </button>
              </div> <!-- form-group// -->      
              <p class="text-center text-success">입력하신 이메일로 임시 비밀번호가 전송됩니다.</p>                                                                 
            </form>
          </article>
        </div>
      </div>
    </div>
  </div>
  
  <!-- changePW Password Modal -->
  <div class="modal" id="changePWModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title text-center mt-3">비밀번호 변경</h4>
            <form id="changeForm" action="/user/changepw" method="POST" >
            <input type="hidden" id="useridN" name="useridN" value="${userid }">
                <div>새 비밀번호:</div> 
              <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input name="userpwdN" class="form-control " id="userpwdN" placeholder="new Password" type="password">
              </div> <!-- form-group// -->  
                <div>새 비밀번호 확인:</div>
              <div class="form-group input-group">
                <div class="input-group-prepend">
                  <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                </div>
                <input name="userpwdN2" class="form-control " id="userpwdN2" placeholder="new Password" type="password">
              </div> <!-- form-group// --> 
              <div class="form-group">
                <button type="button" onclick="changePwd()" class="btn btn-primary btn-block">변경하기</button>
              </div> <!-- form-group// -->      
              <p class="text-center text-success">새로운 비밀번호로 변경됩니다.</p>                                                                 
            </form>
          </article>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Auth Email Modal -->
  <div class="modal" id="authModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-body">
          <article class="card-body mx-auto" style="max-width: 400px;">
            <h4 class="card-title text-center mt-3">이메일 인증</h4>
            <form action="/user/auth/${dice }/${type}" method="POST">
            <input type="hidden" name="type" value="${type }">
            <input type="hidden" name="useridC" value="${userid }">
              <span style="color: green; font-weight: bold;">입력한 이메일로 받은 인증번호를 입력하세요.</span>
              <br> <br>
              <div class="form-group input-group">
                인증번호 입력: <input name="code" class="form-control ml-3" placeholder="인증번호를 입력하세요." type="number">
              </div> <!-- form-group// --> 
              <div class="form-group">
                <button type="submit" class="btn btn-primary btn-block">인증하기 </button>
              </div> <!-- form-group// -->                                                                    
            </form>
          </article>
        </div>
      </div>
    </div>
  </div>
  
