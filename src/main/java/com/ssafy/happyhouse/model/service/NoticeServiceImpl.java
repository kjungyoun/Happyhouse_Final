package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.mapper.NoticeMapper;
import com.ssafy.happyhouse.util.PageUtility;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;
	
	
	@Override
	public List<NoticeDto> searchAll(PageBean bean) throws Exception {
		bean.setInterval(5);
		int total = noticeMapper.totalCount(bean);
		PageUtility util = new PageUtility(bean.getInterval(), total, bean.getPageNo());
		bean.setPageLink(util.getPageBar());
		return noticeMapper.searchAll(bean);
	}

	@Override
	public NoticeDto getNotice(int no) throws Exception {		
		return noticeMapper.getNotice(no);
	}

	@Override
	public int deleteNotice(int no) throws Exception {
		return noticeMapper.deleteNotice(no);
	}

	@Override
	public int modifyNotice(NoticeDto notice) throws Exception {
		return noticeMapper.modifyNotice(notice);
	}

	@Override
	public int insertNotice(NoticeDto notice) throws Exception {
		return noticeMapper.insertNotice(notice);
	}

	@Override
	public int updateViewCnt(int no) throws Exception {
		return noticeMapper.updateViewCnt(no);
		
	}

}
