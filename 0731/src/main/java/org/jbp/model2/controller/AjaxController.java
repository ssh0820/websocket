package org.jbp.model2.controller;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.jbp.model2.service.ArticlesService;
import org.jbp.model2.service.RepliesService;
import org.jbp.model2.service.UsersService;
import org.jbp.model2.util.FileRenameUtil;
import org.jbp.model2.util.PaginateUtil;
import org.jbp.model2.util.ResizeImageUtil;
import org.jbp.model2.vo.Reply;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/ajax")
public class AjaxController {

	private ArticlesService articlesService;
	
	private RepliesService repliesService;
	
	private UsersService usersService;
	
	public void setUsersService(UsersService usersService) {
		this.usersService = usersService;
	}
	
	private ResizeImageUtil imageUtil;
	
	public void setImageUtil(ResizeImageUtil imageUtil) {
		this.imageUtil = imageUtil;
	}
	
	private FileRenameUtil fileRenameUtil;
	
	public void setFileRenameUtil(FileRenameUtil fileRenameUtil) {
		this.fileRenameUtil = fileRenameUtil;
	}
	
	public void setRepliesService(RepliesService repliesService) {
		this.repliesService = repliesService;
	}
	
	public void setArticlesService(ArticlesService articlesService) {
		this.articlesService = articlesService;
	}
	
	@RequestMapping(
			value="article/size/{size}/page/{page}",
			method=RequestMethod.GET)
	public Map<String, Object> adsfasdf(
			@PathVariable int size,
			@PathVariable int page) {
		
		return articlesService.getPageList(page, size);
	}
	
	@RequestMapping(value="article/{articleNo}/reply/page/{pageNo}",
			method=RequestMethod.GET)
	public Map<String, Object> asdfasf(@PathVariable int articleNo,
			@PathVariable int pageNo) {
		return repliesService.getReplies(articleNo,pageNo);
	}
	
	@RequestMapping(value="/reply/{no}",
			method=RequestMethod.DELETE)
	public boolean safasd(@PathVariable int no) {
		
		return repliesService.remove(no);
	}
	@RequestMapping(value="reply",
			method=RequestMethod.POST)
	public boolean sdfasdfasdf(Reply reply) {
		
		return repliesService.register(reply);
	}
	
	@RequestMapping(value="user/nickname/{nickname}",
			method=RequestMethod.GET)
	public boolean checkNickname(@PathVariable String nickname) {
		return usersService.checkNickname(nickname);
	}
	
	@RequestMapping(value="user/id/{id}",
			method=RequestMethod.GET)
	public boolean checkId(@PathVariable String id) {
		System.out.println(id);
		return usersService.checkId(id);
	}
	
	@RequestMapping(value="upload",
			method=RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	public String uploadImage(HttpServletRequest request,String type,
			MultipartFile uploadImg) {
		
		ServletContext sc = request.getServletContext();
		
		String uploadPath = sc.getRealPath("upload");
		String profilePath = sc.getRealPath("profile");
		
		System.out.println(uploadPath);
		
		System.out.println(uploadImg.getOriginalFilename());
		
		File file = new File(uploadPath+File.separator+uploadImg.getOriginalFilename()); 
		
		file = fileRenameUtil.rename(file);

		try {
			
			uploadImg.transferTo(file);
			
			switch(type) {
			case "P" : 
				   
				imageUtil.resize(file.getAbsolutePath(),profilePath+File.separator+file.getName(), 200);
				
				break;
			case "B" : 
				break;
			}//switch end
			
			return "{\"src\":\""+ file.getName()+"\"}";
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return "에러";
		} 
		
	}
	
}
