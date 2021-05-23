package com.ssafy.happyhouse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.service.HouseService;

@Controller
@RequestMapping("/house")
public class HouseController {
	
	@Autowired
	private HouseService houseService;
	
	
	@GetMapping("/search")
	public String mvsearch(PageBean bean, Model model)throws Exception {
		model.addAttribute("list", houseService.searchHouse(bean));
		model.addAttribute("bean", bean);
		return "houseinfo";
	}
	
	@GetMapping("/search/{code}/{dong}/{aptName}")
	public String mvsearch(@PathVariable int code, @PathVariable String dong, @PathVariable String aptName, Model model)throws Exception {
		PageBean bean = new PageBean();
		bean.setCode(code);
		bean.setDong(dong);
		bean.setAptName(aptName);
		model.addAttribute("list", houseService.searchDetail(bean));
		model.addAttribute("bean", bean);
		return "houseinfo";
	}
	
	
}
