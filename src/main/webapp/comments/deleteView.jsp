<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/> <!-- JSTL 사용해서 절대경로 -->

<c:import url="/include/top.jsp" />

<section>
<div align=center>
	<form name="deleteForm" role="form" method="post" action="${path}/comments_delete.do">
		<input type="hidden" name="idx" value="${comments_delete.idx}" readonly="readonly"/>
		<input type="hidden" id="num" name="num" value="${comments_delete.num}" />
		
		<div>
			<p>삭제 하시겠습니까?</p>
			<button type="submit" class="delete_btn">예 삭제합니다.</button>
			<button type="button" class="cancel_btn">아니오. 삭제하지 않습니다.</button>
		</div>
	</form>
</div>
</section>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		var formObj = $("form[name='deleteForm']");
		
		$(".cancel_btn").on("click", function(){
			location.href = "${path}/board_content.do?idx=${board_idx}";
		})
		
	})
</script>