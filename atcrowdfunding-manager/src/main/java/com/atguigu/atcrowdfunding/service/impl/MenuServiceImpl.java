package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.service.MenuService;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	TMenuMapper menuMapper;

	@Override
	public List<TMenu> listAllMenu() { //集合存储的是所有父，父的children属性里面放的子
		
		List<TMenu> allParentList = new ArrayList<TMenu>(); //存放是所有的父
		
		//21条数据，父和子都在集合中
		List<TMenu> allMenu = menuMapper.selectByExample(null);  //null  表示查询所有
		
		Map<Integer,TMenu> cache = new HashMap<Integer,TMenu>();  //存放是所有的父
		
		//查找出来所有父菜单。相当于老太太的大儿子和儿子
		for(TMenu menu :allMenu) {
			if(menu.getPid() == 0 ) {
				allParentList.add(menu);
				cache.put(menu.getId(), menu); 
			}
		}
		
		//组合父子关系（将儿子和孙子组成一家人）
		for(TMenu menu :allMenu) {
			if(menu.getPid() != 0 ) { //说明这个菜单是子（相当于老太太的孙子）
				Integer pid = menu.getPid(); // 获取父菜单的id
				TMenu parent = cache.get(pid); //  老太太的孙子将自己的亲爹找出现。借助map集合进行查找，比较方便
				parent.getChildren().add(menu); // 父子组合好，理解为大儿子和他孩子组合好了。
			}
		}
		
		System.out.println(allParentList);
		
		return allParentList;
	}
	
	
	
}
