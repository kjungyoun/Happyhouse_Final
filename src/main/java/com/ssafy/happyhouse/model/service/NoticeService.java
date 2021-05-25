package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.PageBean;

public interface NoticeService {
	
	List<NoticeDto> searchAll(PageBean bean) throws Exception;
	
	NoticeDto getNotice(int no) throws Exception;
	
	int deleteNotice(int no) throws Exception;
	
	int modifyNotice(NoticeDto notice) throws Exception;
	
	int insertNotice(NoticeDto notice) throws Exception;
	
	int updateViewCnt(int no) throws Exception;
}
