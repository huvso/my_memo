<?php
        require_once('libs/INIStdPayUtil.php');
        require_once('libs/HttpClient.php');
 
        $util = new INIStdPayUtil();
 
        try {
 
            //#############################
            // 인증결과 파라미터 수신
            //#############################

            if (strcmp("0000", $_REQUEST["resultCode"]) == 0) {
 
                //############################################
                // 1.전문 필드 값 설정(***가맹점 개발수정***)
                //############################################
 
                $mid        = $_REQUEST["mid"];
                $timestamp  = $util->getTimestamp();
                $charset    = "UTF-8";
                $format     = "JSON";
                $authToken  = $_REQUEST["authToken"]; 
                $authUrl    = $_REQUEST["authUrl"];
                $netCancel  = $_REQUEST["netCancelUrl"];        
                $merchantData = $_REQUEST["merchantData"];
 
                //#####################
                // 2.signature 생성
                //#####################
                $signParam["authToken"] = $authToken;   // 필수
                $signParam["timestamp"] = $timestamp;   // 필수
                // signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
                $signature = $util->makeSignature($signParam);
 
 
                //#####################
                // 3.API 요청 전문 생성
                //#####################
                $authMap["mid"]        = $mid;       // 필수
                $authMap["authToken"]  = $authToken; // 필수
                $authMap["signature"]  = $signature; // 필수
                $authMap["timestamp"]  = $timestamp; // 필수
                $authMap["charset"]    = $charset;   // default=UTF-8
                $authMap["format"]     = $format;    // default=XML
 
                try {
 
                    $httpUtil = new HttpClient();
 
                    //#####################
                    // 4.API 통신 시작
                    //#####################
 
                    $authResultString = "";
                    if ($httpUtil->processHTTP($authUrl, $authMap)) {
                        $authResultString = $httpUtil->body;
 
                    } else {
                        echo "Http Connect Error\n";
                        echo $httpUtil->errormsg;
 
                        throw new Exception("Http Connect Error");
                    }
 
                    //############################################################
                    //5.API 통신결과 처리(***가맹점 개발수정***)
                    //############################################################
                    
                    $resultMap = json_decode($authResultString, true);
 
 
                } catch (Exception $e) {
                    //    $s = $e->getMessage() . ' (오류코드:' . $e->getCode() . ')';
                    //####################################
                    // 실패시 처리(***가맹점 개발수정***)
                    //####################################
                    //---- db 저장 실패시 등 예외처리----//
                    $s = $e->getMessage() . ' (오류코드:' . $e->getCode() . ')';
                    echo $s;
 
                    //#####################
                    // 망취소 API
                    //#####################
 
                    $netcancelResultString = ""; // 망취소 요청 API url(고정, 임의 세팅 금지)
                    if ($httpUtil->processHTTP($netCancel, $authMap)) {
                        $netcancelResultString = $httpUtil->body;
                    } else {
                        echo "Http Connect Error\n";
                        echo $httpUtil->errormsg;
 
                        throw new Exception("Http Connect Error");
                    }
 
                    echo "<br/>## 망취소 API 결과 ##<br/>";
                    
                    /*##XML output##*/
                    //$netcancelResultString = str_replace("<", "&lt;", $$netcancelResultString);
                    //$netcancelResultString = str_replace(">", "&gt;", $$netcancelResultString);
 
                    // 취소 결과 확인
                    echo "<p>". $netcancelResultString . "</p>";
                }
            } else {
 
            }
        } catch (Exception $e) {
            $s = $e->getMessage() . ' (오류코드:' . $e->getCode() . ')';
            echo $s;
        }
?>
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


                    <form name="" id="result" method="post" class="mt-5">
                    <div class="row g-3 justify-content-between" style="--bs-gutter-x:0rem;">
 
                        <label class="col-10 col-sm-2 gap-2 input param" style="border:none;">resultCode</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["resultCode"] , $resultMap) ? $resultMap["resultCode"] : $_REQUEST["resultCode"] ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">resultMsg</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["resultMsg"] , $resultMap) ? $resultMap["resultMsg"] : $_REQUEST["resultMsg"] ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">tid</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["tid"] , $resultMap) ? $resultMap["tid"] : "null" ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">MOID</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["MOID"] , $resultMap) ? $resultMap["MOID"] : "null" ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">TotPrice</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["TotPrice"] , $resultMap) ? $resultMap["TotPrice"] : "null" ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">goodName</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["goodName"] , $resultMap) ? $resultMap["goodName"] : "null" ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">applDate</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["applDate"] , $resultMap) ? $resultMap["applDate"] : "null" ) ?>
                        </label>
						
						<label class="col-10 col-sm-2 input param" style="border:none;">applTime</label>
                        <label class="col-10 col-sm-9 reinput">
                            <?php echo @(in_array($resultMap["applTime"] , $resultMap) ? $resultMap["applTime"] : "null" ) ?>
                        </label>
 
                    </div>
                </form>
				
				<button onclick="location.href='INIrtpay_pc_req.php'" class="btn_solid_pri col-6 mx-auto btn_lg" style="margin-top:50px">돌아가기</button>
					
                </div>
            </section>
			
        </main>
		
    </body>
</html>