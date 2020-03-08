package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.atguigu.atcrowdfunding.util.Const;

public class AppStartUpListener implements ServletContextListener {

	//服务器启动时执行操作
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext application = sce.getServletContext();
		String contextPath = application.getContextPath(); // 上下文路径（默认与项目名称一样）：   /atcrowdfunding-main
		System.out.println("上下文路径："+contextPath);
		application.setAttribute(Const.PATH, contextPath);
	}

	//服务器停止时，或者项目卸载时执行操作
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("销毁操作...");
	}

}
