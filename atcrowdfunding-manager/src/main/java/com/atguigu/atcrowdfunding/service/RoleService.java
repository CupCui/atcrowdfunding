package com.atguigu.atcrowdfunding.service;

import java.util.Map;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

public interface RoleService {

	PageInfo<TRole> listPage(Map<String, Object> paramMap);

	void saveRole(TRole role);

	TRole getRoleById(Integer id);

	void updateRole(TRole role);

	void deleteRole(Integer id);

}
