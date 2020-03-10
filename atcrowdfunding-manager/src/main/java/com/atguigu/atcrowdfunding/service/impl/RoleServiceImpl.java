package com.atguigu.atcrowdfunding.service.impl;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageInfo;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	TRoleMapper roleMapper;

	@Override
	public PageInfo<TRole> listPage(Map<String, Object> paramMap) {
		TRoleExample example = new TRoleExample(); //用于生成查询条件
		
		String condition = (String)paramMap.get("condition");
		
		//是根据查询条件获取分页数据，还是查询所有进行分页
		if(!StringUtils.isEmpty(condition)) {
			example.createCriteria().andNameLike("%"+condition+"%");			
		}

		// CRUD   insert   select  update  delete
		List<TRole> list = roleMapper.selectByExample(example) ; //一页数据
		
		int navgpages = 5 ; //导航页，默认值8
		
		PageInfo<TRole> page = new PageInfo<TRole>(list,navgpages);
		
		
		return page;
	}

	@Override
	public void saveRole(TRole role) {
		roleMapper.insertSelective(role);
	}

	@Override
	public TRole getRoleById(Integer id) {
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateRole(TRole role) {
		roleMapper.updateByPrimaryKeySelective(role);
	}

	@Override
	public void deleteRole(Integer id) {
		roleMapper.deleteByPrimaryKey(id);
	}
	
}
