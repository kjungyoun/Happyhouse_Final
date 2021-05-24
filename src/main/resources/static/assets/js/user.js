$(document).ready(function () {
    // 회원가입 -> 주소 검색 눌렀을 때
    $('#address-pop').click(function(e) {
        new daum.Postcode({
          oncomplete: function(data) {
              var addr = ''; // 주소 변수
              if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                  addr = data.roadAddress;
              } else { // 사용자가 지번 주소를 선택했을 경우(J)
                  addr = data.jibunAddress;
              }
              $('#address-pop').attr('style', 'display: none');
              $('#address').attr('style', 'display: block');
              $('#address').val(addr);
              $('#address-detail').focus();
          }
        }).open();
    });

    $('#all-select').click(function (e) { 
        if($('.user-select input').attr('checked') == 'checked'){
            $('.user-select input').attr('checked', false)
        } else{
            $('.user-select input').attr('checked', true)
        }
    });
});

function checkId(){
	var userid = $('#userid').val()
	
	$.ajax({
		type:'GET',
		url:'/user/valid/'+userid,
		dataType:'json',
		success:function(data){
			if(data == 1){
				$('#validId').text('이미 사용중인 아이디 입니다.');
				$('#validId').css("color", "red");
				$('#userid').attr('idCheck', 'N')
			}else{
				$('#validId').text('사용 가능한 아이디 입니다.');
				$('#validId').css("color", "green");
				$('#userid').attr('idCheck', 'Y')
			}
		}
		,error : function(jqXHR, status, err){
			alert('아이디 중복 검사 중 에러 발생!')
		}
	})
}

function signup(){
	if($("#userid").val() == "") {
		alert("아이디 입력!!!");
		$('#userid').focus()
		return;
	} else if($("#userid").attr("idCheck") == "N") {
		$('#userid').focus()
		alert("이미 존재하는 아이디입니다. 다른 아이디를 입력하세요!");
		return;
	} else if($("#userpwd").val() == "") {
		alert("비밀번호 입력!!!");
		$('#userpwd').focus()
		return;
	}else if($("#userpwd").val() != $("#pwdcheck").val()) {
		alert("비밀번호 확인!!!");
		$('#userpwd').focus()
		return;
	}else if($("#username").val() == "") {
		alert("이름 입력!!!");
		$('#username').focus()
		return;
	} else if($("#email").val() == "") {
		alert("이메일 입력!!!");
		$('#email').focus()
		return;
	} else {
		alert("회원가입에 성공했습니다!");
		document.getElementById("signupform").action = "/user/register";
		document.getElementById("signupform").submit();
	}
}

function login() {
	if(document.getElementById("useridL").value == "") {
		alert("아이디 입력!!!");
		document.getElementById("useridL").focus()
		return;
	} else if(document.getElementById("userpwdL").value == "") {
		alert("비밀번호 입력!!!");
		document.getElementById("userpwdL").focus()
		return;
	} else {
		document.getElementById("loginform").action = "/user/login";
		document.getElementById("loginform").submit();
	}
}