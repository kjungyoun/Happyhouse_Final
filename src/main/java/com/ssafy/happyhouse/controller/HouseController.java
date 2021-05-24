package com.ssafy.happyhouse.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.happyhouse.model.HouseDto;
import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.service.HouseService;

@Controller
@RequestMapping("/house")
public class HouseController {
	
	@Autowired
	private HouseService houseService;
	
	
	@GetMapping("/search")
	public String mvsearch(PageBean bean, Double lat, Double lng, Model model)throws Exception {
		System.out.println(bean);
		List<HouseDto> list = houseService.searchHouse(bean);
		model.addAttribute("list", list);
		model.addAttribute("bean", bean);
		System.out.println(list);
		HouseDto position = new HouseDto();
		position.setLat(lat);
		position.setLng(lng);
		model.addAttribute("position", position);
		return "houseinfo";
	}
	
	@GetMapping("/search/{code}/{dong}/{aptName}/{lat}/{lng}")
	public String search(@PathVariable int code, @PathVariable String dong, @PathVariable String aptName,@PathVariable Double lat, @PathVariable Double lng, Model model)throws Exception {
		PageBean bean = new PageBean();
		bean.setCode(code);
		bean.setDong(dong);
		bean.setAptName(aptName);
		System.out.println(bean);
		model.addAttribute("list", houseService.searchDetail(bean));
		model.addAttribute("bean", bean);
		HouseDto position = new HouseDto();
		position.setLat(lat);
		position.setLng(lng);
		model.addAttribute("position", position);
		return "houseinfo";
	}
}
