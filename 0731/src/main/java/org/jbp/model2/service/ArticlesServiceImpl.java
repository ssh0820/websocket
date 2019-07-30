package org.jbp.model2.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.jbp.model2.dao.ArticlesDAO;
import org.jbp.model2.dao.RepliesDAO;
import org.jbp.model2.util.PaginateUtil;
import org.jbp.model2.vo.Article;
import org.jbp.model2.vo.PageVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ArticlesServiceImpl 
implements ArticlesService {
	
	private ArticlesDAO articlesDAO;
	private RepliesDAO repliesDAO;
	
	public void setRepliesDAO(RepliesDAO repliesDAO) {
		this.repliesDAO = repliesDAO;
	}
	
	public void setArticlesDAO(ArticlesDAO articlesDAO) {
		this.articlesDAO = articlesDAO;
	}
	
	private PaginateUtil paginateUtil;
	
	public void setPaginateUtil(PaginateUtil paginateUtil) {
		this.paginateUtil = paginateUtil;
	}
	
	@Override
	public Map<String, Object> getPageList(int page, int numPage) {
		Map<String, Object> map = 
				new ConcurrentHashMap<String, Object>();
		
		PageVO pageVO = new PageVO(page,numPage); 
		
		map.put("articles",
				articlesDAO.selectPageList(pageVO));
		
		int total = articlesDAO.selectTotal(); 
		
		map.put("paginate", paginateUtil.getPaginate(page, total, numPage, 5, "/index/size/"+numPage));
		
		return map;
	}
	
	@Override
	public int write(Article article) {
		return articlesDAO.insert(article);
	}
	
	@Override
	public Article getDetail(int no, boolean isHit) {
		
		if(isHit) {
			articlesDAO.updateHit(no);
		}//if end
		
		return articlesDAO.selectOne(no);
	}
	
	@Override
	@Transactional
	public void remove(int no) {
		
		repliesDAO.deleteAll(no);
		
		articlesDAO.delete(no);
		
	}
	
	@Override
	public Article getOne(int no) {
		return articlesDAO.selectOne(no);
	}
	
	@Override
	public void update(Article article) {
		articlesDAO.update(article);
	}

}
