package com.ssafy.happyhouse.model;

public class SubwayDto {
	private String line;
	private String name;
	private int code;
	private Double lat;
	private Double lng;
	
	public SubwayDto() {}
	
	public SubwayDto(String line, String name, int code, Double lat, Double lng) {
		super();
		this.line = line;
		this.name = name;
		this.code = code;
		this.lat = lat;
		this.lng = lng;
	}

	@Override
	public String toString() {
		return "SubwayDto [line=" + line + ", name=" + name + ", code=" + code + ", lat=" + lat + ", lng=" + lng + "]";
	}

	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLng() {
		return lng;
	}
	public void setLng(Double lng) {
		this.lng = lng;
	}
	
	
	
}
