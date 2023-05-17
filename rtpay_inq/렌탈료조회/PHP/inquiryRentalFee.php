<?php

header("Content-Type: text/html; charset=utf-8"); 


    //step1. 요청을 위한 파라미터 설정

    mt_srand((double)microtime() * 1000000);
    $rand_num = mt_rand(3, 2018);

    $mid = "INIpayTest";
    $timestamp   = date("YmdHis");

    $sid = (string)$mid.(string)$timestamp.(string)$rand_num ;

    $clientType = "MR";
    $amount = "100000";


    //step2. key=value post 전송

    $data = array(
        'mid' => $mid,
        'clientType' => $clientType,
        'sid' => $sid,
        'amount' => $amount
    );

    $post_data = json_encode($data);

 
    $url = "https://inirt.inicis.com/contract/v1/inquiryRentalFee";  
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Accept: application/json', 'Content-Type: application/json'));
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
     
    $response = curl_exec($ch);
    curl_close($ch);


//step3. 결과출력

echo $response;

?>