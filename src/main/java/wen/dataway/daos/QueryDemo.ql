// SQL 执行器切换为分页模式
hint FRAGMENT_SQL_QUERY_BY_PAGE = true
// 定义查询SQL
var dataSet = @@sql()<% select * from user_info %>
// 创建分页查询对象
var pageQuery = dataSet();
// 设置分页信息:pageSize:每页有多少个
run pageQuery.setPageInfo({"pageSize":3, "currentPage":1});
var result = pageQuery.data();
return result;