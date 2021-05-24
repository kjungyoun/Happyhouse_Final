package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/user")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	@Autowired
	JavaMailSender mailSender; // 메일 서비스를 사용하기 위해 의존성을 주입함.

	@GetMapping("/valid/{userid}")
	@ResponseBody
	public int validId(@PathVariable String userid) throws Exception {
		return memberService.validId(userid);
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam String userid, String userpwd, Model model, HttpSession session,
			HttpServletResponse response) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("userpwd", userpwd);
		MemberDto memberDto = memberService.login(map);
		if (memberDto != null) {
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

	// register
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerMember(@RequestParam String userid, String userpwd, String username, String email,
			Model model, HttpSession session) throws Exception {
		MemberDto memberDto = new MemberDto(userid, userpwd, username, email);
		// 세션에 있는 email 정보 없앰
		session.invalidate();
		memberService.registerMember(memberDto);
		return "index";
	}

	// modify
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyMember(@RequestParam String userid, String userpwd, String username, String email, Model model,
			HttpSession session) throws Exception {
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

	// find
	@RequestMapping(value = "/find/{userid}/{email}", method = RequestMethod.GET)
	@ResponseBody
	public int findMember(@PathVariable String userid, @PathVariable String email) throws Exception {
		MemberDto member = new MemberDto();
		member.setUserid(userid);
		member.setEmail(email);
		return memberService.findMember(member);
	}

	// change
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	public String changePwd(HttpServletResponse response, HttpServletRequest request, Model model) throws Exception {
		String userid = request.getParameter("useridN");
		String userpwd = request.getParameter("userpwdN");
		MemberDto member = new MemberDto();
		member.setUserid(userid);
		member.setUserpwd(userpwd);
		System.out.println(member);
		int res = memberService.changePwd(member);
		HttpSession session = request.getSession();
		session.invalidate();
		
//		response.setContentType("text/html; charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		if(res == 1) {
//			out.println("<script>alert('비밀번호가 수정되었습니다.');</script>");
//			out.flush();
//		}else {
//			out.println("<script>alert('비밀번호 수정에 실패하였습니다. 다시 시도해주세요!');</script>");
//			out.flush();
//		}
		
		String msg = null;
		
		if(res == 1) {
			msg = "비밀번호가 수정되었습니다!";
		}else {
			msg = "비밀번호 수정에 실패하였습니다. 다시 시도해주세요!";
		}
		
		model.addAttribute("alert", msg);
		
		return "index";
	}

	// mailSending 코드
	@RequestMapping(value = "/auth", method = RequestMethod.POST)
	public ModelAndView mailSending(HttpServletRequest request, String email, HttpServletResponse response_email)
			throws IOException {

		Random r = new Random();
		int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)

		String type = request.getParameter("type");
		String userid = request.getParameter("useridF");
		String setfrom = "kjyoun0729@gamil.com";
		String tomail = null;
		if(type.equals("register")) {
			tomail = request.getParameter("email"); // 받는 사람 이메일			
		}else {
			tomail = request.getParameter("emailF"); // 받는 사람 이메일
		}
		String title = "회원가입 인증 이메일 입니다."; // 제목
		String content =

				System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성

						System.getProperty("line.separator") +

						"안녕하세요 회원님 저희 홈페이지를 찾아주셔서 감사합니다"

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						" 인증번호는 " + dice + " 입니다. "

						+ System.getProperty("line.separator") +

						System.getProperty("line.separator") +

						"받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		ModelAndView mv = new ModelAndView(); // ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
		mv.setViewName("/index"); // 뷰의이름
		mv.addObject("dice", dice);
		mv.addObject("type", type);

		System.out.println("mv : " + mv);

		HttpSession session = request.getSession();
		session.setAttribute("email", email);
		session.setAttribute("userid", userid);

		response_email.setContentType("text/html; charset=UTF-8");
		PrintWriter out_email = response_email.getWriter();
		out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
		out_email.flush();

		return mv;

	}

	// 이메일로 받은 인증번호를 입력하고 전송 버튼을 누르면 맵핑되는 메소드.
	// 내가 입력한 인증번호와 메일로 입력한 인증번호가 맞는지 확인해서 맞으면 회원가입 페이지로 넘어가고,
	// 틀리면 다시 원래 페이지로 돌아오는 메소드
	@RequestMapping(value = "/auth/{dice}/{type}", method = RequestMethod.POST)
	public ModelAndView join_injeung(String code, @PathVariable String dice, @PathVariable String type,
			HttpServletResponse response_equals, HttpServletRequest request) throws IOException {

		System.out.println("마지막 : email_injeung : " + code);

		System.out.println("마지막 : dice : " + dice);

		// 페이지이동과 자료를 동시에 하기위해 ModelAndView를 사용해서 이동할 페이지와 자료를 담음

		ModelAndView mv = new ModelAndView();
		String userid = request.getParameter("useridC");
		System.out.println(userid);

		mv.setViewName("/index");

		mv.addObject("authorize", code);

		if (code.equals(dice) && type.equals("register")) {

			// 인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함

			mv.setViewName("/index");

			mv.addObject("authorize", code);
			mv.addObject("type", type); 
			mv.addObject("dice", null); 
			
			System.out.println("mv : " + mv);

			// 만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을
			// 한번더 입력할 필요가 없게 한다.

			response_equals.setContentType("text/html; charset=UTF-8");
			PrintWriter out_equals = response_equals.getWriter();
			out_equals.println("<script>alert('인증번호가 일치하였습니다. 회원가입창으로 이동합니다.');</script>");
			out_equals.flush();

			return mv;

		} else if (code.equals(dice) && type.equals("find")) {

			// 인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함

			mv.setViewName("/index");

			mv.addObject("authorize", code);
			mv.addObject("dice", null);
			mv.addObject("type", type);
			mv.addObject("userid", userid);
			
			
			System.out.println("mv : " + mv);

			// 만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을
			// 한번더 입력할 필요가 없게 한다.

			response_equals.setContentType("text/html; charset=UTF-8");
			PrintWriter out_equals = response_equals.getWriter();
			out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 변경창으로 이동합니다.');</script>");
			out_equals.flush();

			return mv;

		} else if (code != dice) {

			ModelAndView mv2 = new ModelAndView();

			mv2.setViewName("/index");
			mv.addObject("dice", dice);
			
			System.out.println("mv : " + mv);

			response_equals.setContentType("text/html; charset=UTF-8");
			PrintWriter out_equals = response_equals.getWriter();
			out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.');</script>");
			out_equals.flush();

			return mv2;

		}

		return mv;

	}

}
