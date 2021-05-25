package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.BusDto;
import com.ssafy.happyhouse.model.HouseDto;
import com.ssafy.happyhouse.model.SubwayDto;

public interface MapService {
	
	BaseAddr getDongPosition(BaseAddr addr)throws Exception;
	
	List<HouseDto> getAptPosition()throws Exception;
	
	List<SubwayDto> getSubway() throws Exception;
	
	List<BusDto> getBus() throws Exception;
	
}
