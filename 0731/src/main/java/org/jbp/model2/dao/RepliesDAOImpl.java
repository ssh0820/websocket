package org.jbp.model2.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.jbp.model2.vo.PageVO;
import org.jbp.model2.vo.Reply;
import org.springframework.stereotype.Repository;

@Repository
public class RepliesDAOImpl implements RepliesDAO {

	private SqlSession session;
	
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	@Override
	public List<Reply> selectList(PageVO pageVO) {
		return session.selectList("replies.selectList",pageVO);
	}
	
	@Override
	public int selectTotal(int articleNo) {
		return session.selectOne("replies.selectTotal",articleNo);
	}
	
	@Override
	public int delete(int no) {
		return session.delete("replies.delete",no);
	}
	
	@Override
	public int insert(Reply reply) {
		return session.insert("replies.insert",reply);
	}
	@Override
	public int deleteAll(int articleNo) {
		return session.delete("replies.deleteAll",articleNo);
	}
}
