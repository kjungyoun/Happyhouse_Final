package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeMapper {

	public void writeArticle(NoticeDto noticeDto) throws SQLException;
	public List<NoticeDto> listArticle(Map<String, Object> map) throws SQLException;
	public int getTotalCount(Map<String, String> map) throws SQLException;
	
	public NoticeDto getArticle(int articleno) throws SQLException;
	public void modifyArticle(NoticeDto noticeDto) throws SQLException;
	public void deleteArticle(int articleno) throws SQLException;
	
}
