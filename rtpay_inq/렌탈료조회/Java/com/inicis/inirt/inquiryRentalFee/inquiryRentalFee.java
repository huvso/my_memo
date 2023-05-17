package com.inicis.inirt.inquiryRentalFee;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;

public class inquiryRentalFee {

	public static void main(String[] args) {

	    //step1. 요청을 위한 파라미터 설정
	    String mid = "INIpayTest"; 
	    String clientType = "MR";
	    
	    SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
	    String today = sdf.format(Calendar.getInstance().getTime());
	    
	    double random = Math.random()*1000;
	    String num = Integer.toString((int)random);
	    
	    String sid = "RENTAL"+mid+today+num;
	    String amount = "100000";

		// Request URL
		String apiUrl = "https://inirt.inicis.com/contract/v1/inquiryRentalFee";

	    JSONObject respJson = new JSONObject();
	    respJson.put("mid",mid);
	    respJson.put("clientType",clientType);
	    respJson.put("sid", sid);
	    respJson.put("amount", amount);
		
		//step2. key=value 로 post 요청
		try {
			URL apiurl = new URL(apiUrl);
			HttpURLConnection conn = (HttpURLConnection) apiurl.openConnection();
			
			if (conn != null) {
				conn.setRequestProperty("Content-Type", "application/json; charset=utf-8");
				conn.setRequestMethod("POST");
				conn.setDefaultUseCaches(false);
				conn.setDoOutput(true);
				
				if (conn.getDoOutput()) {
					conn.getOutputStream().write(respJson.toString().getBytes("UTF-8"));
					conn.getOutputStream().flush();
					conn.getOutputStream().close();
				}

				conn.connect();
				
					BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
					
					//step3. 요청 결과
					System.out.println(br.readLine());
					br.close();
				}

		}catch(Exception e ) {
			e.printStackTrace();
		} 
	}
}

