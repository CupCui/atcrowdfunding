package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import javax.security.auth.login.LoginException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	TAdminMapper adminMapper;

	@Override
	public TAdmin getAdminByLogin(String loginacct, String userpswd) throws LoginException {
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(loginacct);
		
		List<TAdmin> list = adminMapper.selectByExample(example);
		
		if(list==null || list.size()==0) {
			throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
		}
		
		TAdmin admin = list.get(0);
		
		if(!admin.getUserpswd().equals(MD5Util.digest(userpswd))) {
			throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
		}
		
		return admin;
	}
	
}
