package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.QnaDto;


public interface QnaService {

	//질문 글 작성
	public int writeQna(QnaDto qnaDto);
	
	//글 목록
	List<QnaDto> searchAll(PageBean bean);
	
	//글 상세
	QnaDto getQna(int no);
	
	//글 삭제
	int deleteQna(int no);
	
	//글 수정
	int modifyQna(QnaDto qnaDto);
	
}
