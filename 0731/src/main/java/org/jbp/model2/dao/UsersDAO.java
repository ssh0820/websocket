package org.jbp.model2.dao;

import org.jbp.model2.vo.User;

public interface UsersDAO {
	
	public User selectLogin(User user);
	
	public int insert(User user);

	public int selectCheckId(String id);

	public int selectCheckNickname(String nickname);

}
