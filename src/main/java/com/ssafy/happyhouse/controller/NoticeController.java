package com.ssafy.happyhouse.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice(PageBean bean, Model model)throws Exception {
		System.out.println(bean);
		List<NoticeDto> list = noticeService.searchAll(bean);
		System.out.println(list);
		model.addAttribute("list", list);
		model.addAttribute("bean", bean);
		return "notice";
	}
	
	@RequestMapping(value = "/noticeinfo", method = RequestMethod.GET)
	public String noticeinfo(int no, Model model)throws Exception {
		int res = noticeService.updateViewCnt(no);
		if(res == 1) {
			NoticeDto notice = noticeService.getNotice(no);
			notice.setContents(notice.getContents().replace("\r\n", "<br>"));
			model.addAttribute("notice", notice);
			return "noticeinfo";
		}else {
			model.addAttribute("msg", "공지사항 상세 조회 중 오류 발생!!!");
			return "error/error";
		}
	}
	
	@GetMapping("/writeNotice")
	public String writeNotice(NoticeDto notice, Model model) throws Exception{
		System.out.println(notice);
		int res = noticeService.insertNotice(notice);
		if(res == 1) {
			return "redirect:/notice";			
		}else {
			model.addAttribute("msg", "공지사항 작성 중 오류 발생!");
			return "error/error";
		}
//		response.setContentType("text/html; charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		if(res == 1) {
//			out.println("<script>alert('공지사항 작성에 성공했습니다.')</script>");
//			out.flush();
//		}else {
//			out.println("<script>alert('공지사항 작성에 실패했습니다. 다시 시도해주세요.')</script>");
//			out.flush();
//		}
	}
	
	@GetMapping("/modifyNotice")
	public String modifyNotice(NoticeDto notice, Model model) throws Exception{
		int res = noticeService.modifyNotice(notice);
		if(res == 1) {
			NoticeDto result = noticeService.getNotice(notice.getNo());
			result.setContents(result.getContents().replace("\r\n", "<br>"));
			model.addAttribute("msg", "공지사항 수정 완료!");
			model.addAttribute("notice", result);
			return "noticeinfo";
		}else {
			model.addAttribute("msg", "공지사항 수정 중 오류 발생!");
			return "error/error";
		}
	}
	
	@GetMapping("deleteNotice")
	public String deleteNotice(int no, Model model) throws Exception{
		int res = noticeService.deleteNotice(no);
		if(res == 1) {
			return "redirect:/notice";
		}else {
			model.addAttribute("msg", "공지사항 수정 중 오류 발생!");
			return "error/error";
		}
	}
}
