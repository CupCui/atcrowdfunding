package com.atguigu.atcrowdfunding.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.util.Const;

@Controller
public class DispatcherController {

	@Autowired
	AdminService adminService;
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/main")
	public String main() {
		System.out.println("main...");
		return "main";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		if(session!=null) { //session失效
			session.removeAttribute(Const.LOGIN_ADMIN);
			session.invalidate();
		}
		return "redirect:/login";
	}
	
	
	@RequestMapping("/doLogin")
	public String doLogin(String loginacct,String userpswd,HttpSession session,Model model) {
		
		System.out.println("loginacct="+loginacct);
		System.out.println("userpswd="+userpswd);
		
		try {
			TAdmin admin = adminService.getAdminByLogin(loginacct,userpswd);
			session.setAttribute(Const.LOGIN_ADMIN, admin);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			model.addAttribute(Const.MESSAGE, e.getMessage());
			
			return "forward:/WEB-INF/jsp/login.jsp"; //直接转发，不进行视图解析。
		}

		//return "main"; //转发请求，路径是不变的
		return "redirect:/main"; //重定向请求，路径变成跳转路径。避免登录表单重复提交。
	}
	
	
}
