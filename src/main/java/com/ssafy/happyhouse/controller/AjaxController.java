package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.BaseAddr;
import com.ssafy.happyhouse.model.service.AddressService;

@RestController
@CrossOrigin("*")
@RequestMapping("/option")
public class AjaxController {
	
	@Autowired
	private AddressService addrService;
	
	@GetMapping("/city")
	public ResponseEntity<List<String>> getCity() throws Exception{
		List<String> res = addrService.findCity();
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
	@GetMapping("/gugun/{city}")
	public ResponseEntity<List<String>> getGugun(@PathVariable String city) throws Exception{
		List<String> res = addrService.findGugun(city);
		return new ResponseEntity(res, HttpStatus.OK);
	}
	
	@GetMapping("/dong/{city}/{gugun}")
	public ResponseEntity<List<String>> getDong(@PathVariable String city, @PathVariable String gugun) throws Exception{
		BaseAddr addr = new BaseAddr();
		addr.setCity(city);
		addr.setGugun(gugun);
		List<String> res = addrService.findDong(addr);
		return new ResponseEntity(res, HttpStatus.OK);
	}
}
