package com.springbook.biz.total;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TotalServiceImpl implements TotalService {

	@Autowired
	private TotalDao dao;

	@Override
	public void users_insert(TotalVo vo) {
		dao.users_insert(vo);
	}

	@Override
	public List<TotalVo> users_select(TotalVo vo) {
		return dao.users_select(vo);
	}

	@Override
	public void users_update(TotalVo vo) {
		dao.users_update(vo);
	}

	@Override
	public void users_delete(TotalVo vo) {
		dao.users_delete(vo);
	}

	@Override
	public TotalVo users_content(TotalVo vo) {
		return dao.users_content(vo);
	}

	@Override
	public String users_loginCk(TotalVo vo) {
		return dao.users_loginCk(vo);
	}

	@Override
	public String users_userCk(TotalVo vo) {
		return dao.users_userCk(vo);
	}

	@Override
	public void board_insert(TotalVo vo) {
		dao.board_insert(vo);
	}

	@Override
	public TotalVo board_count(TotalVo vo) {
		return dao.board_count(vo);
	}
	@Override
	public List<TotalVo> board_select(TotalVo vo) {
		return dao.board_select(vo);
	}

	@Override
	public void board_delete(TotalVo vo) {
		dao.board_delete(vo);
	}

	@Override
	public TotalVo board_content(TotalVo vo) {
		return dao.board_content(vo);
	}

	@Override
	public void board_update(TotalVo vo) {
		dao.board_update(vo);
	}

	@Override
	public void board_updateFile(TotalVo vo) {
		dao.board_updateFile(vo);
	}

	@Override
	public void comments_insert(TotalVo vo) {
		dao.comments_insert(vo);
	}

	@Override
	public List<TotalVo> comments_content(TotalVo vo) {
		return dao.comments_content(vo);
	}

	@Override
	public TotalVo comments_select(int num) {
		return dao.comments_select(num);
	}

	@Override
	public int comments_count() {
		return dao.comments_count();
	}
	
	@Override
	public void comments_delete_idx(TotalVo vo) {
		dao.comments_delete_idx(vo);
	}
	
	@Override
	public void comments_delete(TotalVo vo) {
		dao.comments_delete(vo);
	}

	@Override
	public void comments_update(TotalVo vo) {
		dao.comments_update(vo);
	}


}
