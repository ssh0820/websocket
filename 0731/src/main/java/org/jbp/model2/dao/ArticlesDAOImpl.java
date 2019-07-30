package org.jbp.model2.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.jbp.model2.vo.Article;
import org.jbp.model2.vo.PageVO;
import org.springframework.stereotype.Repository;

@Repository
public class ArticlesDAOImpl implements ArticlesDAO{
	
	private SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public List<Article> selectPageList(PageVO pageVO) {
		return session.selectList("articles.selectPageList",pageVO);
	}
	
	@Override
	public int selectTotal() {
		return session.selectOne("articles.selectTotal");
	}
	
	@Override
	public int insert(Article article) {
		return session.insert("articles.insert",article);
	}
	
	@Override
	public Article selectOne(int no) {
		return session.selectOne("articles.selectOne",no);
	}
	
	@Override
	public int updateReplies(int no) {
		return session.update("articles.updateReplies" ,no);
	}
	
	@Override
	public int updateHit(int no) {
		return session.update("articles.updateHit" ,no);
	}
	
	@Override
	public int delete(int no) {
		return session.delete("articles.delete",no);
	}
	
	@Override
	public int update(Article article) {
		return session.update("articles.update",article);
	}
}



