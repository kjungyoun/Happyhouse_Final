package com.ssafy.happyhouse.model;

public class BaseAddr {
	private String city;
	private String gugun;
	private String dong;
	private int dongcode;
	private double lat, lng;
	
	
	
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public int getDongcode() {
		return dongcode;
	}
	public void setDongcode(int dongcode) {
		this.dongcode = dongcode;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	
	public BaseAddr(String city, String gugun, String dong, int dongcode, double lat, double lng) {
		super();
		this.city = city;
		this.gugun = gugun;
		this.dong = dong;
		this.dongcode = dongcode;
		this.lat = lat;
		this.lng = lng;
	}
	public  BaseAddr() {}
	
	
}
