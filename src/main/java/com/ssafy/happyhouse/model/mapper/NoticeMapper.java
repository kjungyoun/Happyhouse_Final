package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.PageBean;


@Mapper
public interface NoticeMapper {
	
	List<NoticeDto> searchAll(PageBean bean);
	
	NoticeDto getNotice(int no);
	
	int totalCount(PageBean bean);
	
	int deleteNotice(int no) throws Exception;
	
	int modifyNotice(NoticeDto notice) throws Exception;
	
	int insertNotice(NoticeDto notice) throws Exception;
	
	int updateViewCnt(int no) throws Exception;
}
