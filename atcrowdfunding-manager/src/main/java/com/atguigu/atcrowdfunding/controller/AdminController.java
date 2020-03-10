package com.atguigu.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class AdminController {

	@Autowired
	AdminService adminService;
	
	
	@RequestMapping("/admin/deleteBatch")
	public String deleteBatch(String ids,Integer pageNum) {
		
		adminService.deleteBatchAdmin(ids);
		
		return "redirect:/admin/index?pageNum="+pageNum; //避免表单重复提交
	}
	
	@RequestMapping("/admin/doDelete")
	public String doDelete(Integer id,Integer pageNum) {
		
		adminService.deleteAdmin(id);
		
		return "redirect:/admin/index?pageNum="+pageNum; //避免表单重复提交
	}
	
	@RequestMapping("/admin/doUpdate")
	public String doUpdate(TAdmin admin,Integer pageNum) {
		
		adminService.updateAdmin(admin);
		
		return "redirect:/admin/index?pageNum="+pageNum; //避免表单重复提交
	}
	
	
	@RequestMapping("/admin/toUpdate")
	public String toUpdate(Integer id,Model model) {
		TAdmin admin = adminService.getAdminById(id);
		model.addAttribute("admin", admin);
		return "admin/update";
	}
	
	@RequestMapping("/admin/toAdd")
	public String toAdd() {
		return "admin/add";
	}
	
	@RequestMapping("/admin/doAdd")
	public String doAdd(TAdmin admin) {
		
		adminService.saveAdmin(admin);
		
		return "redirect:/admin/index?pageNum="+Integer.MAX_VALUE; //避免表单重复提交
	}
	
	
	
	@RequestMapping("/admin/index")
	public String index(@RequestParam(value="pageNum",required = false,defaultValue = "1") Integer pageNum,
			@RequestParam(value="pageSize",required = false,defaultValue = "2") Integer pageSize,
			@RequestParam(value="condition",required = false,defaultValue = "") String condition,
			Model model) {
		
		//开启分页功能，底层dao查询时，自动增加limit ?,?
		PageHelper.startPage(pageNum, pageSize); //专车  ThreadLocal  在同一个线程中共享数据
		
		Map<String,Object> paramMap = new HashMap<String,Object>();  //大巴车
		paramMap.put("condition", condition);
		
		//要求业务层将这一页的数据封装成PageInfo对象返回。
		PageInfo<TAdmin> page = adminService.listAllAdmin(paramMap);
		
		model.addAttribute("page", page);  //存放请求域中。
		
		return "admin/index";
	}
	
}
