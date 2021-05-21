package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.HouseDto;

@Mapper
public interface MapMapper {
	
	BaseAddr getDongPosition(BaseAddr addr);
	
	List<HouseDto> getAptPosition(BaseAddr addr);
}
