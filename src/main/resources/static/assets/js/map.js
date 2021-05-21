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

function commercial() {
	let city = $('#city').val()
	let gugun = $('#gugun').val()
	let dong = $('#dong').val()
	$.ajax({
		type : 'GET',
		url : '/location/' + city + '/' + gugun + '/' + dong,
		dataType : 'json',
		success : function(data) {
			var infowindow = new kakao.maps.InfoWindow({
				zIndex : 1
			});

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의
				// 중심좌표
				level : 3
			// 지도의 확대 레벨
			};

			// 지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 지도 중심좌표 이동
			var moveLatLon = new kakao.maps.LatLng(data.lat, data.lng)
			map.panTo(moveLatLon);

			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places(map);

			// 카테고리로 검색합니다
			ps.categorySearch('MT1', placesSearchCB, {
				useMapBounds : true
			});


	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {
			for (var i = 0; i < data.length; i++) {
				displayMarker(data[i]);
			}
		}
	}

	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
		// 마커를 생성하고 지도에 표시합니다
		var marker = new kakao.maps.Marker({
			map : map,
			position : new kakao.maps.LatLng(place.y, place.x)
		});

		// 마커에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			infowindow.setContent('<div style="padding:5px;font-size:12px;">'
					+ place.place_name + '</div>');
			infowindow.open(map, marker);
		});
		}
	}
	})
}