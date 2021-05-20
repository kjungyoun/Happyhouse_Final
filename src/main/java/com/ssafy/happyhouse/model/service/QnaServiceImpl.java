package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.QnaDto;
import com.ssafy.happyhouse.model.mapper.QnaMapper;
import com.ssafy.happyhouse.util.PageUtility;


@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaMapper qnaMapper;
	
	@Override
	public int writeQna(QnaDto qnaDto) {
		return qnaMapper.writeQna(qnaDto);
	}

	@Override
	public List<QnaDto> searchAll(PageBean bean) {
		bean.setInterval(5);
		int total = qnaMapper.totalCount(bean);
		PageUtility bar = new PageUtility(bean.getInterval(), total, bean.getPageNo());
		bean.setPageLink(bar.getPageBar());
		return qnaMapper.searchAll(bean);
	}
	
	@Override
	public QnaDto getQna(int no) {
		QnaDto dto= qnaMapper.getQna(no);
		return dto;
	}

	@Override
	@Transactional
	public int deleteQna(int no) {
		return qnaMapper.deleteQna(no);
	}

	@Override
	@Transactional
	public int modifyQna(QnaDto qnaDto) {
		return qnaMapper.modifyQna(qnaDto);
	}
	
	

}
