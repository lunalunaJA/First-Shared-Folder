package com.springbook.biz.total;

import java.util.List;

public interface TotalService {
	
	//users
	void users_insert(TotalVo vo); //회원가입
	List<TotalVo> users_select(TotalVo vo); //회원목록
	void users_update(TotalVo vo); //회원 정보 수정
	void users_delete(TotalVo vo); //회원탈퇴	
	TotalVo users_content(TotalVo vo); //회원 정보 확인	
	String users_loginCk(TotalVo vo); //로그인 확인
	String users_userCk(TotalVo vo); //아이디 중복 확인
	
	//board
	void board_insert(TotalVo vo); //게시글 작성
	TotalVo board_count(TotalVo vo); //게시물 수
	List<TotalVo> board_select(TotalVo vo); //게시판 목록보기
	void board_delete(TotalVo vo); //게시글 삭제
	TotalVo board_content(TotalVo vo); //게시글 수정
	void board_update(TotalVo vo); //이미지 수정X
	void board_updateFile(TotalVo vo); //이미지 수정O
	
	//comments
	void comments_insert(TotalVo vo); //댓글작성
	List<TotalVo> comments_content(TotalVo vo); //게시글에 맞는 댓글목록
	TotalVo comments_select(int num); //선택된 댓글 보기
	int comments_count(); //게시글 별 댓글 갯수 보기
	
	void comments_delete_idx(TotalVo vo); //게시글 삭제될 때 댓글 삭제	
	void comments_delete(TotalVo vo); //댓글 삭제
	void comments_update(TotalVo vo); //댓글 수정
	
}