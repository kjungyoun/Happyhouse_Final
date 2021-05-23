// 지도 생성
var container = document.getElementById('map');
var options = {
		center: new kakao.maps.LatLng(37.50074094827002, 127.0369354346467),
		level: 3
};

const map = new kakao.maps.Map(container, options);

	$.ajax({
		type:'GET',
		url: '/aptPosition/',
		dataType:'json',
		success: function(data){
			
			console.log(data)
			var imageSrc = 'https://image.flaticon.com/icons/png/512/4565/4565711.png', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(50,52), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
			
			data.forEach(function(item,idx){
				
				// 각 아파별 마커 생성
				var markerPosition  = new kakao.maps.LatLng(item.lat, item.lng);
				
				var marker = new kakao.maps.Marker({
					position : markerPosition, 
					image : markerImage // 마커 이미지 설정
				});
				
				// 커스텀 오버레이에 표시할 컨텐츠 입니다
				// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
				// 별도의 이벤트 메소드를 제공하지 않습니다 
				var content = `<div class="wrap">
								<div class="info">
				                    <div class="title">${item.aptName}					
				                    	<div class="close" id="close" title="닫기"></div>
				                    </div>
				                    <div class="body"> 
				                        <div class="img">
				                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxDDs-FSk1edGAsqh-IyXhzwQwL6_SY_4z4Q&usqp=CAU" width="73" height="70">
				                       </div>
				                        <div class="desc">
				                            <div class="ellipsis">${item.addr.city} ${item.addr.gugun} ${item.addr.dong}</div>
				                            <div class="jibun ellipsis">(우) ${item.code} (지번) ${item.dong} ${item.jibun}</div>
				                            <div><a href="/house/search" target="_blank" class="link">상세 결과보기</a></div>
				                        </div>
				                    </div>
				                </div>   
				            </div>
				            `
			
				            
				         // 마커 위에 커스텀오버레이를 표시합니다
				         // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
				         var overlay = new kakao.maps.CustomOverlay({
				             content: content,
				             position: marker.getPosition()       
				         });
				         
				      // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
				         kakao.maps.event.addListener(marker, 'click', function() {
				             if(!overlay.getMap()){
				            	 overlay.setMap(map);				            	 
				             }
				             else{
				            	 overlay.setMap(null);				            	 
				             }
				         });
				         
				         // 마커 등록
				         marker.setMap(map);
				         
				         // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
				         $(document).on("click","#close",function(){
				        		overlay.setMap(null);     
				        	 });
				         
			})
		},error : function(jqXHR, status, err){
			alert('마커 생성중 에러 발생!')
		}
	})

// 지도 중심 좌표 이동 메서드
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
				
				
			},error : function(jqXHR, status, err){
				alert('지도 이동 중 에러 발생!')
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