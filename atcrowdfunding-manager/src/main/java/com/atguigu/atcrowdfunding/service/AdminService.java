package com.atguigu.atcrowdfunding.service;

import javax.security.auth.login.LoginException;

import com.atguigu.atcrowdfunding.bean.TAdmin;

public interface AdminService {

	TAdmin getAdminByLogin(String loginacct, String userpswd) throws LoginException ;

}
