package com.springbook.biz.total;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.springbook.biz.BCrypt;

@Repository
public class TotalDaoImpl implements TotalDao {

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public void users_insert(TotalVo vo) {
		//암호화로 바꾼 비밀번호 입력
		vo.setPwd(BCrypt.hashpw(vo.getPwd(),BCrypt.gensalt()));
		
		mybatis.insert("Total.user_Insert", vo);
	}

	@Override
	public List<TotalVo> users_select(TotalVo vo) {
		return mybatis.selectList("Total.user_Select", vo);
	}

	@Override
	public void users_update(TotalVo vo) {
		mybatis.update("Total.user_Update", vo);
	}

	@Override
	public void users_delete(TotalVo vo) {
		mybatis.delete("Total.user_Delete", vo);
	}

	@Override
	public TotalVo users_content(TotalVo vo) {
		return mybatis.selectOne("Total.user_Content", vo);
	}

	@Override
	public String users_loginCk(TotalVo vo) {
		String str = "";
		
		//중복된 아이디 확인하기
		TotalVo idCk = mybatis.selectOne("Total.user_UserCk", vo);
		if(idCk == null) {
			str = "F"; //로그인 실패
			
		} else {
			//입력된 비밀번호 암호화로 변경해서 비교하기
			TotalVo user = mybatis.selectOne("Total.user_LoginCk", idCk);
			
			if(BCrypt.checkpw(vo.getPwd(), user.getPwd())) { //암호화된 비밀번호 확인
				str = vo.getId(); //로그인 성공
			} else {
				str = "F"; //로그인 실패
			}
			return str;
		}
		
		return str;
	}

	//아이디 중복값 찾아서 회원가입
	@Override
	public String users_userCk(TotalVo vo) {
		TotalVo user = mybatis.selectOne("Total.user_UserCk", vo);
		
		String str = "";
		if(user == null) {
			str = "T"; //중복값 없음
		} else {
			str = "F"; //중복값 있음
		}
		
		return str;
	}


	
	
	
	
	@Override
	public void board_insert(TotalVo vo) {
		mybatis.insert("Total.board_Insert", vo);		
	}

	@Override
	public TotalVo board_count(TotalVo vo) {
		return mybatis.selectOne("Total.board_Count", vo);
	}
	@Override
	public List<TotalVo> board_select(TotalVo vo) {
		return mybatis.selectList("Total.board_Select",vo);
	}

	@Override
	public void board_delete(TotalVo vo) {
		mybatis.delete("Total.board_Delete", vo);
	}

	@Override
	public TotalVo board_content(TotalVo vo) {
		return mybatis.selectOne("Total.board_Content", vo);
	}

	//NO 이미지 업데이트
	@Override
	public void board_update(TotalVo vo) {
		mybatis.update("Total.board_Update", vo);
	}

	//이미지 업데이트
	@Override
	public void board_updateFile(TotalVo vo) {
		mybatis.update("Total.board_UpdateFile", vo);
		
	}

	
	
	
	
	@Override
	public void comments_insert(TotalVo vo) {
		mybatis.insert("Total.comments_Insert", vo);
	}

	@Override
	public List<TotalVo> comments_content(TotalVo vo) {
		return mybatis.selectList("Total.comments_Content", vo);
	}
	
	@Override
	public TotalVo comments_select(int num) {
		return mybatis.selectOne("Total.comments_Select", num);
	}
	
	@Override
	public int comments_count() {
		return mybatis.selectOne("Total.comments_Count");
	}
	
	@Override
	public void comments_delete_idx(TotalVo vo) {
		mybatis.delete("Total.comments_Delete_Idx", vo);
	}	
	
	@Override
	public void comments_delete(TotalVo vo) {
		mybatis.delete("Total.comments_Delete", vo);
	}

	@Override
	public void comments_update(TotalVo vo) {
		mybatis.update("Total.comments_Update", vo);
	}



}
