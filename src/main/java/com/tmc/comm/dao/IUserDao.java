package com.tmc.comm.dao;
import java.sql.Date;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IUserDao {
	// 로그인
	public UserDto login(UserDto vo);
	
	// 로그인
	public String login2(@Param("user_id") String user_id);
	
	// 회원가입
	public int signup(
			String user_id,
			String user_pw
			);
	
	// 비밀번호 찾기
	public UserDto findpwd(UserDto userDto);
	
	// 비밀번호 복호화
	public String Dec_pw(String user_id);
	
	// 비밀번호 업데이트
	public int updatePw(String user_pw, String user_id);

	// ID 중복확인
	public int checkId(@Param("user_id") String user_id);	
	
    // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(@Param("user_id") String uid, 
    						@Param("sessionid")String sessionId,
    						@Param("date") String next);
     
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public UserDto checkUserWithSessionKey(String user_id);
}
