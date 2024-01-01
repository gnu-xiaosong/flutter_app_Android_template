import 'package:app_template/states/DarkState.dart';
import 'package:app_template/states/DescState.dart';
import 'package:app_template/states/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//路由
import './routes/index.dart';
//全局变量
import 'common/GlobalManager.dart';



void main() => GlobalManager.init().then((e) => runApp(
      MultiProvider(
          providers: [
            //全局配置共享状态
            ChangeNotifierProvider<DescState> (create: (_)=>DescState()),
            //全局主题共享状态
            ChangeNotifierProvider<ThemeState>(create: (_)=>ThemeState()),
            //全局暗夜模式
            ChangeNotifierProvider<DarkState>(create: (_)=>DarkState())
          ],
          child: Consumer3<DescState,ThemeState,DarkState>(builder: (BuildContext context, desc,themeState,darkState, child)=> MaterialApp(
                //标题：名称
                title: desc.app.name,
                //主题
                theme: ThemeData(
                    primaryColor: themeState.theme['primaryColor'],
                    primarySwatch:themeState.theme['primarySwatch'], //主题颜色样本，见下面介绍
                    brightness: darkState.mode?Brightness.dark:Brightness.light
                ),
                //生成tile时
                onGenerateTitle: (context) {
                  return desc.app.name;
                },
                //颜色:默认跟随用户设置
                //color: themeState.theme,
                //路由
                initialRoute: routes.keys.first.toString(), //名为"/"的路由作为应用的home(首页)
                routes: routes, //路由表
                //路由拦截
                onGenerateRoute: (settings) => onGenerateRoute(settings),
                //路由导航失败时
                // onUnknownRoute:,
                //是否显示调试标
                debugShowCheckedModeBanner: !GlobalManager.isRelease,
              )
          )
      )
      ));


