/*
 * @Author: xskj
 * @Date: 2023-12-29 16:19:41
 * @LastEditors: xskj
 * @LastEditTime: 2023-12-30 14:29:53
 * @Description: 主题共享状态  继承基类状态BasedState
 */

import 'dart:ui';

import 'package:app_template/config/ThemesConfig.dart';
import 'package:flutter/material.dart';
import 'AppState.dart';

class ThemeState  extends AppState  {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  Map  _theme =ThemesConfig.themes;
  Map get theme=>_theme;

  // 主题改变后，通知其依赖项，新主题会立即生效应用x.setUser = user;
  set setTheme(Map theme2) {
    /*
      static Map themes= {
       "primarySwatch":Colors.blue, //主题颜色样本，见下面介绍
       "primaryColor":Colors.blue, //主色，决定导航栏颜色
       "cardColor":Colors.white, //卡片颜色
       "dividerColor":Colors.black, //分割线颜色
       //"buttonTheme":, //按钮主题
       "dialogBackgroundColor":Colors.white,//对话框背景颜色
       //"fontFamily":, //文字字体
       //"textTheme":,// 字体主题，包括标题、body等文字样式
       //"iconTheme":, // Icon的默认样式
       //"platform":, //指定平台，应用特定平台控件风格
       //"colorScheme":
    };
    */
    if (theme2 != _theme) {
      _theme = theme2;
      //通知widget更新
      notifyListeners();
    }
  }
}
