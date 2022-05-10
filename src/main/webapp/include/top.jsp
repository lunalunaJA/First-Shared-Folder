<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<c:set var="path" value="${pageContext.request.contextPath}" scope="session"/> <!-- JSTL을 사용해서 path 가져오기 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포트폴리오</title>
<link rel = "stylesheet" href="${path}/include/css/base.css">
<style>
	#divH {
	font-size: small;
	}
</style>
</head>

<body>

<div id="divH" align=right>

<c:if test="${session == null}">
&emsp;<a href="${path}/user_login.do">로그인</a>
&emsp;<a href="${path}/user_join.do">회원가입</a>
</c:if>

<c:if test="${session != null}">
&emsp;<a href="${path}/user_logout.do">로그아웃</a>
&emsp;<a href="${path}/user_content.do?id=${session}">회원정보</a>
</c:if>
<br><br>

<c:if test="${session != null}">
	${session}님 환영합니다.
</c:if>


</div>

<header>
	서울 빵지순례
</header>

<nav>
&emsp; <a href="${path}/index.jsp">홈으로</a>
&emsp; <a href="${path}/board_list.do">서울 빵집</a>

<c:if test="${session == 'admin'}">
	&emsp; <a href="${path}/user_list.do">회원목록</a>
</c:if>
</nav>