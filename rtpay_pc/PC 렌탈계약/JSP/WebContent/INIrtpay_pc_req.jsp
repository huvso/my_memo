<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inicis.std.util.SignatureUtil"%>
<%@page import="java.util.*"%>
<%

    // 1.전문 필드 값 설정(***가맹점 개발수정***)
    String mid= "INIpayTest";// 가맹점 ID(가맹점 수정후 고정)

    String signKey= "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";// 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
    String timestamp= SignatureUtil.getTimestamp();// util에 의해서 자동생성

    String oid= mid+"_"+SignatureUtil.getTimestamp();// 가맹점 주문번호(가맹점에서 직접 설정)
    String price= "100000";// 상품가격(특수기호 제외, 가맹점에서 직접 설정)


    // 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
    String mKey = SignatureUtil.hash(signKey, "SHA-256");

    // signature 생성
    Map<String, String> signParam = new HashMap<String, String>();

    signParam.put("oid", oid); // 필수
    signParam.put("price", price);// 필수
    signParam.put("timestamp", timestamp);// 필수

    String signature = SignatureUtil.makeSignature(signParam);


    // 3. 렌탈신용보험(SGI) 가입 가맹점 추가정보
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

%>
<!DOCTYPE html>
<html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport"
            content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <title>KG이니시스 결제샘플</title>
        <link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/bootstrap.min.css">
		
		<!--테스트 JS--><script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
		<!--운영 JS> <script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script> -->
        <script type="text/javascript">
            function paybtn() {
                INIStdPay.pay('SendPayForm_id');
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
                        <h3>PC 렌탈계약</h3>
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


                    <form name="" id="SendPayForm_id" method="post" class="mt-5">
                        <div class="row g-3 justify-content-between" style="--bs-gutter-x:0rem;">
				    
                            <!--label class="col-10 col-sm-2 gap-2 input param" style="border:none;">version</label>
                            <label class="col-10 col-sm-9 input"-->
                                <input type="hidden" name="version" value="1.0">
                            <!--/label-->
				    
                            <label class="col-10 col-sm-2 input param" style="border:none;">gopaymethod</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="gopaymethod" value="rtpay">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">mid</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="mid" value="<%=mid%>">
                            </label>
				    
                            <label class="col-10 col-sm-2 input param" style="border:none;">oid</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="oid" value="<%=oid%>">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">price</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="price" value="<%=price%>">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">timestamp</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="timestamp" value="<%=timestamp%>">
                            </label>
				    
				    
                            <input type="hidden" name="signature" value="<%=signature%>">
				    		<input type="hidden" name="mKey" value="<%=mKey%>">
                            <input type="hidden" name="currency" value="WON">
				    		
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">goodname</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="goodname" value="테스트상품">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">buyername</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="buyername" value="테스트">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">buyertel</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="buyertel" value="01012345678">
                            </label>
				    		
				    		<label class="col-10 col-sm-2 input param" style="border:none;">buyeremail</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="buyeremail" value="test@test.com">
                            </label>
				    		
				    		<input type="hidden" name="returnUrl" value="https://[가맹점도메인]/INIrtpay_pc_return.jsp">
                            <input type="hidden" name="closeUrl" value="https://[가맹점도메인]/close.jsp">
                            
				    		<label class="col-10 col-sm-2 input param" style="border:none;">acceptmethod</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="acceptmethod" value="">
                            </label>
                            
                            <label class="col-10 col-sm-2 input param" style="border:none;">postNum</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="postNum" value="10266">
                            </label>
                            <label class="col-10 col-sm-2 input param" style="border:none;">address</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="address" value="서울특별시 중구 통일로 92">
                            </label>
                            <label class="col-10 col-sm-2 input param" style="border:none;">addressDtl</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="addressDtl" value="KG타워 14,15층">
                            </label>
                            <label class="col-10 col-sm-2 input param" style="border:none;">rentalCompNm</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="rentalCompNm" value="이니시스">
                            </label>
                            <label class="col-10 col-sm-2 input param" style="border:none;">rentalCompNo</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="rentalCompNo" value="2208155597">
                            </label>
                            <label class="col-10 col-sm-2 input param" style="border:none;">rentalCompPhone</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="rentalCompPhone" value="01012340000">
                            </label>
                            <label class="col-10 col-sm-2 input param" style="border:none;">rentalRecipientNm</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="rentalRecipientNm" value="홍길동">
                            </label>
                             <label class="col-10 col-sm-2 input param" style="border:none;">rentalRecipientPhone</label>
                            <label class="col-10 col-sm-9 input">
                                <input type="text" name="rentalRecipientPhone" value="01000001234">
                            </label>
                            
                            <input type="hidden" name="additionalData" value="<%=encodeResult1 %>">
                        
							
                        </div>
                    </form>
				
				    <button onclick="paybtn()" class="btn_solid_pri col-6 mx-auto btn_lg" style="margin-top:50px">결제 요청</button>
					
                </div>
            </section>
			
        </main>
		
    </body>
</html>