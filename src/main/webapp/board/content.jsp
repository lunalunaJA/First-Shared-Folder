<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/> <!-- JSTL 사용해서 절대경로 -->

<c:import url="/include/top.jsp" />

<style>
th {
	text-align: center;
    margin: 50px;
}
td {
    padding: 10px;
    vertical-align: middle;
}

</style>


<section>
<br><br>

<div align=center>

<!-- 게시글 상세보기 -->
<form>
<table width=800>
<tr><th>가게이름</th><td colspan=3>${m.sname}</td></tr>
<tr><th>가게번호</th><td>${m.phone}</td><th>대표메뉴</th><td>${m.mmenu}</td></tr>
<tr><th>영업시간</th><td>${m.open}</td><th>휴일</th><td>${m.off}</td></tr>
<tr><th>가게위치</th><td colspan=3>${m.address}, ${m.detailAddress}<br>
	<div id="map" style="width:700px;height:350px;"></div></td></tr>
	<c:if test="${session == 'admin'}">
<tr>	
	<th colspan=4 align="right"><input type=button onClick="up_idx(${m.idx})" value="수정하기">&emsp;<input type=button value="삭제하기" onclick="del_idx(${m.idx})"></th>
</tr>
	</c:if>
</table>
</form>
<br>



<!-- 댓글 -->
<form name=f3 onsubmit="return com()" action="${path}/comments_insert.do">
<input type=hidden name="idx" value="${m.idx}">
<input type=hidden name="id" value="${session}">

<table width=800>
<c:forEach var="comments_list" items="${c}">
<tr>
	<th>${comments_list.id}</th>
	<td>${comments_list.detail}</td>
	<p id=update_detail></p>

	<td align=right>
	<c:if test="${session == 'admin' || session == comments_list.id}">
		<input type=button class="up_comments" data-num="${comments_list.num}" id="up_comments" value="수정">
		<input type=button class="del_comments" data-num="${comments_list.num}" id="del_comments" value="삭제">
	</c:if>
	</td>
</tr>
</c:forEach>

	<tr>
		<th>
		<c:if test="${session != null}">
			${session}
		</c:if>
		<c:if test="${session == null}">
			로그인<br>해주세요.
		</c:if>
		</th>
		<td><textarea cols="65" name="detail" id="detail" placeholder="댓글 쓰기"></textarea></td>
		<td><input type=submit value="댓글달기"></td>
	</tr>
</table>
</form>


</div>
<br><br>

</section>


<!-- 댓글 삭제, 수정 -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
  $(document).ready(function(){
	  $('.del_comments').on('click', function(){
		  alert("삭제하시겠습니까?");
		  location.href = "${path}/comments_delete.do?idx=${board_idx}"
						  +"&num="+$(this).attr("data-num");
		})

	  $('.up_comments').on('click', function(){
 		  //alert("댓글 수정화면으로 이동합니다");
 		  location.href = "${path}/comments_updateView.do?idx=${board_idx}"
					  		+"&num="+$(this).attr("data-num");
	  })		
		
		
	  		/*
		$('.up_comments').on('click', function(){
			alert("확인중");
			$("#update_detail").html("이거니");
			
			var str="<td class='reply'>";
				str += "<textarea cols='60' name='detail' id='detail' placeholder='수정댓글></textarea>
				str += "<input type=button value='수정'><td>";
			
				
				$("#update_detail").html(str);
				
	  })
		*/
		
		
	  
	  
		/*
		$('.up_comments').on('click', function(){
 		 	
			alert("수정 확인중입니다");
			var url = "${path}/comments_updateView.do?idx=${board_idx}"
				  +"&num="+$(this).attr("data-num");
			var option = "width=600px; height=250px;"
		 	window.open(url,"댓글 수정하기",option);
		})		
		*/
		/*
		$('.up_comments').on('click', function(){
			var str="<textarea cols='60' name='detail' id='detail' placeholder='수정댓글></textarea>";
			$("#update_detail").html(str);
 		})
		*/
		
		/*
		function reply()
	  	*/

})			
</script>

<!-- 게시글 수정, 삭제하기 -->
<script>
	function up_idx(idx) {
		location.href="${path}/board_update.do?idx="+idx;
	}

	function del_idx(idx) {
		alert("삭제하시겠습니까?");
		location.href="${path}/board_delete.do?idx="+idx;
	}
</script>
	
<!-- 댓글 작성 -->
<script>
	function com() {
		if( ${session == null} ) {
			alert("로그인 해주세요.");
			return false;
			
		} else {
			if(f3.detail.value=="") {
				alert("댓글을 입력하세요.");
				f3.detail.focus();
				return false;				
			}
			
		}
	}
</script>





<!-- 주소로 위치 표시 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	8c2c81d943259eb6d762510f81069ad3&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch('${m.address}', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${m.sname}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>