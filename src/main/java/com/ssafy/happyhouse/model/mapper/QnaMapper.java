package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.QnaDto;



@Mapper
public interface QnaMapper {
	
	//질문 글 작성
	public int writeQna(QnaDto qnaDto);
	
	//글 목록
	List<QnaDto> searchAll(PageBean bean);
	int totalCount(PageBean bean);
	
	//글 상세
	QnaDto getQna(int no);
	
	//글 삭제
	int deleteQna(int no);
	
	//글 수정
	int modifyQna(QnaDto qnaDto);
	
	
}
