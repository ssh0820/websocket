package org.jbp.model2.controller;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.jbp.model2.service.ArticlesService;
import org.jbp.model2.vo.Article;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ArticleController {
	
	private ArticlesService service;
	
	public void setService(ArticlesService service) {
		this.service = service;
	}
	
	@RequestMapping(value="/article",
			method=RequestMethod.GET)
	public String asdfs() {
		return "ajaxIndex";
	}
	
	@RequestMapping(value="/article/write",
			method=RequestMethod.GET)
	public String articleWrite() {
		
		return "articleForm";
	}
	
	
	@RequestMapping(value="/article/{no}/update",
			method=RequestMethod.GET)
	public String articleUpdate(@PathVariable int no, Model model) {
		
		model.addAttribute("article", service.getOne(no));
		return "articleForm";
	}
	
	@RequestMapping(value="/article/{no}",
			method=RequestMethod.DELETE)
	public String delete(@PathVariable int no) {
		
		service.remove(no);
		
		return "redirect:/";
	}//
			
			
	
	@RequestMapping(value="/article/{no}",
			method=RequestMethod.GET)
	public String article(
			@PathVariable int no,HttpSession session,
			Model model) {
		
		boolean isHit = false;
		
		 Set<Integer> viewPages = (Set<Integer>)session.getAttribute("viewPages");
		 
		 if(viewPages==null) {
			 viewPages = new HashSet<Integer>();
			 session.setAttribute("viewPages", viewPages);
		 }//if end
		
		if(!viewPages.contains(no)) {
			isHit = true;
			viewPages.add(no);
		}//if end
		
		
		model.addAttribute("article",service.getDetail(no,isHit));
		
		
		return "article";
	}
	
	
	
	
	@RequestMapping(value={"/","/index"},
			method=RequestMethod.GET)
	public String sdfasdf() {
		
		return "index";
	}
	
	@RequestMapping(value="/index/size/{size}/page/{page}",
			method=RequestMethod.GET)
	public String asdfasdfsadf(Model model,
			@PathVariable int page, 
		@PathVariable int size) {
		
		model.addAllAttributes(service.getPageList(page, size));
		
		return "index";
	}
	
	@RequestMapping(value="/article",
			method=RequestMethod.POST)
	public String write(Article article) {
		
		service.write(article);
		
		return "redirect:/article/"+article.getNo();
	}
	
	@RequestMapping(value="/article",
			method=RequestMethod.PUT)
	public String update(Article article) {
		
		service.update(article);
		
		return "redirect:/article/"+article.getNo();
	}
	
	
	
}
