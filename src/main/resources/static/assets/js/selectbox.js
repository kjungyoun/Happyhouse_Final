$(document).ready(function(){
		// 웹 페이지 시작시 city 정보 select box에 담기
			getCityInfo();			
	})
		
function getCityInfo(){
	
		$.ajax({
			type:'GET',
			url:'/select',
			dataType:'json',
			success: function(result){
				// select box 초기화
				$('#city').find('option').remove().end().append("<option disabled selected value=''>시/도</option>")
				
				// List 개수만큼 option 추가
				$.each(result,function(idx){
					$('#city').append("<option value='"+result[idx]+"'>"+result[idx]+"</option>")
				})
			},
			error : function(jqXHR, status, err){
				alert('city 정보를 가져오는 중 오류 발생!')
			}
		})
	}
	
	function getGugunInfo(city){
		$.ajax({
			type:'GET',
			url:'/select/'+city,
			dataType:'json',
			success: function(result){
				// select box 초기화
				
				$('#gugun').find('option').remove().end().append("<option disabled >시/구/군</option>")
				$.each(result,function(idx){
					$('#gugun').append("<option value='"+result[idx]+"'>"+result[idx]+"</option>")
				})
				// List 개수만큼 option 추가
				
			},
			error : function(jqXHR, status, err){
				alert('gugun 정보를 가져오는 중 오류 발생!')
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
				// select box 초기화
				$('#dongName').find('option').remove().end().append("<option disabled selected>동</option>")
				
				// List 개수만큼 option 추가
				$.each(result,function(idx){
					$('#dongName').append("<option value='"+result[idx]+"'>"+result[idx]+"</option>")
				})
			},
			error : function(jqXHR, status, err){
				alert('dong 정보를 가져오는 중 오류 발생!')
			}
		})
	}