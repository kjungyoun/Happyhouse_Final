package com.ssafy.happyhouse.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.BaseAddr;

@Mapper
public interface AddressMapper {
	
	List<String> findCity();
	
	List<String> findGugun(String city);
	
	List<String> findDong(BaseAddr addr);
}
