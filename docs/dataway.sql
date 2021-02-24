/*
 Navicat Premium Data Transfer

 Source Server         : claudia
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : dataway

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 24/02/2021 13:57:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for interface_info
-- ----------------------------
DROP TABLE IF EXISTS `interface_info`;
CREATE TABLE `interface_info`  (
  `api_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ID',
  `api_method` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'HttpMethod：GET、PUT、POST',
  `api_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '拦截路径',
  `api_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态：-1-删除, 0-草稿，1-发布，2-有变更，3-禁用',
  `api_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '注释',
  `api_type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '脚本类型：SQL、DataQL',
  `api_script` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '查询脚本：xxxxxxx',
  `api_schema` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接口的请求/响应数据结构',
  `api_sample` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求/响应/请求头样本数据',
  `api_option` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '扩展配置信息',
  `api_create_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建时间',
  `api_gmt_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`api_id`) USING BTREE,
  UNIQUE INDEX `uk_interface_info`(`api_path`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Dataway 中的API' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interface_info
-- ----------------------------
INSERT INTO `interface_info` VALUES ('i_efdm8g2jh-6jl', 'POST', '/api/demos', '0', '', 'DataQL', '// 执行SQL\n// var dataSet = @@sql()<%\n//     select * from user_info limit 3\n// %>\n// return dataSet()\n\n//SQL参数化\n// var dataSet = @@sql(id)<%\n//     select * from user_info where id = #{id}\n// %>\n// return dataSet(1)\n\n// SQL注入\n// var orderBy = ${orderField} + \" \" + ${orderType};\n// var dataSet = @@sql(name, orderStr)<% \n//     select * from user_info where name = #{name} order by ${orderStr} limit 2;\n// %>\n// return dataSet(\'user-2\', id)\n\n// var testData = {\n//     \"name\":\"masan\",\n//     \"age\":26,\n//     \"status\":0\n// }\n// var insertSQL = @@sql(userInfo)<%\n//     insert into user_info(name, age, status)\n//     values(#{userInfo.name}, #{userInfo.age}, #{userInfo.status})\n// %>\n// return insertSQL(testData);\n\n// var testData = [{\"name\":\"mayi\", \"age\":26, \"status\":0}, {\"name\":\"maer\", \"age\":26, \"status\":0}, {\"name\":\"masan\", \"age\":26, \"status\":0}]\n// var insertSQL = @@sql[](userInfo)<%\n//     insert into user_info(name, age, status) values(#{userInfo.name}, #{userInfo.age}, #{userInfo.status})\n// %>\n// return insertSQL(testData);\n\n// \"value\": 8\n// var dataSet = @@sql() <% select count(*) as cnt from user_info;%>\n// var result = dataSet();\n// return result;\n\n// hint FRAGMENT_SQL_OPEN_PACKAGE = \"row\" // 拆包模式设置为：行 | 返回  \"value\": {\"cnt\": 8}\n// var dataSet = @@sql() <% select count(*) as cnt from user_info; %>\n// var result =  dataSet();\n// return result;\n\n// hint FRAGMENT_SQL_OPEN_PACKAGE = \"off\" // 拆包模式设置为：关闭 | 返回  \"value\": [{\"cnt\": 8}]\n// var dataSet = @@sql() <% select count(*) as cnt from user_info; %>\n// var result =  dataSet();\n// return result;\n\n// 通过一个 hint 来控制 SQL 执行器对列名的统一处理\n// hint FRAGMENT_SQL_COLUMN_CASE = \"hump\"\n// var dataSet = @@sql()<% select pub_id, pub_api_id from interface_release; %>\n// var result = dataSet();\n// return result;\n\n// // SQL 执行器切换为分页模式\n// hint FRAGMENT_SQL_QUERY_BY_PAGE = true\n// // 定义查询SQL\n// var dataSet = @@sql()<%\n//     select * from user_info\n// %>\n// // 创建分页查询对象\n// var pageQuery = dataSet();\n// //设置分页信息:pageSize:每页有多少个\n// run pageQuery.setPageInfo({\"pageSize\":3, \"currentPage\":1});\n// var result = pageQuery.data();\n// return result;\n\n// // 关于第一页：方式一\n// hint FRAGMENT_SQL_QUERY_BY_PAGE = true\n// import \'net.hasor.dataql.fx.basic.ConvertUdfSource\' as convert;\n// // 定义查询SQL\n// var dataSet = @@sql()<%\n//     select * from user_info\n// %>\n// // 创建分页查询对象\n// var pageQuery = dataSet();\n// //设置分页信息:pageSize:每页有多少个\n// run pageQuery.setPageInfo({\n//     \"pageSize\":3, \n//     \"currentPage\":(convert.toInt(${pageNumber}) - 1)\n// });\n// var result = pageQuery.data();\n// return result;\n\n// // 关于第一页：方式二（推荐）\n// hint FRAGMENT_SQL_QUERY_BY_PAGE = true\n// hint FRAGMENT_SQL_QUERY_BY_PAGE_NUMBER_OFFSET = 1\n// // 定义查询SQL\n// var dataSet = @@sql()<%\n//     select * from user_info\n// %>\n// // 创建分页查询对象\n// var pageQuery = dataSet();\n// //设置分页信息:pageSize:每页有多少个\n// run pageQuery.setPageInfo({\n//     \"pageSize\":3, \n//     \"currentPage\":2\n// });\n// var result = pageQuery.data();\n// return result;\n\n// // 多数据源: 如果不设置 FRAGMENT_SQL_DATA_SOURCE 使用的是 defaultDs 数据源\n// //   - 设置值为 \"ds_A\" ，使用的是 dsA 数据源\n// //   - 设置值为 \"ds_B\" ，使用的是 dsB 数据源\n// hint FRAGMENT_SQL_DATA_SOURCE = \"datasourceB\"\n// var dataSet = @@sql() <% select * from books limit 2; %>\n// return dataSet();\n\n// // 多条查询:一次SQL执行的过程中包含了一个以上的SQL语句，ERROR\n// hint FRAGMENT_SQL_MULTIPLE_QUERIES = true\n// var dataSet = @@sql() <%\n//     insert into user_info(name, sex, age, status) values (\'test_name\', 1, 22, 1);\n//     select * from user_info;\n// %>\n \n// return dataSet();\n\nvar dimSQL = @@mybatis(username) <%\n    <select>\n        select * from user_info where name like #{username} order by id\n    </select>\n%>\nreturn dimSQL(\'%use%\');', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\\"username\\\":\\\"use\\\"}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1612513863257', '1612693667653');
INSERT INTO `interface_info` VALUES ('i_efej6hmbc9342', 'GET', '/api/func_x', '0', '', 'DataQL', '// import \'net.hasor.dataql.fx.basic.ConvertUdfSource\' as convert;\n// return convert.toInt(\"12\")\n\n// filter\n// import \'net.hasor.dataql.fx.basic.CollectionUdfSource\' as collect;\n// var dataList = [\n//     {\"name\" : \"马一\" , \"age\" : 18 },\n//     {\"name\" : \"马二\" , \"age\" : 28 },\n//     {\"name\" : \"马三\" , \"age\" : 30 },\n//     {\"name\" : \"马四\" , \"age\" : 25 }\n// ]\n \n// var result = collect.filter(dataList, (dat) -> {\n//     return dat.age > 20;\n// });\n// return result;\n\n// import \'net.hasor.dataql.fx.basic.CollectionUdfSource\' as collect;\n// var data = [[1, 2, 3, [4, 5]], [6, 7, 8, 9, 0]]\n// var foo = (data, arrayObj) -> {\n//     var tmpArray = data => [ # ];\n//     if (tmpArray[0] == data){\n//         run arrayObj.addLast(data);\n//     } else {\n//         run tmpArray => [ foo(#, arrayObj)];\n//     }\n//     return arrayObj;\n// }\n// var newList = collect.newList();\n// var result = foo(data, newList).data();\n// return result;\n\n// import \'net.hasor.dataql.fx.basic.CollectionUdfSource\' as collect;\n// var mapData = collect.newMap({\'key\':\'123\'});\n// var mapData = mapData.put(\'sss\', \'sss\')\n// var mapData = mapData.putAll({\'id\':1, \'parent_id\':null, \'label\':\'t1\'})\n// return mapData.data();\n\nimport \'net.hasor.dataql.fx.basic.CollectionUdfSource\' as collect;\nvar year2019 = [\n    { \"pt\":2019, \"item_code\":\"code_1\", \"sum_price\":2234 },\n    { \"pt\":2019, \"item_code\":\"code_2\", \"sum_price\":234 },\n    { \"pt\":2019, \"item_code\":\"code_3\", \"sum_price\":12340 },\n    { \"pt\":2019, \"item_code\":\"code_4\", \"sum_price\":2344 }\n];\n \nvar year2018 = [\n    { \"pt\":2018, \"item_code\":\"code_1\", \"sum_price\":1234.0 },\n    { \"pt\":2018, \"item_code\":\"code_2\", \"sum_price\":1234.0 },\n    { \"pt\":2018, \"item_code\":\"code_3\", \"sum_price\":1234.0 },\n    { \"pt\":2018, \"item_code\":\"code_4\", \"sum_price\":1234.0 }\n];\n\nvar result = collect.mapJoin(year2019, year2018, {\"item_code\":\"item_code\"})=>[\n    {\n        \"商品Code\": data1.item_code,\n        \"去年同期\": data2.sum_price,\n        \"今年总额\": data1.sum_price,\n        \"环比去年增长\": ((data1.sum_price - data2.sum_price) / data2.sum_price * 100) + \"%\"\n    }\n]\nreturn result;', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1612680439956', '1612686139515');
INSERT INTO `interface_info` VALUES ('i_efjh5c6dg7d52', 'GET', '/api/pm/login', '0', '登录', 'DataQL', 'import \"wen.pm.dataway.util.PasswordUtil\" as passwordUtil\r\nimport \"wen.pm.dataway.util.TokenUtil\" as tokenUtil\r\n// 判空\r\nif (${password} == null || ${username} == null){ return false }\r\n// 从数据库取数据\r\nvar dataSet = @@sql(username) <%\r\n    SELECT id, username, password \r\n    FROM pm.pm_user \r\n    WHERE username = #{username}\r\n%>\r\n// 对比数据库的密码 db_password 与 input_password\r\nvar db_password = passwordUtil.encode(dataSet(${username}).password)\r\nvar input_password = passwordUtil.encode(${password})\r\nif (input_password == db_password){\r\n    // 验证成功，返回token\r\n    return tokenUtil.createToken(dataSet().id, \"H\", 12)\r\n}\r\nreturn false', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\r\\n    \\\"username\\\":\\\"admin\\\",\\r\\n    \\\"password\\\":\\\"d033e22ae348aeb5660fc2140aec35850c4da997\\\"\\r\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1613619619529', '1613810923746');
INSERT INTO `interface_info` VALUES ('i_efk6j2j944kfg', 'GET', '/api/pm/get_stuff_code_list', '0', '查询材料代码列表', 'DataQL', 'import \'wen.pm.dataway.util.PmUtil\' as pmUtil\n \nif ( ${token} == null) { return false }\n \n// 从密钥获取 id\nvar id = pmUtil.getUidByToken(${token})\nif (id == null) { return false }\n    \n// 从数据库中查找 code list\nvar dataSet = @@sql(id) <% \n    SELECT stuff_code \n    FROM pm.pm_stuff\n    WHERE u_id = #{id}\n %>\nreturn dataSet(id)', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\r\\n    \\\"token\\\":\\\"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImV4cGlyZSI6MTYxMzc3MzgwMzE5MiwiY3JlYXRlVGltZSI6MTYxMzczMDYwMzE5Miwic3ViIjoiWFVFTEFOR1lVTl9PU19QTSJ9.v8i9gNaDf8azMHnivJksJ693eD6IwLMKJBCYfDfv6eU\\\"\\r\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1613727647644', '1613810874105');
INSERT INTO `interface_info` VALUES ('i_efke8ba7b-5ij', 'GET', '/api/pm/get_stuff_code_list_by_type', '0', '查询特定材料类型代码列表', 'DataQL', 'import \'wen.pm.dataway.util.PmUtil\' as pmUtil\r\n \r\nif ( ${token} == null || ${type} == null) { return false }\r\n \r\n// 从密钥获取 id\r\nvar id = pmUtil.getUidByToken(${token})\r\nif (id == null) { return false }\r\n    \r\n// 从数据库中查找 code list\r\nvar dataSet = @@sql(id, type) <% \r\n    SELECT stuff_code \r\n    FROM pm.pm_stuff\r\n    WHERE u_id = #{id}\r\n    AND stuff_type = #{type}\r\n %>\r\nreturn dataSet(id, ${type})', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\r\\n    \\\"token\\\":\\\"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImV4cGlyZSI6MTYxMzc3MzgwMzE5MiwiY3JlYXRlVGltZSI6MTYxMzczMDYwMzE5Miwic3ViIjoiWFVFTEFOR1lVTl9PU19QTSJ9.v8i9gNaDf8azMHnivJksJ693eD6IwLMKJBCYfDfv6eU\\\",\\r\\n    \\\"type\\\":\\\"板材\\\"\\r\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1613787818291', '1613810859949');
INSERT INTO `interface_info` VALUES ('i_efkejl92j7jjc', 'GET', '/api/pm/get_stuff_by_code', '0', '查询材料信息', 'DataQL', 'hint MAX_DECIMAL_DIGITS = 2\r\nimport \'wen.pm.dataway.util.PmUtil\' as pmUtil\r\nimport \'net.hasor.dataql.fx.basic.CollectionUdfSource\' as collect;\r\n\r\nif ( ${token} == null || ${code} == null) { return false }\r\n\r\n// 从密钥获取 id\r\nvar id = pmUtil.getUidByToken(${token})\r\nif (id == null) { return false }\r\n\r\n// 从数据库中查找 code list\r\nvar stuffDataSet = @@sql(id, code) <% \r\n    SELECT stuff_code, extent, width, gap, stuff_type\r\n    FROM pm.pm_stuff\r\n    WHERE u_id = #{id}\r\n    AND stuff_code = #{code}\r\n%>\r\n// 转化为 map\r\nvar stuffData = stuffDataSet(id, ${code}) => [ # ]\r\n\r\n// 从数据库中查找符合材料代码的零件\r\nvar cpntDataSet = @@sql(id, code) <% \r\n    SELECT id, u_id, cpt_code, cpt_count, cpt_size, \r\n    stuff_code, cpt_direction, create_time, update_time\r\n    FROM pm.pm_component\r\n    WHERE u_id = #{id}\r\n    AND stuff_code = #{code}\r\n%>\r\nvar cpntData = cpntDataSet(id, ${code}) => [ # ]\r\n\r\nreturn collect.mapJoin(stuffData, cpntData, {\'stuff_code\' : \'stuff_code\'}) =>[\r\n    {\r\n        \'code\': data1.stuff_code,\r\n        \'extent\': data1.extent,\r\n        \'width\': data1.width,\r\n        \'gap\': data1.gap,\r\n        \'type\': data1.stuff_type,\r\n        \'componentList\': cpntData\r\n    }\r\n]', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\r\\n    \\\"token\\\":\\\"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImV4cGlyZSI6MTYxMzc3MzgwMzE5MiwiY3JlYXRlVGltZSI6MTYxMzczMDYwMzE5Miwic3ViIjoiWFVFTEFOR1lVTl9PU19QTSJ9.v8i9gNaDf8azMHnivJksJ693eD6IwLMKJBCYfDfv6eU\\\",\\r\\n    \\\"code\\\":\\\"110000005301\\\"\\r\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1613791605379', '1613893326707');
INSERT INTO `interface_info` VALUES ('i_eflbg48nf7jc8', 'GET', '/api/pm/get_component_by_code', '0', '查询零件', 'DataQL', 'hint MAX_DECIMAL_DIGITS = 2\nimport \'wen.pm.dataway.util.PmUtil\' as pmUtil\nimport \'net.hasor.dataql.fx.basic.CollectionUdfSource\' as collect;\n\nif ( ${token} == null || ${code} == null) { return false }\n\n// 从密钥获取 id\nvar id = pmUtil.getUidByToken(${token})\nif (id == null) { return false }\n\nvar cpntDataSet = @@sql(id, code)<%\n    SELECT * \n    FROM pm.pm_component\n    WHERE u_id = #{id}\n    AND cpt_code = #{code}\n%>\n// 转化为map\nvar cpntData = cpntDataSet(id, ${code}) => [ # ]\nreturn cpntData', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\r\\n    \\\"token\\\":\\\"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImV4cGlyZSI6MTYxMzc3MzgwMzE5MiwiY3JlYXRlVGltZSI6MTYxMzczMDYwMzE5Miwic3ViIjoiWFVFTEFOR1lVTl9PU19QTSJ9.v8i9gNaDf8azMHnivJksJ693eD6IwLMKJBCYfDfv6eU\\\",\\r\\n    \\\"code\\\":\\\"2585A01011G700-1\\\"\\r\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1613957590071', '1613960343356');
INSERT INTO `interface_info` VALUES ('i_eflc127ch6mmn', 'GET', '/api/pm/produce', '0', '投入生产', 'DataQL', '// 更新当前选中的批次的 IsProduce 字段值\r\nif ( ${batch} == null ) return \' variable batch is null \'\r\nvar result = @@sql( batch )<%\r\n    UPDATE pm.pm_record \r\n    SET is_produce = true\r\n    WHERE batch = #{batch}\r\n%>\r\nif ( result( ${batch} ).value < 1) return \' altering is_produce field failed \'\r\n// 处理该批次号投入生产后的库存逻辑\r\nvar stuffRecordDataSet = @@sql( batch )<%\r\n    SELECT * FROM pm.pm_stuff_record\r\n    WHERE batch = #{batch}\r\n%>\r\nvar stuffRecords = stuffRecordDataSet(${batch}) => [ # ]\r\nvar remainderStockDataSet = @@sql( batch )<%\r\n    DELETE FROM pm.pm_remainder_stock\r\n    WHERE stuff_code in (\r\n        SELECT stuff_code\r\n        FROM pm.pm_stuff_record\r\n        WHERE batch = #{batch}\r\n    )\r\n%>\r\nreturn remainderStockDataSet( ${batch} )', '{}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\r\\n    \\\"batch\\\": \\\"20200806160927802\\\"\\r\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1613960547569', '1614050871986');

-- ----------------------------
-- Table structure for interface_release
-- ----------------------------
DROP TABLE IF EXISTS `interface_release`;
CREATE TABLE `interface_release`  (
  `pub_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Publish ID',
  `pub_api_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '所属API ID',
  `pub_method` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'HttpMethod：GET、PUT、POST',
  `pub_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '拦截路径',
  `pub_status` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态：-1-删除, 0-草稿，1-发布，2-有变更，3-禁用',
  `pub_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '注释',
  `pub_type` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '脚本类型：SQL、DataQL',
  `pub_script` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '查询脚本：xxxxxxx',
  `pub_script_ori` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原始查询脚本，仅当类型为SQL时不同',
  `pub_schema` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '接口的请求/响应数据结构',
  `pub_sample` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求/响应/请求头样本数据',
  `pub_option` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '扩展配置信息',
  `pub_release_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发布时间（下线不更新）',
  PRIMARY KEY (`pub_id`) USING BTREE,
  INDEX `idx_interface_release_api`(`pub_api_id`) USING BTREE,
  INDEX `idx_interface_release_path`(`pub_path`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Dataway API 发布历史。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interface_release
-- ----------------------------
INSERT INTO `interface_release` VALUES ('r_efcm4bdnaa8b7', 'i_efcm47g98-2bn', 'GET', '/api/select_data_sql', '-1', '', 'DataQL', 'var query = @@sql() <% select * from interface_info %>\nreturn query()', 'var query = @@sql() <% select * from interface_info %>\nreturn query()', '{\"requestHeader\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{}},\"requestBody\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{\"message\":{\"type\":\"string\"}}},\"responseHeader\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{}},\"responseBody\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{\"executionTime\":{\"type\":\"number\"},\"code\":{\"type\":\"number\"},\"success\":{\"type\":\"boolean\"},\"lifeCycleTime\":{\"type\":\"number\"},\"message\":{\"type\":\"string\"},\"value\":{\"type\":\"array\",\"items\":{\"type\":\"object\",\"properties\":{\"api_option\":{\"type\":\"string\"},\"api_id\":{\"type\":\"string\"},\"api_create_time\":{\"type\":\"string\"},\"api_method\":{\"type\":\"string\"},\"api_type\":{\"type\":\"string\"},\"api_script\":{\"type\":\"string\"},\"api_gmt_time\":{\"type\":\"string\"},\"api_schema\":{\"type\":\"string\"},\"api_sample\":{\"type\":\"string\"},\"api_status\":{\"type\":\"string\"},\"api_comment\":{\"type\":\"string\"},\"api_path\":{\"type\":\"string\"}}}}}}}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\\"message\\\":\\\"Hello DataQL.\\\"}\",\"responseHeader\":\"{}\",\"responseBody\":\"{\\n\\t\\\"success\\\":true,\\n\\t\\\"message\\\":\\\"OK\\\",\\n\\t\\\"code\\\":0,\\n\\t\\\"lifeCycleTime\\\":10,\\n\\t\\\"executionTime\\\":2,\\n\\t\\\"value\\\":[\\n\\t\\t{\\n\\t\\t\\t\\\"api_id\\\":\\\"i_efcm35klf90d7\\\",\\n\\t\\t\\t\\\"api_method\\\":\\\"GET\\\",\\n\\t\\t\\t\\\"api_path\\\":\\\"/api/demo_select\\\",\\n\\t\\t\\t\\\"api_status\\\":\\\"0\\\",\\n\\t\\t\\t\\\"api_comment\\\":\\\"\\\",\\n\\t\\t\\t\\\"api_type\\\":\\\"SQL\\\",\\n\\t\\t\\t\\\"api_script\\\":\\\"select * from interface_info\\\",\\n\\t\\t\\t\\\"api_schema\\\":\\\"{}\\\",\\n\\t\\t\\t\\\"api_sample\\\":\\\"{\\\\\\\"requestHeader\\\\\\\":\\\\\\\"[]\\\\\\\",\\\\\\\"requestBody\\\\\\\":\\\\\\\"{\\\\\\\\\\\\\\\"message\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"Hello DataQL.\\\\\\\\\\\\\\\"}\\\\\\\"}\\\",\\n\\t\\t\\t\\\"api_option\\\":\\\"{\\\\\\\"wrapAllParameters\\\\\\\":false,\\\\\\\"enableCrossDomain\\\\\\\":true,\\\\\\\"API_BASE_URL\\\\\\\":\\\\\\\"/api/\\\\\\\",\\\\\\\"ALL_MAC\\\\\\\":\\\\\\\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\\\\\\\",\\\\\\\"resultStructure\\\\\\\":true,\\\\\\\"showGitButton\\\\\\\":true,\\\\\\\"DATAWAY_VERSION\\\\\\\":\\\\\\\"4.2.2\\\\\\\",\\\\\\\"checkDatawayVersion\\\\\\\":true,\\\\\\\"CONTEXT_PATH\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"responseFormat\\\\\\\":\\\\\\\"{\\\\\\\\n    \\\\\\\\\\\\\\\"success\\\\\\\\\\\\\\\"      : \\\\\\\\\\\\\\\"@resultStatus\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"message\\\\\\\\\\\\\\\"      : \\\\\\\\\\\\\\\"@resultMessage\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"code\\\\\\\\\\\\\\\"         : \\\\\\\\\\\\\\\"@resultCode\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"lifeCycleTime\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\"@timeLifeCycle\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"executionTime\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\"@timeExecution\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\"        : \\\\\\\\\\\\\\\"@resultData\\\\\\\\\\\\\\\"\\\\\\\\n}\\\\\\\",\\\\\\\"wrapParameterName\\\\\\\":\\\\\\\"root\\\\\\\"}\\\",\\n\\t\\t\\t\\\"api_create_time\\\":\\\"1612320959752\\\",\\n\\t\\t\\t\\\"api_gmt_time\\\":\\\"1612320989620\\\"\\n\\t\\t},\\n\\t\\t{\\n\\t\\t\\t\\\"api_id\\\":\\\"i_efcm47g98-2bn\\\",\\n\\t\\t\\t\\\"api_method\\\":\\\"GET\\\",\\n\\t\\t\\t\\\"api_path\\\":\\\"/api/select_data_sql\\\",\\n\\t\\t\\t\\\"api_status\\\":\\\"0\\\",\\n\\t\\t\\t\\\"api_comment\\\":\\\"\\\",\\n\\t\\t\\t\\\"api_type\\\":\\\"DataQL\\\",\\n\\t\\t\\t\\\"api_script\\\":\\\"var query = @@sql() <% select * from interface_info %>\\\\nreturn query()\\\",\\n\\t\\t\\t\\\"api_schema\\\":\\\"{}\\\",\\n\\t\\t\\t\\\"api_sample\\\":\\\"{\\\\\\\"requestHeader\\\\\\\":\\\\\\\"[]\\\\\\\",\\\\\\\"requestBody\\\\\\\":\\\\\\\"{\\\\\\\\\\\\\\\"message\\\\\\\\\\\\\\\":\\\\\\\\\\\\\\\"Hello DataQL.\\\\\\\\\\\\\\\"}\\\\\\\"}\\\",\\n\\t\\t\\t\\\"api_option\\\":\\\"{\\\\\\\"wrapAllParameters\\\\\\\":false,\\\\\\\"enableCrossDomain\\\\\\\":true,\\\\\\\"API_BASE_URL\\\\\\\":\\\\\\\"/api/\\\\\\\",\\\\\\\"ALL_MAC\\\\\\\":\\\\\\\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\\\\\\\",\\\\\\\"resultStructure\\\\\\\":true,\\\\\\\"showGitButton\\\\\\\":true,\\\\\\\"DATAWAY_VERSION\\\\\\\":\\\\\\\"4.2.2\\\\\\\",\\\\\\\"checkDatawayVersion\\\\\\\":true,\\\\\\\"CONTEXT_PATH\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"responseFormat\\\\\\\":\\\\\\\"{\\\\\\\\n    \\\\\\\\\\\\\\\"success\\\\\\\\\\\\\\\"      : \\\\\\\\\\\\\\\"@resultStatus\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"message\\\\\\\\\\\\\\\"      : \\\\\\\\\\\\\\\"@resultMessage\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"code\\\\\\\\\\\\\\\"         : \\\\\\\\\\\\\\\"@resultCode\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"lifeCycleTime\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\"@timeLifeCycle\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"executionTime\\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\"@timeExecution\\\\\\\\\\\\\\\",\\\\\\\\n    \\\\\\\\\\\\\\\"value\\\\\\\\\\\\\\\"        : \\\\\\\\\\\\\\\"@resultData\\\\\\\\\\\\\\\"\\\\\\\\n}\\\\\\\",\\\\\\\"wrapParameterName\\\\\\\":\\\\\\\"root\\\\\\\"}\\\",\\n\\t\\t\\t\\\"api_create_time\\\":\\\"1612321316576\\\",\\n\\t\\t\\t\\\"api_gmt_time\\\":\\\"1612321316576\\\"\\n\\t\\t}\\n\\t]\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1612321370482');
INSERT INTO `interface_release` VALUES ('r_efcnhlk448c1c', 'i_efcmg2ll275a6', 'POST', '/api/select_user_like_name', '-1', '', 'DataQL', 'var queryUser = @@sql(username) <%\n    select * from user_info where \'name\' like concat(\'%\', #{username}, \'%\')\n%>\nreturn queryUser(${username})=>[{\n    \"user_id\" : id,\n    \"user_name\" : name,\n    \"user_sex\" : sex\n}]', 'var queryUser = @@sql(username) <%\n    select * from user_info where \'name\' like concat(\'%\', #{username}, \'%\')\n%>\nreturn queryUser(${username})=>[{\n    \"user_id\" : id,\n    \"user_name\" : name,\n    \"user_sex\" : sex\n}]', '{\"requestHeader\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{}},\"requestBody\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{\"username\":{\"type\":\"string\"}}},\"responseHeader\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{}},\"responseBody\":{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"type\":\"object\",\"properties\":{\"executionTime\":{\"type\":\"number\"},\"code\":{\"type\":\"number\"},\"success\":{\"type\":\"boolean\"},\"lifeCycleTime\":{\"type\":\"number\"},\"message\":{\"type\":\"string\"},\"value\":{\"type\":\"array\",\"items\":{\"type\":[\"string\",\"boolean\",\"number\",\"object\",\"array\",\"null\"]}}}}}', '{\"requestHeader\":\"[]\",\"requestBody\":\"{\\\"username\\\":\\\"1\\\"}\",\"responseHeader\":\"{}\",\"responseBody\":\"{\\n\\t\\\"success\\\":true,\\n\\t\\\"message\\\":\\\"OK\\\",\\n\\t\\\"code\\\":0,\\n\\t\\\"lifeCycleTime\\\":12,\\n\\t\\\"executionTime\\\":1,\\n\\t\\\"value\\\":[]\\n}\"}', '{\"wrapAllParameters\":false,\"enableCrossDomain\":true,\"API_BASE_URL\":\"/api/\",\"ALL_MAC\":\"0A5BD63FE657,005056C00008,085BD63FE658,005056C00001,085BD63FE657,7478271027E2,085BD63FE65B\",\"resultStructure\":true,\"showGitButton\":true,\"DATAWAY_VERSION\":\"4.2.2\",\"checkDatawayVersion\":true,\"CONTEXT_PATH\":\"\",\"responseFormat\":\"{\\n    \\\"success\\\"      : \\\"@resultStatus\\\",\\n    \\\"message\\\"      : \\\"@resultMessage\\\",\\n    \\\"code\\\"         : \\\"@resultCode\\\",\\n    \\\"lifeCycleTime\\\": \\\"@timeLifeCycle\\\",\\n    \\\"executionTime\\\": \\\"@timeExecution\\\",\\n    \\\"value\\\"        : \\\"@resultData\\\"\\n}\",\"wrapParameterName\":\"root\"}', '1612333788004');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` int NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, 'use-1', 1, NULL, NULL);
INSERT INTO `user_info` VALUES (2, 'user-2', 0, NULL, NULL);
INSERT INTO `user_info` VALUES (3, 'user-2', 1, NULL, NULL);
INSERT INTO `user_info` VALUES (4, 'user-2', 0, NULL, NULL);
INSERT INTO `user_info` VALUES (5, 'masan', NULL, 26, 0);
INSERT INTO `user_info` VALUES (6, 'mayi', NULL, 26, 0);
INSERT INTO `user_info` VALUES (7, 'maer', NULL, 26, 0);
INSERT INTO `user_info` VALUES (8, 'masan', NULL, 26, 0);

SET FOREIGN_KEY_CHECKS = 1;