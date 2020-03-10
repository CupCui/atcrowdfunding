package com.atguigu.atcrowdfunding.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.atguigu.atcrowdfunding.util.Const;

@Controller
public class DispatcherController {

	@Autowired
	AdminService adminService; //JDK动态代理【基于接口】、Cglib动态代理【基于继承】
	
	@Autowired
	MenuService menuService;
	
	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	
	@RequestMapping("/main")
	public String main(HttpSession session) {
		//一家人，过年了，大儿子一家回来了（孙子孙女），二儿子一家也回来了（孙子孙女）
		List<TMenu> allParentMenu =  (List<TMenu>)session.getAttribute("allParentMenu");
		
		if(allParentMenu == null) {
			allParentMenu =  menuService.listAllMenu(); //存放所有父菜单
			session.setAttribute("allParentMenu",allParentMenu);
		}
		
		return "main";
	}
	
//	@RequestMapping("/main")
//	public String main(HttpSession session) {
//		//一家人，过年了，大儿子一家回来了（孙子孙女），二儿子一家也回来了（孙子孙女）
//		List<TMenu> allParentMenu =  menuService.listAllMenu(); //存放所有父菜单
//		
//		session.setAttribute("allParentMenu",allParentMenu);
//		
//		return "main";
//	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		if(session!=null) { //session失效
			session.removeAttribute(Const.LOGIN_ADMIN);
			session.invalidate();
		}
		return "redirect:/login";
	}
	
	
	/**
	 * 控制器做三件事：
	 * 		1.获取请求参数
	 * 		2.调用业务层
	 * 		3.根据业务层方法返回结果，跳转页面
	 * @param loginacct
	 * @param userpswd
	 * @param session
	 * @param model
	 * @return
	 */
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
