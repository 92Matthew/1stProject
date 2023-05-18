<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODELESS - 공지사항 내용</title>
<%@include file="../head.jsp" %>
</head>
<body>
<%@include file="../nav.jsp" %>
<%@ include file="../background.jsp"%> <!-- END 배경 -->

  <div class="row" style="margin-left: 100px;">
  <!-- 사이드바 -->
 <%@ include file="../noSide.jsp"%>	
  
 <!--   사이드바 -->
  
 <div class="col-md-10">
 <div id="right">
 <h1 style="font-family: 'TheJamsil5Bold';">${dto.title }</h1>
<hr style="border: 0;height: 3px; background-color: black;">

<%-- 이미지 이름 ${dto.notice_image } --%>
<%-- 이미지 저장 경로 ${realpath }  --%>
	<table class="table" id="nttable">
		   <tr>
		     <td>NO. ${dto.notice_id }</td>
		     <td>작성일</td>
		     <td>${dto.date }</td>
		     <td>조회수</td>
		     <td>${dto.count }</td>
		   </tr> 
		   <tr>
		     <td>내용</td>
		     <td colspan="4">${dto.content }</td>
		   </tr> 
			 <td>이미지</td>   
   			<td colspan="4"><img src="./upload/${dto.notice_image }" height="400px"/></td>
   			
		</table>

<div style= "float: right; margin-top: 80px;">

<c:if test="${id.equals('admin') }">
<a href="./NoticeProUpdateAction.no?notice_id=${dto.notice_id }&pageNum=${pageNum}" class="btn btn-primary">게시글 수정</a>
<a href="./NoticeDelete.no?notice_id=${dto.notice_id }&pageNum=${pageNum}" class="btn btn-primary">게시글 삭제</a>
</c:if>
<a href="./NoticeList.no?pageNum=${pageNum }" class="btn btn-secondary">목록으로</a>
</div>
</div>
</div>
</div>

<%@include file="../footer.jsp" %>
</body>
</html>