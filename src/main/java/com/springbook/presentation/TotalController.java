package com.springbook.presentation;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springbook.biz.total.TotalServiceImpl;
import com.springbook.biz.total.TotalVo;


@Controller
public class TotalController {
	@Autowired
	private TotalServiceImpl service;
	

	//users
	//회원목록으로 가기
	@RequestMapping("user_list.do")
	public String user_list(TotalVo vo, Model model) {
		model.addAttribute("li", service.users_select(vo));
				
		return "/user/list.jsp";
	}
		
	
	//회원가입 화면으로 이동
	@RequestMapping("user_join.do")
	public String user_join() {
		return "/user/join.jsp";
	}
	
	//아이디 중복 확인
	@RequestMapping("user_userCk.do")
	public void user_userCk(TotalVo vo, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter(); //출력
		
		String user = service.users_userCk(vo); //동일한 아이디 있는지 확인
		if(user.equals("F")) { //중복 아이디가 O
			out.println(1);  // out을 사용하여 값을 리턴함
			
		} else if(user.equals("T")){ //중복 아이디가 X
			out.println(0);
		}
	}
	
	//회원가입 성공하면 가기
	@RequestMapping("user_joinOk.do")
	public String user_joinOk(TotalVo vo, HttpServletResponse response, HttpSession session) {
		service.users_insert(vo);
		return "index.jsp";
		
	}
	
	
	//로그인 화면으로 이동
	@RequestMapping(value="/user_login.do", method=RequestMethod.GET)
	public String user_login() {			  
		return "/user/login.jsp";
	}
	
	//로그인 하기
	@RequestMapping("user_loginOk.do")
	public void user_loginOk(TotalVo vo, HttpServletResponse response, HttpSession session, HttpServletRequest request) throws Exception {
		PrintWriter out = response.getWriter(); //출력
		
		//세선받기
		session = request.getSession();
		
		//Dao에서 아이디랑 비밀번호 맞는지 체크
		String user = service.users_loginCk(vo);
		
		if(user.equals("F")) { //아이디랑 비밀번호가 틀리면
			out.println(1);
			
		} else { //아이디랑 비밀번호가 맞으면
			session.setAttribute("session", user);
			out.println(0);
		}
		 
	}

   //로그아웃하고 세션 삭제
   @RequestMapping("user_logout.do")
   public String user_logout(HttpSession sesion) {
	   //세션 종료
	   sesion.invalidate();  
	   
	   return "index.jsp";
	   
   }
   
   //회원정보 확인
   @RequestMapping("user_content.do")
   public String user_content(TotalVo vo, Model model) {
	   model.addAttribute("content", service.users_content(vo));
	   
	   return "/user/content.jsp";
   }
   
   //회원정보 수정
   @RequestMapping("user_update.do")
   public String user_Update(TotalVo vo) {
	   service.users_update(vo);
	   
	return "index.jsp";
	   
   }
   
   //회원탈퇴
   @RequestMapping("user_delete.do")
   public String user_delete(TotalVo vo, HttpSession sesion) {
	   
	   service.users_delete(vo);
	   sesion.invalidate();
	   
	   return "index.jsp";
   }
   
   
   
   
   //board
 //게시물 목록보기
 	@RequestMapping("board_list.do")
 	public String board_select(TotalVo vo, Model model) {
 		//표에 대한 정보 변수 정의
		int pageSize = 12; //페이지 크기
		int pageListSize = 10; //페이지 리스트 크기
		
		if(vo.getStartIdx() == 0) {
			vo.setStartIdx(1);			
		} else {
			vo.setStartIdx(vo.getStartIdx());
		}
		
		vo.setEndIdx(vo.getStartIdx() + pageSize - 1);
 		
		model.addAttribute("startIdx", vo.getStartIdx());
		model.addAttribute("li", service.board_select(vo));
		
		
 		//페이지 나누기
 		TotalVo board_page = service.board_count(vo); //전체 레코드 수
 		int nowPage = (vo.getStartIdx()/12+1); //현재 페이지
 		int totalPage = (int)Math.ceil(board_page.getTc()/12.0);//전체 페이지 수		
 		int endPage = ((totalPage-1)*12)+1; //마지막 페이지의 시작 레코드
 				
 		//페이지 나누기 보내기
 		model.addAttribute("totalPage", totalPage); //전체 페이지 수
		model.addAttribute("nowPage", nowPage); //현재 페이지
 		model.addAttribute("endPage", endPage); //마지막 페이지
 		
		int listStartPage = (nowPage-1) / pageListSize*pageListSize + 1; //하단 가로 시작
		int listEndPage = listStartPage + pageListSize - 1; //하단 가로 마지막
 				
		//표에 대한 정보
		model.addAttribute("pageSize", pageSize); //페이지 크기
		model.addAttribute("pageListSize", pageListSize); //페이지 리스트 크기
		model.addAttribute("listStartPage", listStartPage); //하단 가로 시작
		model.addAttribute("listEndPage", listEndPage); //하단 가로 마지막
		
 		
 		return "/board/list.jsp";		
 	}
 	
 	//게시물 작성하는 페이지로 이동
 	@RequestMapping("board_write.do")
 	public String board_writer() {	
 		return "/board/writer.jsp";		
 	}
 	
 	//게시물 작성하기
 	@RequestMapping("board_writeOk.do") //값 저장하고 목록.jsp로 이동
 	public String board_insert(TotalVo vo, HttpServletRequest request) throws Exception {
 		//path 설정
 		String path = request.getSession().getServletContext().getRealPath("/board/files/");
 		System.out.println(path);
 		//이미지 가져오기
 		MultipartFile imgUpdateFile = vo.getImgUploadFile();
 		String fileNmae = imgUpdateFile.getOriginalFilename();
 		File f = new File(path+fileNmae);
 		
 		//이미지 파일명 자르기
 		String onlyFilename = "";
 		String extension = "";
 		
 		//현재 시간 가져오기
 		long time = System.currentTimeMillis();
 		SimpleDateFormat dayTime = new SimpleDateFormat("HHmmss"); //시분초
 		String timeStr = dayTime.format(time);

 		Date now = new Date();
 		
 		if(!imgUpdateFile.isEmpty()) {
 			if(f.exists()) {
 				// 중복 파일이 존재하면
 				onlyFilename = fileNmae.substring(0, fileNmae.indexOf(".")); //처음부터 .바로 앞까지
 				extension = fileNmae.substring(fileNmae.indexOf(".")); //.부터 끝까지
 				fileNmae = onlyFilename + "_" + timeStr + extension ; //파일이름_시분초.확장자
 			  
 				imgUpdateFile.transferTo(new File(path+fileNmae));
 			} else {
 				// 중복 파일이 존재하지 않으면   
 				imgUpdateFile.transferTo(new File(path+fileNmae));
 			}
 		}
 		//입력 전 새로운 값 받아주기
 		vo.setImg(fileNmae);
 		vo.setRdate(now);
 		 		
 		service.board_insert(vo);
 		
 		return "board_list.do";		
 	}
 	
 	//게시물 자세히보기
 	@RequestMapping("board_content.do") 
 	public String board_content(TotalVo vo, Model model, HttpSession session, HttpServletRequest request) {
 		model.addAttribute("m", service.board_content(vo)); //테이블 상세정보 가져오기
 		model.addAttribute("c", service.comments_content(vo)); //테이블이랑 댓글 조인한 거 가져와서 댓글보기

		session = request.getSession(); //게시물 세션 생성
		session.setAttribute("board_idx", vo.getIdx()); //idx 세선 유지
		
		return "/board/content.jsp";
 	}
 	
 	//게시물 수정하기
 	@RequestMapping("board_update.do")
 	public String board_update(TotalVo vo, Model model) {
 		model.addAttribute("m", service.board_content(vo));
 		
 		return "/board/update.jsp";
 	}
 	
 	//값 받아서 수정 후 목록.do로 이동
 	@RequestMapping("board_updateOk.do") 
 	public String board_updateOk(TotalVo vo, HttpServletRequest request) throws Exception {
 		//path 설정
 		String	path=request.getSession().getServletContext().getRealPath("/board/files/");
 		
 		//이미지 가져오기
 		MultipartFile imgUpdateFile = vo.getImgUploadFile();
 		String fileNmae = imgUpdateFile.getOriginalFilename();
 		File  f = new File(path+fileNmae);

 		//현재 시간 가져오기
 		long time = System.currentTimeMillis();
 		SimpleDateFormat dayTime = new SimpleDateFormat("HHmmss"); //시분초
 		String timeStr = dayTime.format(time);
 		
 		Date now = new Date();
 				
 		if(!imgUpdateFile.isEmpty()) {//이미지가 있으면
 			//기존 파일 삭제
 			TotalVo img = service.board_content(vo); //가져올 이미지 파일 설정
 			File fDel = new File(path+img.getImg()); //파일 경로 찾기
 			
 			if(fDel.exists()) { //5. 파일이 존재하면 삭제
 				fDel.delete();
 			}
 			
 			if(f.exists()) {
 				// 중복 파일이 존재하면
 				String onlyFilename = fileNmae.substring(0, fileNmae.indexOf(".")); //처음부터 .바로 앞까지
 				String extension = fileNmae.substring(fileNmae.indexOf(".")); //.부터 끝까지
 				fileNmae = onlyFilename + "_" + timeStr + extension ; //파일이름_시분초.확장자
 			  
 				imgUpdateFile.transferTo(new File(path+fileNmae));
 				
 			} else {
 				// 중복 파일이 존재하지 않으면   
 				imgUpdateFile.transferTo(new File(path+fileNmae));
 				System.out.println("fileNmae:" + fileNmae);
 			}
 			
 			//입력 전 새로운 값 받아주기
 			vo.setImg(fileNmae); //String
 			vo.setUdate(now);
 			
 			service.board_updateFile(vo);
 			System.out.println("이미지 OK 수정하기"+vo.toString());
 			
 		} else { //이미지가 없으면
 			vo.setUdate(now);
 			
 			service.board_update(vo);
 			System.out.println("이미지 None 수정하기"+vo.toString());
 			
 		}
 				
 		
 		return "board_list.do";		
 	}
 	
 	@RequestMapping("board_delete.do") //두개의 값 받아서 목록.do로 이동
 	public String board_delete(TotalVo vo, HttpServletRequest request) {
 		//파일삭제
 		TotalVo img = service.board_content(vo); //1. 가져올 이미지 파일 설정
 		img.getImg(); //2. 이미지 파일 가져오기
 		String	path = request.getSession().getServletContext().getRealPath("/board/files/"); //3.패스 설정
 		File f = new File(path+img.getImg()); //4. 파일 경로 찾기
 		
 		if(f.exists()) { //5. 파일이 존재하면 삭제
 			f.delete();
 		}
 		
 		//댓글 삭제
 		service.comments_delete_idx(vo);
 		
 		//레코드삭제
 		service.board_delete(vo);
 		
 		return "board_list.do";		
 	}
 	
 	
 	
 	//comments
 	//댓글달기
	@RequestMapping("comments_insert.do")
	public String comments_insert(TotalVo vo, RedirectAttributes rttr) {
		service.comments_insert(vo);	
		
		return "board_content.do";
	}
	
	//댓글 수정으로 이동
	@RequestMapping(value="comments_updateView.do", method=RequestMethod.GET)
	public String comments_updateView(TotalVo vo, Model model) {
		
		model.addAttribute("comments_update", service.comments_select(vo.getNum()));
		
		return "/comments/updateView.jsp";	
	}
	
	//댓글 수정
	@RequestMapping(value="comments_update.do", method=RequestMethod.POST)
	public String comments_update(TotalVo vo) {
		service.comments_update(vo);
		
		return "board_content.do";
		
	}
	
	//댓글삭제
	@RequestMapping(value="comments_delete.do")
	public String comments_delete(TotalVo vo) {		
		service.comments_delete(vo);
		
		return "board_content.do";
	}
}
