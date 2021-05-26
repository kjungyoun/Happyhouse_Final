package com.ssafy.happyhouse.model;

import java.util.Date;

public class NoticeDto {
	private int no;
	private String title;
	private String contents;
	private String regdate;
	private int viewCnt;
	
	public NoticeDto() {}
	
	@Override
	public String toString() {
		return "NoticeDto [no=" + no + ", title=" + title + ", contents=" + contents + ", regdate=" + regdate
				+ ", viewCnt=" + viewCnt + "]";
	}


	public NoticeDto(int no, String title, String contents, String regdate, int viewCnt) {
		super();
		this.no = no;
		this.title = title;
		this.contents = contents;
		this.regdate = regdate;
		this.viewCnt = viewCnt;
	}





	public int getViewCnt() {
		return viewCnt;
	}



	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}



	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
