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
				                            <div class="ellipsis">${item.base.city} ${item.base.gugun} ${item.base.dong}</div>
				                            <div class="jibun ellipsis">(우) ${item.code} (지번) ${item.dong} ${item.jibun}</div>
				                            <div><a href="/house/search/${item.code}/${item.dong}/${item.aptName}/${item.lat}/${item.lng}" target="_self" class="link">상세 결과보기</a></div>
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
				            	 console.log(overlay)
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


function commercial(){
	var category = document.getElementById('category');
	if(category.style.display == 'none'){
		category.style.display = 'block'
	}else{
		category.style.display = 'none'
	}
	
	// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
	var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
	    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
	    markers = [], // 마커를 담을 배열입니다
	    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(map); 

	// 지도에 idle 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'idle', searchPlaces);

	// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	contentNode.className = 'placeinfo_wrap';

	// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

	// 커스텀 오버레이 컨텐츠를 설정합니다
	placeOverlay.setContent(contentNode);  

	// 각 카테고리에 클릭 이벤트를 등록합니다
	addCategoryClickEvent();

	// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	function addEventHandle(target, type, callback) {
	    if (target.addEventListener) {
	        target.addEventListener(type, callback);
	    } else {
	        target.attachEvent('on' + type, callback);
	    }
	}

	// 카테고리 검색을 요청하는 함수입니다
	function searchPlaces() {
	    if (!currCategory) {
	        return;
	    }
	    
	    // 커스텀 오버레이를 숨깁니다 
	    placeOverlay.setMap(null);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	        displayPlaces(data);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

	    } else if (status === kakao.maps.services.Status.ERROR) {
	        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	        
	    }
	}

	// 지도에 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	    var order = document.getElementById(currCategory).getAttribute('data-order');

	    

	    for ( var i=0; i<places.length; i++ ) {

	            // 마커를 생성하고 지도에 표시합니다
	            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

	            // 마커와 검색결과 항목을 클릭 했을 때
	            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	            (function(marker, place) {
	                kakao.maps.event.addListener(marker, 'click', function() {
	                    displayPlaceInfo(place);
	                });
	            })(marker, places[i]);
	    }
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, order) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	function displayPlaceInfo (place) {
	    var content = '<div class="placeinfo">' +
	                    '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

	    if (place.road_address_name) {
	        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
	                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
	    }  else {
	        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
	    }                
	   
	    content += '    <span class="tel">' + place.phone + '</span>' + 
	                '</div>' + 
	                '<div class="after"></div>';

	    contentNode.innerHTML = content;
	    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
	    placeOverlay.setMap(map);  
	}


	// 각 카테고리에 클릭 이벤트를 등록합니다
	function addCategoryClickEvent() {
	    var category = document.getElementById('category'),
	        children = category.children;

	    for (var i=0; i<children.length; i++) {
	        children[i].onclick = onClickCategory;
	    }
	}

	// 카테고리를 클릭했을 때 호출되는 함수입니다
	function onClickCategory() {
	    var id = this.id,
	        className = this.className;

	    placeOverlay.setMap(null);

	    if (className === 'on') {
	        currCategory = '';
	        changeCategoryClass();
	        removeMarker();
	    } else {
	        currCategory = id;
	        changeCategoryClass(this);
	        searchPlaces();
	    }
	}

	// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	function changeCategoryClass(el) {
	    var category = document.getElementById('category'),
	        children = category.children,
	        i;

	    for ( i=0; i<children.length; i++ ) {
	        children[i].className = '';
	    }

	    if (el) {
	        el.className = 'on';
	    } 
	} 
}