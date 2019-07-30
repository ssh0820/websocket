package org.jbp.model2.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheck 
implements HandlerInterceptor {
	/*
	//후처리(컨트롤러 갔다온 후)
	@Override
	public void postHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler,
			ModelAndView modelAndView) throws Exception {
		
		System.out.println("후처리");
		
		Map<String, Object> map =
				modelAndView.getModel();
		
		Set<String> keys = map.keySet();
		
		for( String key  : keys) {
			
			Object obj = map.get(key);
			System.out.println("key : " + key);
			System.out.println("attribute : "+obj);
			
		}//for end
		
	}
	*/
	
	//전처리(컨트롤러 가기전)
	
	@Override
	public boolean preHandle(
			HttpServletRequest request,
			HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = 
				request.getSession();
		
		Object loginMember =
				session.getAttribute("loginUser");
		
		if(loginMember==null) {
			
			response.sendRedirect("/");
			
			return false;
		}else {
			//로그인 되었으니까
			return true;
		}//if~else end
		
	}//preHandle() end
	
	
}




