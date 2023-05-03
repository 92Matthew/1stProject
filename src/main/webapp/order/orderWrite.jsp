<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
        var IMP = window.IMP; 
        IMP.init("imp88454102"); 
      
        var today = new Date();   
        var hours = today.getHours(); // ��
        var minutes = today.getMinutes();  // ��
        var seconds = today.getSeconds();  // ��
        var milliseconds = today.getMilliseconds();
        var makeMerchantUid = hours +  minutes + seconds + milliseconds;
        

        function requestPay(data) {
            IMP.request_pay({
                pg : 'kcp',
                pay_method : 'card',
                merchant_uid: "IMP"+makeMerchantUid, 
                name : '����2 ������ : �׽�Ʈ����', //��ǰ��
                amount : 100, //�ݾ�
                buyer_email : 'hysoo5223@gmail.com',
                buyer_name : 'ȫ�浿', // ������
                buyer_tel : '010-1234-5678', // ��ȭ��ȣ
                buyer_addr : '�λ걤���� �λ����� ������', //�ּ�
                buyer_postcode : '123-456' // ����ȣ
            }, function (rsp) { // callback ���
            	console.log(rsp);
                if (rsp.success) {
                	// ���� ������ ����
            	var msg = '���� �Ϸ�';
                	// �ֹ��� �������� �̵�
              		
    		} else {
                	// ���� ���н� ����
                	var msg = '���� ����';
                	msg += '�������� : ' + rsp.error_msg;
                	alert(msg);
                    console.log(rsp);
                }
            });
        }
    </script>
    <meta charset="UTF-8">
    <title>Sample Payment</title>
</head>
<body>
	<h1>�ֹ���</h1>
	
	<fieldset>
	<legend>��ǰ ����</legend>
		��ǰ��ȣ : <input type="text" name = "id" value="goods_id" readonly ><br>
		��ǰ���� : <img src="../img/img.jpg " width="100px"><br>
		��ǰ�̸� : <input type="text" name = "title" value="title" readonly ><br>
		��ǰ���� : <input type="text" name = "price" value="price" readonly ><br>
		��ۺ� ���� : 
			
	</fieldset>
		<hr>
	<fieldset>
	<legend>����� ����</legend>
	<!--  action�ּҰ� ������ �ڽ��� ������ ȣ�� -->
		<form action="addressChange.jsp" method="post" name="fr" >
		�̸� : <input type="text" name = "name" value="name"><br>
		��ȭ��ȣ : <input type="text" name = "phNumber" value="010-0000-0000"><br>
		�ּ� : <input type="text" name = "address" placeholder="�ּ�"><br>
		<input type="submit" value="�����ϱ�">
		</form>
	</fieldset>
	
	<fieldset>
	<legend>��������</legend>
		�� �ݾ� : price + ��ۺ� <br>
		�������� : <input type="radio" vlaue="ī�����"> ī�����
	</fieldset>
	
	<hr>
	
	<fieldset>				
	�̿��� ����
	</fieldset>
	
	  <div class="checkbox_group">
	  <input type="checkbox" id="check_all" >
	  <label for="check_all">�̿� ��� ����</label>
	  </div>
  
 	<br>
    <button onclick="requestPay()">�����ϱ�</button> 
    
    
    
</body>
</html>