<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>noticeUpdate</h1>
<h1>공지사항 수정페이지</h1>
<div class="container">
 
  <form action="./NoticeUpdateAction.no" method="post">

   	글번호 ${dto.notice_id }
   	<input type="hidden" name="notice_id" value="${dto.notice_id }">
	<br>
    <label>글제목<br>
    <input type="text" name="title" value="${dto.title }">
	</label>
	<br>
    <label>글 내용<br>
    <textarea name="content" style="height:200px">${dto.content }</textarea>
	</label>
	<br>
	<label>첨부 이미지
    <input type="file" name="notice_image">
	</label>
	<br>


    <input type="submit" value="작성완료">
	
  </form>
 <a href="./NoticeList.no">목록으로</a>
</div>

</body>
</html>