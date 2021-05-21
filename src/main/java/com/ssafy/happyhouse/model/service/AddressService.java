package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.BaseAddr;

public interface AddressService {
	
	List<String> findCity()throws Exception;
	
	List<String> findGugun(String city)throws Exception;
	
	List<String> findDong(BaseAddr addr)throws Exception;
}
