package com.tmc.comm.controller;


import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tmc.comm.dao.IUserDao;
import com.tmc.comm.dao.UserDto;
import com.tmc.comm.service.IUserService;

@Controller
public class UserController {
		//서비스
		@Autowired
		IUserService uService;
		
		// 패스워드 암호화
	    @Autowired
	    private PasswordEncoder passwordEncoder;
	    
	    
	    //기본 홈
	    @RequestMapping("/")
		public String root() {
	    		
	    	return "redirect:/login";
		}
		//로그인 화면
		@RequestMapping("/login")
		public String loginScreen(UserDto vo, HttpServletRequest req, HttpSession session,Model model) {
			
			UserDto sessionVo = (UserDto)session.getAttribute("member");

			Cookie[] loginCookie = req.getCookies();
			Cookie[] cf = loginCookie;
			
			
			if(sessionVo == null) {
				System.out.println("/login :::::::::::::::::::::::::::::::::::::::::::::세션이 없습니다" );
				return "/user/login";
			}else {
				String user_id = sessionVo.getUser_id();
				model.addAttribute("user_id", user_id);
				System.out.println("세션있으니 마이페이로 감::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
				return "/user/mypage";	
			}
		}

		// 로그인시작
		@RequestMapping(value = "/startlogin", method = RequestMethod.POST)
		public String login(UserDto vo, HttpServletRequest req, RedirectAttributes rttr, HttpServletResponse response) throws Exception {
			
			HttpSession session = req.getSession();			
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			
			String user_id = req.getParameter("user_id");				 		// 뷰에서 넘어온 아이디
			String de_user_pw = uService.Dec_pw(user_id); 							// DB에 있는 비밀번호 값 들고오기
			
			UserDto login = uService.login(vo);									// 로그인 서비스 실행
			boolean result_pw = encoder.matches(vo.getUser_pw() , de_user_pw); 	// 로그인 받을 비밀번호와 DB에 저장되어있는 비밀번호를 비교
			System.out.println("입력받은 비밀번호:::::::::::::::::::::::::::::::::::::::::::::::::::"+vo.getUser_pw());
			System.out.println("암호화된 비밀번호:::::::::::::::::::::::::::::::::::::::::::::::::::"+de_user_pw);
			
	
			// 쿠키 저장
		    if (login != null && result_pw) {
		    	session.setAttribute("member", login);
		        
		        if (req.getParameter("useCookie") != null) {
		            // 쿠키 생성
		            Cookie loginCookie = new Cookie("loginCookie", session.getId());
		            loginCookie.setValue(user_id);
		            loginCookie.setPath("/");
		            loginCookie.setMaxAge(60*60*24*7);
		            // 전송
		            response.addCookie(loginCookie);
		            Date date_now = new Date(System.currentTimeMillis());
		            SimpleDateFormat fourteen_format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		           String test = fourteen_format.format(date_now);
		            
		            uService.keepLogin(vo.getUser_id(),session.getId(), test);
		        }else {
			
		        }
		    }
			return "redirect:/login";
		}
		
		//회원가입 화면
		@RequestMapping("/signup")
		public String signupScreen() {
			return "/user/signup";
		}
		
		// 회원정보 입력
		@RequestMapping("/doSignup")
		public String singup(HttpServletRequest req, MultipartHttpServletRequest mtfRequest) {
			String user_id = req.getParameter("id");
			String user_pw = req.getParameter("pass");
				
			uService.signup(user_id,user_pw);

			return "/user/login";
		}
		
		//비밀번호 찾기 화면
		@RequestMapping("/findpw")
		public String findpwScreen() {
			return "/user/findpw";
		}
		
		@RequestMapping("/findpwd")
		public String findpwd(UserDto userDto, Model model) {
			
			UserDto user = null;
			user = uService.findPwd(userDto);
			if (user == null) {
				return "redirect:/login";
			} else {
				String pwd = user.getUser_pw();
				String email = user.getUser_id();
				
				System.out.println("비밀번호::::::::::::::::::::::::::::::::::::::::::::"+pwd);
				System.out.println("비밀번호::::::::::::::::::::::::::::::::::::::::::::"+email);
				
				uService.sendMail(pwd, email);
				return "redirect:/login";
			}
		}
		
		

		// 마이페이지
		@RequestMapping("/mypage")
		public String Test(HttpServletRequest req, HttpSession session, Model model) {
			UserDto sessionVo = (UserDto)session.getAttribute("member");
			
			if(sessionVo == null){
				System.out.println("login from login:::::::::::::::::::::::::::::::::::::::::" + sessionVo);
				return "/user/login";
				
			}else {
				
				String user_id = sessionVo.getUser_id();
				System.out.println("user_id in mypage::::::::::::::::::::::::::::::::::::::::::::::::" + user_id);
				model.addAttribute("user_id", user_id);
				System.out.println("마이페이지 from mypage:::::::::::::::::::::::::::::::::::::::::" + sessionVo);
				
				
				return "/user/mypage";
			}
			
		}
		
		// 이메일 중복검사
		@ResponseBody
		@RequestMapping(value = "/checkId") // Json타입 기본 ↓ 공식
		public Map<String, Object> emailCheck(@RequestBody Map<String, Object> map) {

			String user_id = map.get("user_id").toString();
			int isResult = uService.checkId(user_id);
			// System.out.println("isResult:::::::::::::::::::" + isResult);

			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("isResult", isResult);
			return resultMap;
		}
		
		
		// 로그아웃
		@RequestMapping(value = "/logout", method = RequestMethod.GET)
		public String logout(HttpSession session) throws Exception {


			return "/user/login";
		}

}
