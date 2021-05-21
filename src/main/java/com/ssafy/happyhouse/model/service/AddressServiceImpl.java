package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.mapper.AddressMapper;

@Controller
@Transactional
public class AddressServiceImpl implements AddressService {

	@Autowired
	private AddressMapper addressMapper;
	
	@Override
	public List<String> findCity()throws Exception {
		return addressMapper.findCity();
	}

	@Override
	public List<String> findGugun(String city)throws Exception {
		return addressMapper.findGugun(city);
	}

	@Override
	public List<String> findDong(BaseAddr addr)throws Exception {
		return addressMapper.findDong(addr);
	}

}
