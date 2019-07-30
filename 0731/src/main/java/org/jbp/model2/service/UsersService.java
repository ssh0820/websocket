package org.jbp.model2.service;

import org.jbp.model2.vo.User;

public interface UsersService {
	
	public User login(User user);

	public boolean checkNickname(String nickname);

	public boolean checkId(String id);

	public void join(User user);

}
