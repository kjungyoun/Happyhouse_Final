package com.ssafy.happyhouse.model;

public class BusDto {
	private long id;
	private String name;
	private int code;
	private Double lat;
	private Double lng;
	
	public BusDto() {}
	
	public BusDto(long id, String name, int code, Double lat, Double lng) {
		super();
		this.id = id;
		this.name = name;
		this.code = code;
		this.lat = lat;
		this.lng = lng;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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

	@Override
	public String toString() {
		return "BusDto [id=" + id + ", name=" + name + ", code=" + code + ", lat=" + lat + ", lng=" + lng + "]";
	}
	
	
	
}
