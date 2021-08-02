package com.tmc.comm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.AsyncHandlerInterceptor;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.tmc.comm.dao.IUserDao;
import com.tmc.comm.dao.UserDto;
import com.tmc.comm.service.IUserService;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@Configuration
public class Interceptor implements HandlerInterceptor{
	
	//서비스
	@Autowired
	IUserDao uDao;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("프리핸들:::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
		
				
		
		
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		UserDto sessionVo = (UserDto)session.getAttribute("member");
        Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
	
        if ( loginCookie !=null ){
        	if ( sessionVo == null ){// 로그인된 세션이 없는 경우...
            // 우리가 만들어 논 쿠키를 꺼내온다.

// 쿠키가 존재하는 경우(이전에 로그인때 생성된 쿠키가 존재한다는 것)
                // loginCookie의 값을 꺼내오고 -> 즉, 저장해논 세션Id를 꺼내오고
                String sessionId = loginCookie.getValue();
                // 세션Id를 checkUserWithSessionKey에 전달해 이전에 로그인한적이 있는지 체크하는 메서드를 거쳐서
                // 유효시간이 > now() 인 즉 아직 유효시간이 지나지 않으면서 해당 sessionId 정보를 가지고 있는 사용자 정보를 반환한다.
                UserDto userVO = uDao.checkUserWithSessionKey(sessionId);
                 
                if ( userVO !=null ){// 그런 사용자가 있다면
                    // 세션을 생성시켜 준다.
                    session.setAttribute("member", userVO);
                    return true;
                }

             
            // 이제 아래는 로그인도 안되있고 쿠키도 존재하지 않는 경우니까 다시 로그인 폼으로 돌려보내면 된다.
            // 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
            response.sendRedirect("/notice_list");
            return false;
        }
        }
         
        return true;

	}
}