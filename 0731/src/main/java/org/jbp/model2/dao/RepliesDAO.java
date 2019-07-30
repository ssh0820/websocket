package org.jbp.model2.dao;

import java.util.List;

import org.jbp.model2.vo.PageVO;
import org.jbp.model2.vo.Reply;

public interface RepliesDAO {

	public List<Reply> selectList(PageVO pageVO);

	public int selectTotal(int articleNo);

	public int delete(int no);
	
	public int insert(Reply reply);

	public int deleteAll(int articleNo);

}
