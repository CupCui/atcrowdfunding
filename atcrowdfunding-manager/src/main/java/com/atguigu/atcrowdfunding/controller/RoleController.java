package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class RoleController {

	@Autowired
	RoleService roleService ;
	
	
	@ResponseBody
	@RequestMapping("/role/delete")
	public String delete(Integer id) {
		roleService.deleteRole(id);
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping("/role/doUpdate")
	public String doUpdate(TRole role) {
		roleService.updateRole(role);
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping("/role/get")
	public TRole get(Integer id) {
		TRole role = roleService.getRoleById(id);
		return role;
	}
	
	
	@ResponseBody
	@RequestMapping("/role/doAdd")
	public String doAdd(TRole role) {
		roleService.saveRole(role);
		return "ok";
	}
	
	
	
	@RequestMapping("/role/index")
	public String index() {
		return "role/index";
	}
	
	
	/*
	 * @ResponseBody 作用：启用框架底层消息转换器：HttpMessageConverter
	 *  比较重要的两个消息转换器：
	 *  如果方法的返回结果是Object类型（List,Bean对象），会根据MappingJackson2HttpMessageConverter进行消息转换。
	 *  	框架默认集成Jackson组件。将对象转换为JSON格式的字符串。
	 *如果方法返回结果是String类型：会根据 StringHttpMessageConverter进行消息转换。将字符串原样返回给浏览器。
	 */
	@ResponseBody
	@RequestMapping("/role/loadData")
	public PageInfo<TRole> index(@RequestParam(value="pageNum",required = false,defaultValue = "1") Integer pageNum,
			@RequestParam(value="pageSize",required = false,defaultValue = "2") Integer pageSize,
			@RequestParam(value="condition",required = false,defaultValue = "") String condition) {
		
		//开启分页功能，底层dao查询时，自动增加limit ?,?
		PageHelper.startPage(pageNum, pageSize); //专车  ThreadLocal  在同一个线程中共享数据
		
		Map<String,Object> paramMap = new HashMap<String,Object>();  //大巴车
		paramMap.put("condition", condition);
		
		//要求业务层将这一页的数据封装成PageInfo对象返回。
		PageInfo<TRole> page = roleService.listPage(paramMap);

		return page; //jeckson组件会将bean对象转换为json格式字符串。返回给浏览器，异步success回调函数。
	}
	
}
