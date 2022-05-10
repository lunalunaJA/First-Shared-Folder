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


<div align=center>

<img src="${path}\img\red.png" width=7 height=7> 표시는 필수 입력 사항입니다.
<br><hr width="400px">

<form name="f1" action="${path}/user_joinOk.do" onsubmit="return join()">
<table height=350>
<tr><th>아이디
		<img src="${path}\img\red.png" width=7 height=7></th>
		<td><input type=text name="id" id="id">&nbsp;<input type=button id="idBtn" value="아이디 확인"></td></tr>
<tr><th>비밀번호
		<img src="${path}\img\red.png" width=7 height=7></th>
		<td><input type=text name="pwd" id="pwd" size=12></td></tr>
<tr><th>이름
		<img src="${path}\img\red.png" width=7 height=7></th>
		<td><input type=text name="name" id="name" size=7></td></tr>
<tr><th>전화번호
		<img src="${path}\img\red.png" width=7 height=7></th>
		<td><input type=tel name="tel" id="tel" pattern="^[0-9-+\s()]*$" placeholder="010-0000-0000" required></td></tr>
<tr><th>이메일
	<img src="${path}\img\red.png" width=7 height=7></th>
	<td><input type="email" name="email" id="email" placeholder="이메일아이디@도메인" size=30 required></td></tr>

<tr><th>주소</th> <td>
	<input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호">
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample6_address" name="address" placeholder="주소" size=50><br>
	<input type="text" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소">
	<input type="text" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목">
	</td></tr>

<tr><th colspan=2 align="center"><input type=submit value="회원가입"> &emsp;
								<input type=reset value=다시작성></th></tr>
</table>
</form>
</div>


</section>

<!-- 필수 입력값 -->
<script>
	function join() {
		if (f1.pwd.value==""){
			alert("비밀번호 입력은 필수 입니다.");
			f1.pwd.focus();
			return false;
		}
		if (f1.name.value==""){
			alert("이름 입력은 필수 입니다.");
			f1.name.focus();
			return false;
		}
		if (f1.tel.value==""){
			alert("전화번호 입력은 필수 입니다.");
			f1.tel.focus();
			return false;
		}
		if (f1.email.value==""){
			alert("이메일 입력은 필수 입니다.");
			f1.email.focus();
			return false;
		}
		
		alert("회원가입이 완료되었습니다.");
	}
</script>


<!-- jQuery이용해서 값 받고 알림창 띄우기 -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
  jQuery.ajaxSetup({cache:false});
  $(document).ready(function(){
	var path = "${pageContext.request.contextPath}"	
	
	$('#idBtn').click(function(){
		var query ={
			         id : $('#id').val()
		           }
		if (f1.id.value==""){
			alert("아이디 입력은 필수 입니다.");
			f1.id.focus();
			return false;
		}
		
		$.ajax({
		  type:'get',
		  url : path + "/user_userCk.do",
		  data : query,
		  success: function(data){
			  if(data == 1 ){
				  alert("중복된 아이디 입니다.");
				  $('#id').val('');
				  $('#id').focus();
				  
			  } else {
				  alert("사용 가능한 아이디 입니다.");
			  }			  
		  }
		})
		
	}) 
	
  })
</script>



<!-- 다음API 이용해서 주소에 관한 정보 받아오기 -->
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