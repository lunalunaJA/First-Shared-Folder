package com.springbook.biz.total;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TotalVo {
	
	//users
	private String id; //pk
	private String pwd;
	private String name;
	private String tel;
	private String email;
	private String postcode;
	private String address;
	private String detailAddress;
	private String extraAddress;

	
	//board
	private int idx; 
	//private String id; //작성자
	private Date rdate; //작성일
	private Date udate; //수정일
	private String sname; //가게이름
	private String phone; //가게번호
	private String mmenu; //메인상품
	private String open; //오픈시간
	private String off; //휴일
	private String instar; //인스타 주소
	//private String postcode;
	//private String address;
	//private String detailAddress;
	//private String extraAddress;
	private String b_id;
	
	private MultipartFile imgUploadFile; //실제 이미지 파일
	private String img; // 테이블 이미지 이름
	
	//private String ch1;
	//private String ch2;
	
	
	//comments
	private int num; //댓글번호
	//private int idx; //게시글 번호 받아오기
	//private String id; //작성자
	//private int seq; //부모-자식 구분
	private String detail; //댓글 내용
	private int c_idx;
	private String c_id;
		
	
	//검색하기
	private String ch1;
	private String ch2;
	
	
	//페이지 나누기
	private int startIdx; //시작 값
	private int endIdx; //마지막 값
	private int rownum;
	private int rnum;
	private int pageSize;
		
	private int tc; //전체 레코드 수
}

/*
create table users(
id varchar2(20) not null primary key,
pwd varchar2(100) not null,
name nvarchar2(10) not null,
tel varchar2(15) not null,
email varchar2(20) not null,
postcode char(5),
address nvarchar2(100),
detailAddress nvarchar2(100),
extraAddress nvarchar2(100)
);


create table board(
idx number(5) not null  primary key,
sname nvarchar2(20) not null,
id varchar2(10) not null,
rdate date not null,
udate date,
phone varchar(15) not null,
mmenu nvarchar2(30),
open varchar2(20),
off nvarchar2(20),
instar varchar2(30),
postcode char(5),
address nvarchar2(100),
detailAddress nvarchar2(100),
extraAddress nvarchar2(100),
img  NVARCHAR2(30)
);

alter table board add constraint board_id  foreign key(id) references users(id);

create sequence board_idx
increment by 1
start with 1;


create table comments(
num number(5) not null primary key,
idx number(5) not null,
id varchar2(10) not null,
detail nvarchar2(100) not null
);

alter table comments add constraint comments_idx  foreign key(idx) references board(idx);

create sequence comments_num
increment by 1
start with 10001;
*/
