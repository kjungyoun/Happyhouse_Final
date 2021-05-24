package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;


@Controller
@RequestMapping("/user")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/valid/{userid}")
	@ResponseBody
	public int validId(@PathVariable String userid) throws Exception{
		return memberService.validId(userid);
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam String userid, String userpwd, Model model, HttpSession session, HttpServletResponse response) throws Exception{
			Map<String,String> map = new HashMap<String,String>();
			map.put("userid", userid);
			map.put("userpwd", userpwd);
			MemberDto memberDto = memberService.login(map);
			if(memberDto != null) {
				session.setAttribute("userinfo", memberDto);
				System.out.println("------------------------" + ((MemberDto) session.getAttribute("userinfo")).getUserid());
			} else {
				model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
			}
		return "index";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// mypage로 이동
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(HttpSession session) {
		return "mypage";
	}
	
	//register
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerMember(@RequestParam String userid, String userpwd, String username, String email, Model model) throws Exception {
		MemberDto memberDto = new MemberDto(userid, userpwd, username, email);
		memberService.registerMember(memberDto);
		return "index";
	}
	
	
	// modify
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyMember(@RequestParam String userid, String userpwd, String username, String email, Model model, HttpSession session) throws Exception {
		MemberDto memberDto = new MemberDto(userid, userpwd, username, email);
		memberService.modifyMember(memberDto);
		session.invalidate();
		return "redirect:/";
	}
	
	
	// delete
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteMember(@RequestParam String userid, HttpSession session) throws Exception {
		memberService.deleteMember(userid);
		session.invalidate();
		return "redirect:/";
	}

}
