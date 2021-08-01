package com.tmc.comm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	
	@Autowired
	Interceptor inter;
	
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(inter)
        .addPathPatterns("/login");
    }
    
}
