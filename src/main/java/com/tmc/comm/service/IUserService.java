package com.tmc.comm.service;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.tmc.comm.dao.UserDto;

public interface IUserService {
	//login
	public UserDto login(UserDto vo);
	
	//signup
	public int signup(String user_id, String user_pw);
	
	//sendMail
	public void sendMail(String pwd, String address);
	
	//findpw
	public UserDto findPwd(UserDto userDto);
	
	// 비밀번호 복호화
	public String Dec_pw(String user_id);

	// 이메일 중복
	public int checkId(String user_id);
	
    // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(String uid, String sessionId, String test);
     
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public UserDto checkUserWithSessionKey(String sessionId);

}
