import 'package:app_template/states/DarkState.dart';
import 'package:app_template/states/DescState.dart';
import 'package:app_template/states/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
        child: RefreshConfiguration(
            //----------------- 下拉刷新全局配置-------------------
            // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
            headerBuilder: () => const WaterDropHeader(),
            // 配置默认底部指示器
            footerBuilder: () => const ClassicFooter(),
            // 头部触发刷新的越界距离
            headerTriggerDistance: 80.0,
            // 自定义回弹动画,三个属性值意义请查询flutter api
            springDescription:
                const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
            //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
            maxOverScrollExtent: 100,
            // 底部最大可以拖动的范围
            maxUnderScrollExtent: 0,
            //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
            enableScrollWhenRefreshCompleted: true,
            //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
            enableLoadingWhenFailed: true,
            // Viewport不满一屏时,禁用上拉加载更多功能
            hideFooterWhenNotFull: false,
            // 可以通过惯性滑动触发加载更多
            enableBallisticLoad: true,
            child: const MaterialApplication()));
  }
}

class MaterialApplication extends StatefulWidget {
  const MaterialApplication({super.key});
  @override
  State<MaterialApplication> createState() => _MaterialApplicationState();
}

class _MaterialApplicationState extends State<MaterialApplication> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<DescState, ThemeState, DarkState>(
        builder: (BuildContext context, desc, themeState, darkState, child) =>
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
            ));
  }
}
