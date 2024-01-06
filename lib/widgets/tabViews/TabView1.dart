/*
 * @Author: xskj
 * @Date: 2023-12-29 16:19:41
 * @LastEditors: xskj
 * @LastEditTime: 2023-12-30 12:42:13
 * @Description: home页 topTab切换标签tabview
 */

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

//主页面组件
Widget Index() {
  //微光效果
  return Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      child: Center(child: Text("tabview 1")));
}

//刷新控制器获取控制器
RefreshController _refreshController = RefreshController(initialRefresh: false);
void _onRefresh() async {
  // monitor network fetch
  await Future.delayed(const Duration(milliseconds: 1000));
  // if failed,use refreshFailed()
  _refreshController.refreshCompleted();
}

void _onLoading() async {
  // monitor network fetch
  await Future.delayed(const Duration(milliseconds: 1000));
  // if failed,use loadFailed(),if no data return,use LoadNodata()
  // items.add((items.length + 1).toString());
  // if (mounted) setState(() {});
  _refreshController.loadComplete();
}

class TabView1 extends StatefulWidget {
  const TabView1({super.key});

  @override
  State<TabView1> createState() => _TabView1State();
}

class _TabView1State extends State<TabView1> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Index());
  }
}
