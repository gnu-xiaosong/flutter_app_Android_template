import 'package:app_template/states/DarkState.dart';
import 'package:app_template/states/DescState.dart';
import 'package:app_template/states/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//路由
import './routes/index.dart';
//全局变量
import 'common/GlobalManager.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => GlobalManager.init().then((e) async {
      await EasyLocalization.ensureInitialized();
      runApp(
        EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
            path:
                'assets/translations', // <-- change the path of the translation files
            child: const App()),
      );
    });

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    print("----------------Locale---------");
    print(context.locale);
    return MultiProvider(
        providers: [
          //全局配置共享状态
          ChangeNotifierProvider<DescState>(create: (_) => DescState()),
          //全局主题共享状态
          ChangeNotifierProvider<ThemeState>(create: (_) => ThemeState()),
          //全局暗夜模式
          ChangeNotifierProvider<DarkState>(create: (_) => DarkState())
        ],
        child: Consumer3<DescState, ThemeState, DarkState>(
            builder:
                (BuildContext context, desc, themeState, darkState, child) =>
                    MaterialApp(
                      //国际化支持
                      localizationsDelegates: context.localizationDelegates,
                      supportedLocales: context.supportedLocales,
                      locale: context.locale,
                      //标题：名称
                      title: desc.app.name.tr(),
                      //主题: 使用插件-插件配色地址：https://rydmike.com/flexcolorscheme/themesplayground-v7-2/#/
                      //---------------------主题配色-------------------------
                      theme: darkState.mode
                          ? ThemeData(brightness: Brightness.dark)
                          : themeState.theme['light'],
                      darkTheme: themeState.theme['dark'],
                      //跟随系统
                      // themeMode: ThemeMode.system,
                      //生成tile时
                      onGenerateTitle: (context) {
                        return desc.app.name.tr();
                      },
                      //颜色:默认跟随用户设置
                      //color: themeState.theme,
                      //路由
                      initialRoute:
                          routes.keys.first.toString(), //名为"/"的路由作为应用的home(首页)
                      routes: routes, //路由表
                      //路由拦截
                      onGenerateRoute: (settings) => onGenerateRoute(settings),
                      //路由导航失败时
                      // onUnknownRoute:,
                      //是否显示调试标
                      debugShowCheckedModeBanner: !GlobalManager.isRelease,
                    )));
  }
}
