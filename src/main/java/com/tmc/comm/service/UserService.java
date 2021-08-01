package com.tmc.comm.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.tmc.comm.dao.IUserDao;
import com.tmc.comm.dao.UserDto;

@Service
public class UserService implements IUserService {
	
	
    @Autowired
    private PasswordEncoder passwordEncoder;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private static final String FROM_ADDRESS = "hyde940@naver.com";
	
	@Autowired
	IUserDao uDao;
	
	// 로그인
	@Override
	public UserDto login(UserDto vo){
		
		return uDao.login(vo);
	}
	
	// 회원가입
	@Override
	public int signup(String user_id, String user_pw) {

		String encode_pw = passwordEncoder.encode(user_pw);
		
		uDao.signup(user_id,encode_pw);
		return 0;
	}
	
	// 비밀번호 찾기
	@Override
	public UserDto findPwd(UserDto userDto) {
		
		return uDao.findpwd(userDto);
	}
	
	// 이메일 전송
	@Override
	@Transactional
	public void sendMail(String pwd, String address) {
		// TODO Auto-generated method stub
		
		pwd = getTempPassword();	// 임시 비밀번호
		String encode_pw = passwordEncoder.encode(pwd); // 암호화된 비밀번호
		System.out.println("임시 비밀번호 :::::::::::::::::::::::::::::::::::::::::::"+pwd);
		System.out.println("업데이트 할 패스워드 :::::::::::::::::::::::::::::::::::::::::::"+encode_pw);
		System.out.println("업데이트 할 패스워드 아이디:::::::::::::::::::::::::::::::::::::::::::"+address);
		
        uDao.updatePw(encode_pw, address);
        
        //이메일 발신
		SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(address);
        message.setFrom(FROM_ADDRESS);
        message.setSubject("TCM 비밀번호찾기 안내 메일입니다.");
        message.setText("임시비밀번호는 "+pwd+"입니다.");
        mailSender.send(message);
	}
	
	// 10자리 랜덤 난수 생성
    public String getTempPassword(){
        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        return str;
    }
	
	// 비밀번호 복호화
	public String Dec_pw(String user_id) {
		
		return uDao.Dec_pw(user_id); 
	}
	
	// 이메일 중복
	public int checkId(String user_id) {
		return uDao.checkId(user_id);
	}
	
    @Override
    public void keepLogin(String uid, String sessionId, String next) {
 
        uDao.keepLogin(uid, sessionId, next);
    }
 
    @Override
    public UserDto checkUserWithSessionKey(String sessionId) {
        return uDao.checkUserWithSessionKey(sessionId);
    }
}
