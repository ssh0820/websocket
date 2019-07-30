package org.jbp.model2.dao;

import java.util.List;

import org.jbp.model2.vo.Article;
import org.jbp.model2.vo.PageVO;

public interface ArticlesDAO {
	
	public List<Article> selectPageList(PageVO pageVO);
	public int selectTotal();
	public int insert(Article article);
	public Article selectOne(int no);
	public int updateReplies(int no);
	public int updateHit(int no);
	public int delete(int no);
	public int update(Article article);

}
