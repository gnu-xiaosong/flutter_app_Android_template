import 'dart:ffi';

import 'package:app_template/widgets/drawers/MyDrawer.dart';
import 'package:app_template/widgets/dropdowns/DropdownButton1.dart';
import 'package:app_template/widgets/tabViews/TabView1.dart';
import 'package:flutter/material.dart';

import '../../config/AppConfig.dart';
import '../../widgets/tabViews/TabView2.dart';
import '../../widgets/tabViews/TabView3.dart';
import '../../widgets/tabViews/TabView4.dart';

//---------------顶部tabs配置------------------
List TopTabs = <Map>[
  {
    "tab": Tab(
      //tab Widget
      //icon: const Icon(Icons.cloud_outlined),
      text: "tab1", //tab名称
    ),
    "tabView": TabView1(),
  },
  {
    "tab": Tab(
      //tab Widget
      //icon: const Icon(Icons.cloud_outlined),
      text: "tab2", //tab名称
    ),
    "tabView": TabView2()
  },
  {
    "tab": Tab(
      //tab Widget
      // icon: const Icon(Icons.cloud_outlined),
      text: "tab3", //tab名称
    ),
    "tabView": TabView3()
  },
  {
    "tab": Tab(
      //tab Widget
      // icon: const Icon(Icons.cloud_outlined),
      text: "tab4", //tab名称
    ),
    "tabView": TabView4()
  },
];

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 1,  //初始化tab index
      length: TopTabs.length,
      child: Scaffold(
        appBar: AppBar(
          // 设置背景色
          backgroundColor: Colors.grey,
          // 设置 icon 主题
          iconTheme: IconThemeData(
            // 颜色
            color: Colors.blue,
            // 不透明度
            opacity: 0.5,
          ),
          // 标题居中
          //centerTitle: true,
          // 标题左右间距为
          leadingWidth: 50,
          //标题间隔
          titleSpacing: 1,
          //左边
          leading: IconButton(
              iconSize: 35,
              icon: const Icon(Icons.account_circle_rounded),
              onPressed: () {
                print("open drawer");
                Scaffold.of(context).openDrawer();
              }),
          //标题--双标题
          title: Column(children: [
            Text(
              AppConfig.appConfig['name'],
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "我是小标题",
              style: const TextStyle(fontSize: 10),
            ),
          ]),
          //action（操作）
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton1(),
            )
          ],
          // 自定义图标样式
          actionsIconTheme: IconThemeData(
            color: Colors.blue,
          ),
          shadowColor: Theme.of(context).shadowColor,
          //灵活区域
          flexibleSpace: SizedBox(
            width: double.infinity, //无限
            height: 160,
            child: Image.network(
              "https://ts1.cn.mm.bing.net/th/id/R-C.d4822697ad0424efafe6b62e5e6e0d1d?rik=ZdcMlu%2f2ng6ltA&riu=http%3a%2f%2fimg95.699pic.com%2fphoto%2f40141%2f5356.gif_wh860.gif&ehk=OMCk8kp7dU8UKPdcHORkcrjitRqABE0xoh7sa%2baGN4k%3d&risl=1&pid=ImgRaw&r=0",
              fit: BoxFit.cover,
            ),
          ),
          //底部部分
          bottom: TabBar(tabs: <Widget>[for (var item in TopTabs) item['tab']]),
        ),
        body: TabBarView(
          children: <Widget>[for (var item in TopTabs) item['tabView']],
        ),
        //抽屉
        drawer: const MyDrawer(),
      ),
    );
  }
}
