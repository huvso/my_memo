<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%

    /* 렌탈신용보험(SGI) 가입 가맹점 추가정보 */
    
    String category = "테스트상품"; 
    String manufacturer = "이니상점"; 
    String modelName = "R0001"; 
    String serialNo = "20201205050000"; 
    
    JSONObject resJson = new JSONObject(); 
    JSONArray arr = new JSONArray(); 
    
    JSONObject jObject = new JSONObject(); 
    jObject.put("category", category); 
    jObject.put("manufacturer", manufacturer); 
    jObject.put("modelName", modelName); 
    jObject.put("serialNo", serialNo); 
    
    arr.add(jObject); 
    
    resJson.put("product", arr); 
    String encodeResult1 = URLEncoder.encode(resJson.toJSONString(),"EUC-KR"); 
    
    
    /* P_RESERVED 복합필드 설정  */
    String rentalCompNm = "이니상점";
    String rentalCompNo = "1234567890";
    String rentalCompPhone = "01012341234";
    String rentalRecipientNm = "홍길동";
    String rentalRecipientPhone = "01000001234";
    
    String P_RESERVED = "rentalCompNm="+rentalCompNm+"&rentalCompNo="+rentalCompNo+"&rentalCompPhone="+rentalCompPhone+"&rentalRecipientNm="+rentalRecipientNm+"&rentalRecipientPhone="+rentalRecipientPhone;

%>
    
<!DOCTYPE html>
<html lang="ko">
<head> 
<title>INIpay Mobile WEB example</title> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head> 

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport"
            content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <title>KG이니시스 결제샘플</title>
        <link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/bootstrap.min.css">
		
		<script> 
	        function on_pay() { 
	        	myform = document.mobileweb; 
	        	myform.action = "https://mobile.inicis.com/smart/payment/";
	        	myform.target = "_self";
	        	myform.submit(); 
	        }
        </script> 
    </head>

    <body class="wrap">

        <!-- 본문 -->
        <main class="col-8 cont" id="bill-01">
            <!-- 페이지타이틀 -->
            <section class="mb-5">
                <div class="tit">
                    <h2>렌탈계약</h2>
                    <p>KG이니시스 결제창을 호출하여 안전하게 렌탈계약 및 결제를 제공하는 서비스</p>
                </div>
            </section>
            <!-- //페이지타이틀 -->


            <!-- 카드CONTENTS -->
            <section class="menu_cont mb-5">
                <div class="card">
                    <div class="card_tit">
                        <h3>모바일 렌탈계약</h3>
                    </div>

                    <!-- 유의사항 -->
                    <div class="card_desc">
                        <h4>※ 유의사항</h4>
                        <ul>
                            <li>테스트MID 결제시 실 승인되며, 당일 자정(24:00) 이전에 자동으로 취소처리 됩니다.</li>
							<li>가상계좌 채번 후 입금할 경우 자동환불되지 않사오니, 가맹점관리자 내 "입금통보테스트" 메뉴를 이용부탁드립니다.<br>(실 입금하신 경우 별도로 환불요청해주셔야 합니다.)</li>
							<li>국민카드 정책상 테스트 결제가 불가하여 오류가 발생될 수 있습니다. 국민, 카카오뱅크 외 다른 카드로 테스트결제 부탁드립니다.</li>
                        </ul>
                    </div>
                    <!-- //유의사항 -->


                    <form name="mobileweb" id="" method="post" class="mt-5" accept-charset="euc-kr">
                        <div class="row g-3 justify-content-between" style="--bs-gutter-x:0rem;">
				    
                            <label class="col-10 col-sm-2 input param" style="border:none;">P_INI_PAYMENT</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_INI_PAYMENT" value="RTPAY">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_MID</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_MID" value="INIpayTest">
                            </label>
				    
                            <label class="col-10 col-sm-2 input param" style="border:none;">P_OID</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_OID" value="mobile_test1234">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_AMT</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_AMT" value="100000">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_GOODS</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_GOODS" value="테스트상품">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_UNAME</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_UNAME" value="테스트">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_MOBILE</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_MOBILE" value="01012345678">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_EMAIL</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_EMAIL" value="test@test.com">
                            </label>
				    		
				    		<input type="hidden" name="P_NEXT_URL" value="https://[가맹점도메인]/INIrtpay_mo_return.jsp">
                            <input type="hidden" name="P_CHARSET" value="utf8">
                            
				    		<label class="col-10 col-sm-2 input param" style="border:none;">P_RESERVED</label>
                            <label class="col-10 col-sm-9 input">
                            	<input type="text" name="P_RESERVED" value="<%=P_RESERVED %>">
                            </label>
                            
                            <label class="col-10 col-sm-2 input param" style="border:none;">P_RECV_POSTNUM</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_RECV_POSTNUM" value="10266">
                            </label>
                            
                            <label class="col-10 col-sm-2 input param" style="border:none;">P_RECV_ADDR</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_RECV_ADDR" value="중구 통일로 92 KG타워">
                            </label>
                            
                            <label class="col-10 col-sm-2 input param" style="border:none;">P_RECV_ADDR_DETAIL</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="P_RECV_ADDR_DETAIL" value="14,15층">
                            </label>
                            
                            <input type="hidden" name="additionalData" value="<%=encodeResult1 %>">
                        </div>
                    </form>
				
				    <button onclick="on_pay()" class="btn_solid_pri col-6 mx-auto btn_lg" style="margin-top:50px">결제 요청</button>
					
                </div>
            </section>
			
        </main>
		
    </body>
</html>