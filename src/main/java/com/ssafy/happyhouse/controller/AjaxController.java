package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.HouseDto;
import com.ssafy.happyhouse.model.service.AddressService;
import com.ssafy.happyhouse.model.service.MapService;

@RestController
@CrossOrigin("*")
public class AjaxController {
	
	@Autowired
	private AddressService addrService;
	
	@Autowired
	private MapService mapService;
	
	// -------------------select box 구현----------------
	
	@GetMapping("/select")
	public ResponseEntity<List<String>> getCity() throws Exception{
		List<String> res = addrService.findCity();
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
	@GetMapping("/select/{city}")
	public ResponseEntity<List<String>> getGugun(@PathVariable String city) throws Exception{
		List<String> res = addrService.findGugun(city);
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
	@GetMapping("/select/{city}/{gugun}")
	public ResponseEntity<List<String>> getDong(@PathVariable String city, @PathVariable String gugun) throws Exception{
		BaseAddr addr = new BaseAddr();
		addr.setCity(city);
		addr.setGugun(gugun);
		List<String> res = addrService.findDong(addr);
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
	// --------------------kakao map 구현----------------------
	
	@GetMapping("/location/{city}/{gugun}/{dong}")
	public ResponseEntity<BaseAddr> getDongPosition(@PathVariable String city, @PathVariable String gugun, @PathVariable String dong) throws Exception{
		BaseAddr addr = new BaseAddr();
		addr.setCity(city);
		addr.setGugun(gugun);
		addr.setDong(dong);
		BaseAddr res = mapService.getDongPosition(addr);
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
	@GetMapping("aptPosition/{city}/{gugun}/{dong}")
	public ResponseEntity<List<HouseDto>> getAptPosition(@PathVariable String city, @PathVariable String gugun, @PathVariable String dong) throws Exception{
		BaseAddr addr = new BaseAddr();
		addr.setCity(city);
		addr.setGugun(gugun);
		addr.setDong(dong);
		List<HouseDto> res = mapService.getAptPosition(addr);
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
}
