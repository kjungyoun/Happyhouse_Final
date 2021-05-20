package com.ssafy.happyhouse.model;

import java.util.Date;

public class QnaDto {
	private int no;
	private String userid,title,contents,repl;
	private Date regdate;
	
	private String loginId;
	
	
	public QnaDto(int no, String userid, String title, String contents, String repl, Date regdate) {
		super();
		this.no = no;
		this.userid = userid;
		this.title = title;
		this.contents = contents;
		this.repl = repl;
		this.regdate = regdate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
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

	public String getRepl() {
		return repl;
	}

	public void setRepl(String repl) {
		this.repl = repl;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	@Override
	public String toString() {
		return "QnaDto [no=" + no + ", userid=" + userid + ", title=" + title + ", contents=" + contents + ", repl="
				+ repl + ", regdate=" + regdate + ", loginId=" + loginId + "]";
	}
	
	
	
}
