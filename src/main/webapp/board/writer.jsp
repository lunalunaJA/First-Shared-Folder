<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 날짜, 숫자 포맷 -->
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/> <!-- JSTL 사용해서 절대경로 -->

<c:import url="/include/top.jsp" />

<style>
th {
	text-align: center;
	width: 150px;
	padding: 10px;
}
td {
	width: 400px;
    padding: 10px;
}

</style>



<section>
<br><br>

<div>
<img src="${path}\img\red.png" width=7 height=7> 표시는 필수 입력 사항입니다.
<br><hr width="400px">
<br><br>
작성자&nbsp; ${session} &emsp;|&emsp;
작성일&nbsp; <span id=now></span>
</div>

<div align=center>
<form action="${path}/board_writeOk.do" onsubmit="return b()" name="f2" method="post" enctype="multipart/form-data">
<input type=hidden name="id" value="${session}">
<table>
<tr><th>가게이름
		<img src="${path}\img\red.png" width=7 height=7></th>
	<td><input type=text name=sname id=sname></td>
	<td rowspan=8 align=center>
	<img id="preview" width=300 height=300/></td></tr>
<tr><th>가게번호
		<img src="${path}\img\red.png" width=7 height=7></th>
	<td><input type=text name=phone id=phone></td></tr>

<tr><th>영업시간</th>
	<td><input type=text name=open pattern="[0-9]{2}:[0-9]{2}~[0-9]{2}:[0-9]{2}" placeholder="00:00~12:00" size=10></td></tr>
<tr><th>휴일</th><td><input type=text name=off size=10></td></tr>
<tr><th>대표메뉴</th>
	<td><input type=text name=mmenu size=15></td></tr>
<tr><th>홈페이지</th><td><input type=text name=instar size=30></td></tr>

<tr><th>상품이미지</th>
	<td><input type=file name=imgUploadFile onchange="readURL(this);"></td></tr>
	
<tr><th>주소
		<img src="${path}\img\red.png" width=7 height=7></th> <td>
	<input type="text" id="sample6_postcode" name="postcode" id=postcode placeholder="우편번호">
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample6_address" name="address" placeholder="주소" size=50><br>
	<input type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소">
	<input type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목">
	</td></tr>

<tr><th colspan=3><input type=submit value="게시물 등록"></th></tr>
</table>
</form>
</div>

</section>

<!-- 오늘날짜 -->
<script>
	var d = new Date();
	var year = d.getFullYear().toString();
	var month = (d.getMonth() + 1).toString();
	var day = d.getDate().toString();
	var hours = d.getHours().toString();
	var min = d.getMinutes().toString();
	var sec = d.getSeconds().toString();
	var currentTime = year + "-" + month + "-" + day;
	
	document.getElementById("now").innerHTML = currentTime;
</script>


<!-- 필수 입력값 -->
<script>
	function b() {
		if (f2.sname.value==""){
			alert("가게 이름을 입력해주세요.");
			f2.sname.focus();
			return false;
		}
		if (f2.phone.value==""){
			alert("가게 번호를 입력해주세요.");
			f2.phone.focus();
			return false;
		}
		if (f2.postcode.value==""){
			alert("주소를 입력해주세요.");
			f2.postcode.focus();
			return false;
		}		
	}
</script>

<!-- 이미지 미리보기 -->
<script src="http://madalla.kr/js/jquery-1.8.3.min.js"></script>
<script>
function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}
</script>

<!-- 주소 알림창 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>