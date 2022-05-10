<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri = "http://java.sun.com/jstl/core_rt" prefix="c" %> <!-- JSTL 선언문 -->
<c:import url="/include/top.jsp" />

<section>
<br><br>

<div align=center>


	<form name="updateForm" role="form" method="post" action="${path}/comments_update.do">
		<input type="hidden" name="idx" value="${comments_update.idx}">
		<input type="hidden" id="num" name="num" value="${comments_update.num}" />
		<input type="hidden" id="id" name="id" value="${comments_update.id}" />
		<table>
			<tbody>
				<tr>
					<td>
						<label for="detail">댓글 내용</label>
						<textarea cols="65" name="detail" id="detail" value="${comments_update.detail}"></textarea>
					</td>
				</tr>	
				
			</tbody>			
		</table>
		<br>
		<div>
			<button type="submit" class="update_btn">수정완료</button> &emsp;
			<button type="button" class="cancel_btn">수정취소</button>
		</div>
	</form>
</div>
</section>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		var formObj = $("form[name='updateForm']");
		
		$(".cancel_btn").on("click", function(){
			
			location.href = "${path}/board_content.do?idx=${board_idx}";
			
			//window.close();
		})
		
	})
</script>