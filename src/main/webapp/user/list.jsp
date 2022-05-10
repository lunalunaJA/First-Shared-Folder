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
<table width=700>
<tr><th>아이디</th><th>이름</th><th>전화번호</th><th>이메일</th></tr>

<c:forEach var="user" items="${li}">
<tr><td>${user.id}</td><td>${user.name}</td><td>${user.tel}</td><td>${user.email}</td></tr>
</c:forEach>
</table> <br>

<!-- 검색하기 -->
<form action="user_list.do">
<select name="ch1">
	<option value="id">아이디</option>
	<option value="name">이름</option>
</select>
	<input type=text name="ch2">
	<input type=submit value="검색하기">
</form>

</div>

</section>