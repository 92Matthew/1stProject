<%@page import="com.itwillbs.db.ProductDTO"%>
<%@page import="com.itwillbs.db.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="../head.jsp" %>

		<script type="text/javascript">
		$(document).ready(function() {
			  // 사용자 식별자를 얻어오는 로직이 필요합니다. 예시로 'userId' 변수에 사용자 식별자를 할당합니다.

			  var userId = '<%= session.getAttribute("id") %>';
			  // 찜한 상품 정보를 로컬 스토리지에서 가져옵니다.
			  var likedProducts = JSON.parse(localStorage.getItem('likedProducts')) || {};
			  // 사용자의 찜한 상품 정보를 가져옵니다.
			  var userLikedProducts = likedProducts[userId] || {}; 

			  // 모든 찜하기 버튼을 돌며 찜한 상품인 경우 버튼에 liked 클래스를 추가합니다.
			  $('.like-btn').each(function() { 
			    var $btn = $(this);
			    var product_id = $btn.data('product-id');
			    var key = product_id.toString(); // 찜 상품 키로 사용할 문자열로 변환합니다.
			    if (userLikedProducts[key]) {
			      $btn.addClass('liked');
			    }
			  });

			  // 찜하기 버튼을 클릭할 때 찜한 상품 정보를 로컬 스토리지에 저장합니다.
			  $('.like-btn').on('click', function() {
			    var $btn = $(this);
			    var product_id = $btn.data('product-id');
			    var key = product_id.toString(); // 찜 상품 키로 사용할 문자열로 변환합니다.
			    var isLiked = $btn.hasClass('liked');

			    if (!isLiked) {
			      $.ajax({
			        url: './AjaxLikedAction.aj',
			        data: { product_id: product_id, id: userId },
			        success: function(response) {
			          if (response.success) {
			            $btn.addClass('liked');
			            // 사용자의 찜한 상품 정보를 업데이트합니다.
			            userLikedProducts[key] = true;
			            likedProducts[userId] = userLikedProducts;
			            localStorage.setItem('likedProducts', JSON.stringify(likedProducts));
			            location.reload();
			            alert('찜 추가완료!');
			          } else {
			            alert('추가 실패!');
			          }
			        }
			      });
			    } else { 
			      $.ajax({
			        url: './AjaxUnLikedAction.aj',
			        data: { product_id: product_id, id: userId },
			        success: function(response) {
			          if (response.success) {
			            $btn.removeClass('liked');
			            // 사용자의 찜한 상품 정보에서 해당 상품을 삭제합니다.
			            delete userLikedProducts[key];
			            likedProducts[userId] = userLikedProducts;
			            localStorage.setItem('likedProducts', JSON.stringify(likedProducts));
			            location.reload();
			            alert('찜 해제완료!');
			          } else {
			            alert('삭제 실패!');
			          }
			        }
			      });
			    }
			  });
			});


		</script>


<style>

.image-slider {
  position: relative;
  width: 300px;
  height: 200px;
}

.image-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.prev-btn,
.next-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  font-size: 24px;
  color: #fff;
  background-color: rgba(0, 0, 0, 0.5);
  padding: 8px;
  cursor: pointer;
}

.prev-btn {
  left: 0;
}

.next-btn {
  right: 0;
}

.product-info {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border: 1px solid #ddd;
}




.dots-container {
  position: absolute;
  bottom: 20px; /* 중앙 하단으로 조절 */
  left: 50%; /* 왼쪽으로 50% 이동 */
  transform: translateX(-50%); /* 자기 자신의 가로폭만큼 왼쪽으로 이동 */
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin: 0 5px;
  background-color: #bbb;
}

.dot.active {
  background-color: #555;
}
.product-info {
  display: flex;
  flex-direction: column;
}

.image-slider {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
}

.image-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
}

.product-container {
  height: 500px; /* 원하는 높이 값으로 설정 */
  overflow: auto;
}

.product-info {
  /* 상품 정보 스타일 */
}

.additional-info {
  /* 추가 정보 스타일 */
}

		.like-btn {
		  border: none;
		  background: none;
		  cursor: pointer;
		  font-size: 1.2em;
		  transition: transform 0.3s ease-in-out;
		}
		
		.like-btn i {
		  font-size: 1.5em;
		  color: #999;
		  transition: color 0.3s ease-in-out;
		}
		
		.like-btn.liked i {
		 color: #ff6969;
		}
		
		.like-btn:hover {
		  transform: scale(1.1);
		}
		
		.like-btn:hover i {
		  color: #ff6969;
		}


</style>

</head>
<body>
<%@include file="../nav.jsp" %>

 <!-- 사이드바 -->
<%@include file="../mySide.jsp" %>
 <!--   사이드바 -->

<div class="col-sm-8" style="margin:auto;"></div>
 <div id="right" style="margin-left: 150px; width: 100%;">
 <h1 style="font-family: 'TheJamsil5Bold';">${dto.title }</h1>
<hr style="border: 0;height: 3px; background-color: black;">

<h1 style="font-family:'TheJamsil5Bold';" align="center">${product.title}</h1>
<div class="product-info">
  <div class="row">
    <div class="label">No.</div>
    <div class="value">${product.product_id}</div>
  </div>
  <div class="image-slider">
 <div class="image-container">
    <img src="./upload/product/${product.product_image.split(',')[0]}" alt="이미지 없음" width="300px" align="middle">
    <img src="./upload/product/${product.product_image.split(',')[1]}" alt="이미지 없음" width="300px" align="middle">
     <img src="./upload/product/${product.product_image.split(',')[2]}" alt="이미지 없음" width="300px" align="middle">
     <img src="./upload/product/${product.product_image.split(',')[3]}" alt="이미지 없음" width="300px" align="middle">
     <img src="./upload/product/${product.product_image.split(',')[4]}" alt="이미지 없음" width="300px" align="middle">
</div>
  <div class="prev-btn">&lt;</div>
  <div class="next-btn">&gt;</div>
  <div class="dots-container"></div>
</div>
  <div class="row">
    <div class="label">등록일: </div>
    <div class="value">${product.reg_date}</div>
  </div>
					<!-- 찜 버튼 -->
	<button class="like-btn" data-product-id="${product.product_id}" data-user-id="${sessionScope.id }">
		  <i class="fa fa-heart"></i>
	</button>
					<!-- 찜수 -->
					<span style="font-size: 0.8em; color: gray;">찜수: ${product.like_count }</span>
    <div class="label">조회수: </div>
    <div class="value">${product.read_count} </div>

    <div class="label">채팅수: </div>
    <div class="value">${product.chat_count} </div>
  </div>
  <div class="row">
    <div class="label">판매자: </div>
    <div class="value">${product.user_id}</div>
  </div>
  <div class="row">
    <div class="label">모델: </div>
    <div class="value">${product.model}</div>
  </div>
  <div class="row">
    <div class="label">부품명: </div>
    <div class="value">${product.parts}</div>
  </div>
  <div class="row">
    <div class="label">등급: </div>
    <div class="value">${product.grade}등급</div>
  </div>
  <div class="row">
    <div class="label">판매지역: </div>
    <div class="value">${product.city}</div>
  </div>
  <div class="row">
    <div class="label">배송비: </div>
    <div class="value">${product.charge}원</div>
  </div>
  <div class="row">
    <div class="label">수수료: </div>
    <div class="value">${product.fee}원</div>
  </div>

  <div class="row">
    <div class="label">내용: </div>
    <div class="value">${product.content}</div>
  </div>
  <div class="row">
    <div class="label">가격: </div>
    <div class="value">${product.price}원</div>
  </div>
  <div class="row">
    <div class="label">배송방법: </div>
    <div class="value">${product.method}</div>
  </div>
</div>
<div>
<div style= "text-align: center ; margin-top: 10px;">
	<a href="./ProductList.pr" class="btn btn-primary" >상품 리스트로 이동</a>
	<a href="./OrderWrite.pr?product_id=${product.product_id}" class="btn btn-primary" >구매하기</a>

	<a href="./QNAWrite.qn" class="btn btn-primary" >신고하기</a>
	<c:if test="${ sessionScope.id != product.user_id }">
		<a href="./ChatToSeller.ch?toID=${product.user_id }" class="btn btn-primary" >채팅하기</a>
	</c:if>
	</div>
<div style= "text-align: center; margin-top: 5px;">
  <c:if test="${ sessionScope.id eq 'admin@gmail.com' or product.user_id eq sessionScope.id }">
      <form method="post" action="./ProductDeleteAction.pr"
        onsubmit="if(!confirm('상품을 삭제하시겠습니까?')) return false;" style="display: inline-block;">
        <input type="hidden" name="product_id" value="${product.product_id}" class="btn btn-primary">
        <button type="submit" class="btn btn-primary">상품글 삭제</button>
    </form>
    <a href="./ProductUpdate.pr?product_id=${product.product_id}" class="btn btn-primary">상품글 수정</a>
    <button type="button" class="btn btn-primary" onclick="href='./ProductList.pr'">판매완료</button>
    <br>

  </c:if>
  
</div>
</div>
</div>

<script>
const dotsContainer = document.querySelector('.dots-container');
const imageContainer = document.querySelector('.image-container');
const images = imageContainer.querySelectorAll('img');
const dots = [];

//이미지마다 점 생성
for (let i = 0; i < images.length; i++) {
  const dot = document.createElement('div');
  dot.classList.add('dot');
  dotsContainer.appendChild(dot);
  dots.push(dot);
}

let currentImageIndex = 0;

function showImage(index) {
	// 모든 이미지를 숨기고 모든 점을 비활성화
  for (let i = 0; i < images.length; i++) {
    images[i].style.display = 'none';
    dots[i].classList.remove('active');
  }
//선택한 이미지 보이기 및 해당하는 점 활성화
  images[index].style.display = 'block';
  dots[index].classList.add('active');
  currentImageIndex = index;
}

//초기에 첫번째 이미지와 점 활성화
showImage(0);
dots[0].classList.add('active');

//점 클릭 시 해당하는 이미지 보이기
for (let i = 0; i < dots.length; i++) {
  dots[i].addEventListener('click', function () {
    showImage(i);
  });
}

//이전/다음 버튼 클릭 시 이전/다음 이미지 보이기
const prevBtn = document.querySelector('.prev-btn');
const nextBtn = document.querySelector('.next-btn');

prevBtn.addEventListener('click', function () {
  currentImageIndex = (currentImageIndex - 1 + images.length) % images.length;
  showImage(currentImageIndex);
});

nextBtn.addEventListener('click', function () {
  currentImageIndex = (currentImageIndex + 1) % images.length;
  showImage(currentImageIndex);
});
</script>

<%@include file="../footer.jsp" %>
</body>
</html>