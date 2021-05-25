package com.ssafy.happyhouse.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "index";
	}
	
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice() {
		return "notice";
	}
	
	@RequestMapping(value = "/noticeinfo", method = RequestMethod.GET)
	public String noticeinfo() {
		return "noticeinfo";
	}
	
	@RequestMapping(value = "/qna", method =  RequestMethod.GET)
	public String qna() {
		return "qna";
	}
	
	@RequestMapping(value="/pollutionInfo", method=RequestMethod.GET)
	public String pollution() {
		return "pollutionInfo";
	}
	
	@RequestMapping(value="/shopInfo", method=RequestMethod.GET)
	public String shop() {
		return "shopInfo";
	}
}
