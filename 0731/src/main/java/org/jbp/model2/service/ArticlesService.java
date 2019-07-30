package org.jbp.model2.service;

import java.util.Map;

import org.jbp.model2.vo.Article;

public interface ArticlesService {
	
	public Map<String, Object> getPageList(int page, int numPage);
	public int write(Article article);
	public Article getDetail(int no, boolean isHit);
	public void remove(int no);
	public Article getOne(int no);
	public void update(Article article);

}
