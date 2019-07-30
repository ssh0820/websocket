package org.jbp.model2.service;

import org.jbp.model2.dao.UsersDAO;
import org.jbp.model2.vo.User;
import org.springframework.stereotype.Service;

@Service
public class UsersServiceImpl implements
UsersService{
	
	private UsersDAO usersDAO;
	
	public void setUsersDAO(UsersDAO usersDAO) {
		this.usersDAO = usersDAO;
	}
	
	@Override
	public User login(User user) {
		return usersDAO.selectLogin(user);
	}
	
	@Override
	public boolean checkId(String id) {
		
		int result = usersDAO.selectCheckId(id);
		
		System.out.println(result);
		
		return 0==result;
	}
	
	@Override
	public boolean checkNickname(String nickname) {
		// TODO Auto-generated method stub
		return 0==usersDAO.selectCheckNickname(nickname);
	}
	
	@Override
	public void join(User user) {
		usersDAO.insert(user);
	}

}
