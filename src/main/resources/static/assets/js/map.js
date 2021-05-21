// 지도 생성
var container = document.getElementById('map');
var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
};

const map = new kakao.maps.Map(container, options);


function mvLocation(){
		let city = $('#city').val()
		let gugun = $('#gugun').val()
		let dong = $('#dong').val()
		$.ajax({
			type:'GET',
			url: '/location/'+city+'/'+gugun+'/'+dong,
			dataType:'json',
			success: function(data){
				
				// 지도 중심좌표 이동
				var moveLatLon = new kakao.maps.LatLng(data.lat, data.lng)
				map.panTo(moveLatLon);
				
				
				
			}
		})
	}