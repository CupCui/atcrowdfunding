<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
<form id="searchForm" class="form-inline" role="form" style="float:left;" action="${PATH}/admin/index" method="post">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input class="form-control has-success" type="text" name="condition" value="${param.condition }" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/toAdd'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox"></th>
                  <th>账号</th>
                  <th>名称</th>
                  <th>邮箱地址</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
	              <c:forEach items="${page.list }"  var="admin" varStatus="status">
		                <tr>
		                  <td>${status.count}</td>
						  <td><input type="checkbox"></td>
		                  <td>${admin.loginacct }</td>
		                  <td>${admin.username }</td>
		                  <td>${admin.email }</td>
		                  <td>
						      <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
						      <button type="button" class="updateBtnClass btn btn-primary btn-xs" href="${PATH}/admin/toUpdate?id=${admin.id}&pageNum=${page.pageNum}"><i class=" glyphicon glyphicon-pencil"></i></button>
							  <button type="button" class="deleteBtnClass btn btn-danger btn-xs" href="${PATH}/admin/doDelete?id=${admin.id}&pageNum=${page.pageNum}" ><i class=" glyphicon glyphicon-remove"></i></button>
						  </td>
		                </tr>
	                </c:forEach>

              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">
								<c:if test="${page.isFirstPage }">
									<li class="disabled"><a href="#">上一页</a></li>
								</c:if>
								<c:if test="${!page.isFirstPage }">
									<li><a href="${PATH}/admin/index?pageNum=${page.pageNum -1}&pageSize=2&condition=${param.condition}">上一页</a></li>
								</c:if>
							
								<c:forEach items="${page.navigatepageNums}" var="num">
									<c:if test="${num == page.pageNum }">
										<li class="active"><a href="${PATH}/admin/index?pageNum=${num}&condition=${param.condition}">${num}</a></li>
									</c:if>
									<c:if test="${num != page.pageNum }">
										<li><a href="${PATH}/admin/index?pageNum=${num}&condition=${param.condition}">${num}</a></li>
									</c:if>
								</c:forEach>
								
								<c:if test="${page.isLastPage }">
									<li class="disabled"><a href="#">下一页</a></li>
								</c:if>
								<c:if test="${!page.isLastPage }">
									<li><a href="${PATH}/admin/index?pageNum=${page.pageNum + 1}&pageSize=2&condition=${param.condition}">下一页</a></li>
								</c:if>
						</ul>
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

    <%@ include file="/WEB-INF/jsp/common/js.jsp" %>
        <script type="text/javascript">
            $(function () {
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
            });

            $("#searchBtn").click(function(){
            	$("#searchForm").submit();
            });
            
            
            $(".updateBtnClass").click(function(){
            	//var href = this.href; //this表示当前按钮对象，是一个dom对象。href是自定义属性。通过dom对象不能直接获取自定义属性的。
            	var href = $(this).attr("href") ; //将dom对象转换为jquery对象，通过attr()函数获取自定义属性值。
            	window.location.href = href ; //执行重定向，向服务器发起客户端请求。
            });
            
            $(".deleteBtnClass").click(function(){
            	var href = $(this).attr("href") ;
            	layer.confirm("确定要删除吗?",{btn:['确定','取消'],title:'提示',icon:3},function(index){
            		window.location.href = href ; 
            		layer.close(index);
            	},function(index){
            		layer.close(index);
            	});
            });
            
            
        </script>
  </body>
</html>
    