package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.HouseDto;

public interface MapService {
	
	BaseAddr getDongPosition(BaseAddr addr)throws Exception;
	
	List<HouseDto> getAptPosition()throws Exception;
	
}
