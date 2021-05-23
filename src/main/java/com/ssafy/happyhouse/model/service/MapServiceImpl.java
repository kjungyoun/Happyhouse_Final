package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.HouseDto;
import com.ssafy.happyhouse.model.mapper.MapMapper;

@Service
public class MapServiceImpl implements MapService {
	
	@Autowired
	private MapMapper map;
	
	@Override
	public BaseAddr getDongPosition(BaseAddr addr)throws Exception {
		return map.getDongPosition(addr);
	}

	@Override
	public List<HouseDto> getAptPosition()throws Exception {
		return map.getAptPosition();
	}

}
