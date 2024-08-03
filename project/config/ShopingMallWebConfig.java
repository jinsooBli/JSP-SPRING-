package com.example.project.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ShopingMallWebConfig implements WebMvcConfigurer {
	@Value("${shop.img.dir}")
	private String imgDir;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/img/**").addResourceLocations("file:" + imgDir);
		/* '/js/**'로 호출하는 자원은 '/static/js/' 폴더 아래에서 찾는다. */ 
//        registry.addResourceHandler("/js/**").addResourceLocations("classpath:/static/js/").setCachePeriod(60 * 60 * 24 * 365); 
		/* '/css/**'로 호출하는 자원은 '/static/css/' 폴더 아래에서 찾는다. */ 
//        registry.addResourceHandler("/css/**").addResourceLocations("classpath:/static/css/").setCachePeriod(60 * 60 * 24 * 365); 
		/* '/img/**'로 호출하는 자원은 '/static/img/' 폴더 아래에서 찾는다. */ 
//        registry.addResourceHandler("/img/**").addResourceLocations("classpath:/static/img/").setCachePeriod(60 * 60 * 24 * 365); 
		/* '/font/**'로 호출하는 자원은 '/static/font/' 폴더 아래에서 찾는다. */ 
//        registry.addResourceHandler("/font/**").addResourceLocations("classpath:/static/font/").setCachePeriod(60 * 60 * 24 * 365);
	}
	
}
