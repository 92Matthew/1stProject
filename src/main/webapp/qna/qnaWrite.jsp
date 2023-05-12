<%@page import="com.itwillbs.db.MemberDTO"%>
<%@page import="com.itwillbs.db.MemberDAO"%>
<%@page import="com.itwillbs.db.QnADTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../head.jsp"%>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

		$('textarea').keyup(function(){

			var tmpLength = 700 - $(this).val().length;
			$('h3').html(tmpLength);
			
			if( tmpLength < 0 ){
				$('h3').css('color','red');
			}  		
			else{
				$('h3').css('color','black');
			}
		});
		
</script>

<%
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberDTO mdto = mdao.getMember(id);
String nickname = mdto.getNickname();
%>

</head>
<body>
<%@ include file="../nav.jsp"%><!-- nav 삽입 -->
	
<!-- 		로그인 세션제어 -->
		<c:if test="${ empty sessionScope.id }">
		   <c:redirect url="./MemberLogin.me"/>
		</c:if>
					
	
 <!--   사이드바 -->
	  <div class="col-sm-4">
 <div class="container" id="left">
  <br>
  <h4> QnA 게시판</h4>
  <hr style="border: 0;height: 1px; background-color: black;">
  <h5 onclick="location.href='./UserQNAList.qn'"> 질문 목록 </h5>
  <h5 onclick="location.href='./MypageQNAInsert.qn'"> 1:1 문의 </h5>

  </div>
	</div>	
	

	
	 <!--   사이드바 -->
	 
	 <div class="col-sm-8" style="margin:auto;">
 <div id="right" style="margin-left: 50px; width: 100%;">
 <h1 style="font-family: 'TheJamsil5Bold';">1:1 문의 글작성</h1>
<hr style="border: 0;height: 3px; background-color: black;">



		<fieldset>	
		   <form action="./MypageQNAInsertAction.qn" method="post" enctype="multipart/form-data">
		   <input type="hidden" name="id" value="${sessionScope.id}"><br>
		   <input type="hidden" name="isanswered"" value="${qdto.is_answered}">
<!-- 		회원정보, 상품, 신고, 결제, 기타 -->
		   카테고리 <select name="qna_category">
					  <option value='회원정보'>회원정보</option>
					  <option value='상품'>상품</option>
					  <option value='신고'>신고</option>
					  <option value='결제' >결제</option>
					  <option value='기타'>기타</option>
					</select>
		   	  작성자(닉네임) : <%=nickname %><input type="hidden" name="nickname" value="<%=nickname %>" readonly><br>
		      제목 : <input type="text" name="title" required> <br> <br>
		      내용 : <br>
		      <textarea rows="15" cols="50" name="content" maxlength="700">
■ 주문관련 문의시 하단양식을 꼭 작성해 주세요 ■ 
		      
*주문자 성함 : 
*주문 번호 : 
*문의 내용 : 
		      
* 사이트 이용관련(주문,취소,배송 등) 각종궁금하신 사항은 
[고객센터] - [자주하는질문] 으로 들어가시면 자세하게 답변이 남겨져있으니 참고 바랍니다.
		      </textarea><br>
		      <input type="file" value="이미지첨부" name="image">
		  
				<input type="submit" value="글쓰기">
		
		   </form>		
		</fieldset>
	</div>	

</div>	
		<br><br>

<%@ include file="../footer.jsp"%> <!-- footer 삽입 -->
</body>
</html>