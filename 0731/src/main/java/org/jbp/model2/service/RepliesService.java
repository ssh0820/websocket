package org.jbp.model2.service;

import java.util.Map;

import org.jbp.model2.vo.Reply;

public interface RepliesService {

	public Map<String, Object> getReplies(int articleNo, int pageNo);

	public boolean remove(int no);
	
	public boolean register(Reply reply);

}
