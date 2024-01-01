/*
 * @Author: xskj
 * @Date: 2023-12-29 16:45:45
 * @LastEditors: xskj
 * @LastEditTime: 2023-12-29 17:36:13
 * @Description: 路由设置
 */
import 'package:flutter/material.dart';
//导入页面文件
import '../pages/HomePage.dart';

//路由表
Map<String, WidgetBuilder> routes = {
  "/": (context) => const HomePage(),     //注册根路由:默认第一个为系统根路由： initialRoute: "/",
  "/home": (context) => const HomePage(), //home咯有
};



//路由拦截处理
Function onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  print("--------------------");
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
