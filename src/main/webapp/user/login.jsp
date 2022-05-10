<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 날짜, 숫자 포맷 -->
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/> <!-- JSTL 사용해서 절대경로 -->

<c:import url="/include/top.jsp" />

<style>
th {
	text-align: center;
	width: 100px;
	padding: 10px;
}
td {
	width: 250px;
    padding: 10px;
}

</style>


<section>
<br><br>

<div align=center>
<h3> 로그인 </h3>

<form name=f1>
<table>
<tr><th>아이디</th><td> <input type=text name=id id=id></td></tr>
<tr><th>비밀번호</th><td> <input type=text name=pwd id=pwd></td></tr>
<tr><td colspan=2 align=center><input type=button id="btn" value="로그인"></td></tr>

</table>
</form>
 
</div>
</section>

<!-- jQuery이용해서 값 받고 알림창 띄우기 -->
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
  jQuery.ajaxSetup({cache:false});
  $(document).ready(function(){
	var path = "${pageContext.request.contextPath}"	
	
	$('#btn').click(function(){
		var query ={
			         id : $('#id').val(), 
			         pwd : $('#pwd').val()
		           }
		
		if (f1.id.value==""){
			alert("아이디 입력은 필수 입니다.");
			f1.id.focus();
			return false;
		}
		if (f1.pwd.value==""){
			alert("비밀번호 입력은 필수 입니다.");
			f1.pwd.focus();
			return false;
		}
		
		$.ajax({
		  type:'get',
		  url : path + "/user_loginOk.do",
		  data : query,
		  success: function(data){
			  if(data == 1 ){
				  alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				  $('#id').val('');
				  $('#pwd').val('');
				  $('#id').focus();
				  
			  } else {
				  alert("로그인 하였습니다.");
				  location.href="${path}/index.jsp";
			  }			  
		  }
		})
	})
	
  })
</script>