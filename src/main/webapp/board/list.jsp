<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
    padding: 10px;
}

</style>



<section>
<br><br>
<c:if test="${session == null }">
	로그인 하세요.
</c:if>

<c:if test="${session != null }">

<div align=center>
<c:set var="i" value="0" />
<c:set var="j" value="4" />


<table width=1200> 
 	<c:choose>
 		<c:when test="${li != null && fn:length(li) > 0 }">
 			<c:forEach var="li" items="${li}">
 			<c:if test="{i%j == 0}">
 				<tr>
 			</c:if>
 			<td align=center>
 			<a href="${path}/board_content.do?idx=${li.idx}"><img src="${path}/board/files/${li.img}" width=150 height=200></a><br>
     	 	${li.sname}</td>
    		<c:if test="${i%j == j-1}">
     			</tr>
    		</c:if>
    	<c:set var="i" value="${i+1}" />
    		</c:forEach>
   		</c:when>
   	<c:otherwise>
   		<tr>
    		<td>존재하지 않습니다.</td>
   		</tr>
  	</c:otherwise>
  	</c:choose>

<!-- 관리자만 게시판 작성가능 -->
<c:if test="${session == 'admin'}">
	<form action="board_write.do" name="f2">
		<tr><td colspan=4 align=right><input type=submit value="작성하기"></td></tr>
	</form>
</c:if>


</table>


<!-- 페이지 나누기 -->
<br><br>

&emsp; <a href="${path}/board_list.do?startIdx=1">«</a>

<c:if test="${startIdx > 1}">
&emsp; <a href="${path}/board_list.do?startIdx=${startIdx-10}">‹</a>
</c:if>
<c:if test="${startIdx == 1}">
&emsp;
</c:if>

<c:forEach var="i" begin="${listStartPage}" end="${listEndPage}">
	<c:if test="${i <= totalPage}">
	&emsp; <a href="${path}/board_list.do?startIdx=${(i-1)*pageSize+1}">${i}</a>
	</c:if>
</c:forEach>
<c:if test="${listEndPage < totalPage}">
&emsp; <a href="${path}/board_list.do?startIdx=${startIdx+10}">›</a>
</c:if>
<c:if test="${listEndPage >= totalPage}">
&emsp;
</c:if>

&emsp; <a href="${path}/board_list.do?startIdx=${endPage}">»</a>


<br><br>

</div>
<br>
</c:if>

</section>