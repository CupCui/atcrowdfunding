<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <jsp:include page="/WEB-INF/jsp/common/top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
        <jsp:include page="/WEB-INF/jsp/common/menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
			  
			  
			  
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="condition" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>



<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button id="addBtn" type="button" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination"></ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
          </div>
			  </div>
			</div>
        </div>
      </div>
    </div>






<!-- 模态框：添加 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加角色</h4>
      </div>
      <div class="modal-body">
      
		<form id="addForm" role="form" >
		  <div class="form-group">
			<label for="exampleInputPassword1">角色名称</label>
			<input type="text" class="form-control" name="name" placeholder="请输入角色名称">
		  </div>
		</form>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="modalSaveBtn" type="button" class="btn btn-primary">保存</button>
      </div>
    </div>
  </div>
</div>






<!-- 模态框：修改 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改角色</h4>
      </div>
      <div class="modal-body">
      
		<form id="updateForm" role="form" >
		  <div class="form-group">
			<label for="exampleInputPassword1">角色名称</label>
			<input type="hidden" name="id">
			<input type="text" class="form-control" name="name" placeholder="请输入角色名称">
		  </div>
		</form>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="modalUpdateBtn" type="button" class="btn btn-primary">修改</button>
      </div>
    </div>
  </div>
</div>











    <%@ include file="/WEB-INF/jsp/common/js.jsp" %>
        <script type="text/javascript">
            $(function () {  //页面加载完成时触发事件处理。ready()函数
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            
            	showData(1);
            });
            
            var jsonObj = { //两种格式，一种直接传字符串，一种json格式
        			pageNum:1,
        			pageSize:2
        		};
            
            
            //发起异步请求，从后台获取数据，局部刷新到页面上。
            function showData(pageNum){
            	jsonObj.pageNum = pageNum ;
            	var index = -1;
            	$.ajax({
            		type:'post',
            		url:'${PATH}/role/loadData',
            		data:jsonObj,
            		beforeSend:function(){
            			index = layer.load(3,{time:10*1000}); //表示弹层组件第几个层
            			//可以做一些表单数据校验。
            			return true ; //发起请求前执行操作成功。就会发走请求，否则，停止发起请求。
            		},
            		success:function(result){ // PageInfo<TRole> ->>  JSON对象
            			console.log(result);
            		
            			jsonObj.pages = result.pages;  // 总页码 
            		
            			//显示表格数据
            			showTable(result.list);
            			
            			//显示分页导航条
            			showNavg(result);
            		
            			layer.close(index);
            		}
            	});          	
            	
            }
            
          	//显示表格数据
            function showTable(list){
            	var content = '';
          		$.each(list,function(i,e){ //e  ->>  TRole对象
          			content+='<tr>';
          			content+='  <td>'+(i+1)+'</td>';
          			content+='  <td><input type="checkbox"></td>';
          			content+='  <td>'+e.name+'</td>';
          			content+='  <td>';
          			content+='	  <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
          			content+='	  <button type="button" roleId="'+e.id+'" class="updateBtnClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
          			content+='	  <button type="button" roleId="'+e.id+'" class="deleteBtnClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
          			content+='  </td>';
          			content+='</tr>';
          		});
          		
          		$("tbody").html(content);
            }
            
          	//显示分页导航条
 			function showNavg(pageInfo){
            	var navg = '';
            	if(pageInfo.isFirstPage){
            		navg+='<li class="disabled"><a href="#">上一页</a></li>';
            	}else{
            		navg+='<li><a onclick="showData('+(pageInfo.pageNum-1)+')">上一页</a></li>';
            	}
            	
            	$.each(pageInfo.navigatepageNums,function(i,num){
            		if(num == pageInfo.pageNum){
            			navg+='<li class="active"><a onclick="showData('+num+')">'+num+'</a></li>';
            		}else{
            			navg+='<li><a onclick="showData('+num+')">'+num+'</a></li>';
            		}            		
            	});

            	if(pageInfo.isLastPage){
            		navg+='<li class="disabled"><a href="#">下一页</a></li>';
            	}else{
            		navg+='<li><a onclick="showData('+(pageInfo.pageNum+1)+')">下一页</a></li>';
            	}
            	
            	$(".pagination").html(navg);
            }
            
            
          	//条件查询
            $("#searchBtn").click(function(){
            	var condition = $("#condition").val();
            	jsonObj.condition = condition;//给json对象增加自定义属性
            	showData(1);
            });
          	
          	
            
            //~~~~~~~~~~添加功能  开始~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            $("#addBtn").click(function(){
            	$('#addModal').modal({
            		show:true,
            		backdrop:'static',
            		keyboard:false
            	});
            });
            
            $("#modalSaveBtn").click(function(){
            	//1.获取表单数据
            	var name = $("#addModal input[name='name']").val();
            	
            	//2.发起ajax请求，保存表单数据
            	//$.post()函数，代替复杂ajax()函数；表示发起method='post'请求，并且默认是异步请求。
            	$.post("${PATH}/role/doAdd",{name:name},function(result){
            		if('ok'==result){
            			layer.msg("操作成功",function(){
            				$('#addModal').modal('hide');
            				$("#addModal input[name='name']").val('');
            				showData(jsonObj.pages+1);
            			});
            		}else{
            			layer.msg("操作失败");
            		}
            	});
            });
            
            //~~~~~~~~~~添加功能  结束~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            
            
            
            
            
            
            //~~~~~~~~~~修改功能  开始~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            //局部刷新元素，是页面后来元素，不能用click()函数增加单击事件处理的。
            /* $(".updateBtnClass").click(function(){
            	var roleId = $(this).attr("roleId");
            	alert(roleId);
            }); */
            
            $("tbody").on("click",".updateBtnClass",function(){
            	
            	//1.获取自定义属性，得到角色id
            	var roleId = $(this).attr("roleId");
            	
            	//2.根据id查询角色对象发起ajax请求
            	$.get("${PATH}/role/get",{id:roleId},function(result){  // result -->>  TRole
            		//3.表单回显
            		$("#updateModal input[name='name']").val(result.name);
            		$("#updateModal input[name='id']").val(result.id);
            		
            		//4.弹出模态框
            		$("#updateModal").modal({
            			show:true,
            			backdrop:'static',
            			keyboard:false
            		});
            	});
            	
            });
            
            
            
            $("#modalUpdateBtn").click(function(){
            	//1.获取表单数据
            	var name = $("#updateModal input[name='name']").val();
            	var id = $("#updateModal input[name='id']").val();
            	
            	//2.发起ajax请求，保存表单数据
            	//$.post()函数，代替复杂ajax()函数；表示发起method='post'请求，并且默认是异步请求。
            	$.post("${PATH}/role/doUpdate",{id:id,name:name},function(result){
            		if('ok'==result){
            			layer.msg("操作成功",function(){
            				$('#updateModal').modal('hide');            				
            				showData(jsonObj.pageNum);
            			});
            		}else{
            			layer.msg("操作失败");
            		}
            	});
            });
            
            
            //~~~~~~~~~~修改功能  结束~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            
            
            
            //~~~~~~~~~~删除功能  开始~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            $("tbody").on("click",".deleteBtnClass",function(){
            	var roleId = $(this).attr("roleId");
            	layer.confirm("您确定要删除吗?",{btn:['确定','取消'],icon:3,title:'提示'},function(index){
            		
            		$.post("${PATH}/role/delete",{id:roleId},function(result){
            			if('ok'==result){
            				layer.msg("操作成功");
            				showData(jsonObj.pageNum);
                		}else{
                			layer.msg("操作失败");
                		}
            		});
            		
            		layer.close();
            	},function(index){
            		layer.close();
            	});
            });
             
            //~~~~~~~~~~删除功能  结束~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            
            
            
            
            
            
            
            
        </script>
  </body>
</html>
    