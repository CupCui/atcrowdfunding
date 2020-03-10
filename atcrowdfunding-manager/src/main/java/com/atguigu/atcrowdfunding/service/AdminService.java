package com.atguigu.atcrowdfunding.service;

import java.util.Map;

import javax.security.auth.login.LoginException;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

public interface AdminService {

	TAdmin getAdminByLogin(String loginacct, String userpswd) throws LoginException ;

	PageInfo<TAdmin> listAllAdmin(Map<String, Object> paramMap);

	void saveAdmin(TAdmin admin);

	TAdmin getAdminById(Integer id);

	void updateAdmin(TAdmin admin);

	void deleteAdmin(Integer id);

	void deleteBatchAdmin(String ids);

}
