package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import javax.security.auth.login.LoginException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TAdminExample.Criteria;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.github.pagehelper.PageInfo;

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

	@Override
	public PageInfo<TAdmin> listAllAdmin(Map<String, Object> paramMap) {
		
		TAdminExample example = new TAdminExample(); //用于生成查询条件
		
		String condition = (String)paramMap.get("condition");
		
		//是根据查询条件获取分页数据，还是查询所有进行分页
		if(!StringUtils.isEmpty(condition)) {
			example.createCriteria().andLoginacctLike("%"+condition+"%");			
			
			Criteria criteria2 = example.createCriteria();
			criteria2.andUsernameLike("%"+condition+"%");
			
			Criteria criteria3 = example.createCriteria();
			criteria3.andEmailLike("%"+condition+"%");
			
			example.or(criteria2);
			example.or(criteria3);
		}
		
		//example.setOrderByClause("createtime desc");  //增加   order by createtime desc

		// CRUD   insert   select  update  delete
		List<TAdmin> list = adminMapper.selectByExample(example) ; //一页数据
		
		int navgpages = 5 ; //导航页，默认值8
		
		PageInfo<TAdmin> page = new PageInfo<TAdmin>(list,navgpages);
		
		
		return page;
	}

	@Override
	public void saveAdmin(TAdmin admin) {
		admin.setCreatetime(DateUtil.getFormatTime());
		
		admin.setUserpswd(MD5Util.digest(Const.DEFALUT_PASSWORD));
		
		// insert into t_admin(id,loginacct,userpswd,username,email,createtime) values(?,?,?,?,?,?);
		//adminMapper.insert(admin);  //所有字段都参与插入操作
		
		//insert into t_admin(loginacct,username,email) values(?,?,?);
		adminMapper.insertSelective(admin); //动态SQL,属性值为null的字段，不参与insert操作
	}

	@Override
	public TAdmin getAdminById(Integer id) {		
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateAdmin(TAdmin admin) { //含有 id,loginacct,username,email  不含有upserpswd,createtime
		adminMapper.updateByPrimaryKeySelective(admin); //有选择性更新，生成动态sql,upserpswd,createtime两个字段为null,不参与更新
	}

	@Override
	public void deleteAdmin(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}
	
}
