<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<meta charset="UTF-8">
<title>CODELESS - 공지사항 작성</title>
<%@include file="../head.jsp" %>
<script type="text/javascript">
$(document).ready(function () {
	$('#fr').submit(function() {
		if($('#title').val() == ""){
			alert('제목을 입력하세요.');
			$('#title').focus();
			return false;
		}//제목 입력 제어
		
		if($('#content').val() == ""){
			alert('내용를 입력하세요.');
			$('#content').focus();
			return false;
		}//내용 입력 제어
		
	
	});//정보 입력안하면 submit기능 제어 끝
});
</script>
</head>
<body>
<%@include file="../nav.jsp" %>

  <div class="row" style="margin-left: 100px;">
 <!-- 사이드바 -->
  <%@ include file="../noSide.jsp"%>	
  
 <!--   사이드바 -->
  
 <div class="col-md-10">
 <div id="right">
 <h1 style="font-family: 'TheJamsil5Bold';">공 지 작 성</h1>
<hr style="border: 0;height: 3px; background-color: black;">

  <form action="./NoticeWriteAction.no" id="fr" method="post" enctype="multipart/form-data" method="post">
  
    <label>글제목
    <input type="text" id="title" name="title" placeholder="글제목을 입력하세요" class="form-control" size="110">
	</label>
	<br>
    <label>글내용<br>
    <textarea name="content" id="content" placeholder="공지사항 내용을 작성하세요" cols="110px;" rows="10px;" class="form-control"></textarea>
	</label>
	<br>
	<label>첨부 이미지
    <input type="file" name="notice_image" class="form-control">
	</label>
	
 <div style= "float: right; margin-top: 60px;">
<!-- 관리자만 글작성할 수 있게 해주세요 -->
 <button type="submit" id="submit" class="btn btn-primary">작성완료</button>
 <a href="./NoticeList.no" class="btn btn-secondary">목록으로</a>
</div>

 </form>
 
</div>
</div>
</div>
<%@include file="../footer.jsp" %>
</body>
</html>