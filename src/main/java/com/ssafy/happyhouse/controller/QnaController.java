package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.QnaDto;
import com.ssafy.happyhouse.model.service.QnaService;


@RestController
@RequestMapping("/qna.do")
@CrossOrigin("*")
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@GetMapping("/getLoginId")
	public ResponseEntity<String> getLoginId(HttpSession session) {
		MemberDto curId = (MemberDto)session.getAttribute("userinfo");
		if(curId == null) {
			return null;
		}
//		System.out.println("=================getLoginId================"+curId);
		return new ResponseEntity<String>(curId.getUserid(),HttpStatus.OK);
	}
	
	@PostMapping
	public ResponseEntity<Integer> writeQna(@RequestBody QnaDto qnaDto) {
		int ret = qnaService.writeQna(qnaDto);
		return new ResponseEntity<Integer>(ret, HttpStatus.OK);
	}
	
	@GetMapping("{no}")
	public ResponseEntity<QnaDto> getQna(@PathVariable int no, HttpSession session) {
		QnaDto dto = qnaService.getQna(no);
		MemberDto curId = (MemberDto)session.getAttribute("userinfo");
		if(curId != null) 
			dto.setLoginId(curId.getUserid());
		System.out.println(dto);
		return new ResponseEntity<QnaDto>(dto,HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<List<QnaDto>> searchAll(String key, String word) {
		PageBean bean = new PageBean();
		bean.setKey(key);
		bean.setWord(word);
		List<QnaDto> list = qnaService.searchAll(bean);
		return new ResponseEntity<List<QnaDto>>(list,HttpStatus.OK);
	}
	
	@PutMapping("{no}")
	public ResponseEntity<Integer> modifyQna(@RequestBody QnaDto qnaDto, @PathVariable int no) {
		qnaDto.setNo(no);
		int ret = qnaService.modifyQna(qnaDto);
		return new ResponseEntity<Integer>(ret,HttpStatus.OK);
	}
	
	@DeleteMapping("{no}")
	public ResponseEntity<Integer> deleteQna(@PathVariable int no) {
		int ret = qnaService.deleteQna(no);		
		return new ResponseEntity<Integer>(ret,HttpStatus.OK);
	}
	
	
}
