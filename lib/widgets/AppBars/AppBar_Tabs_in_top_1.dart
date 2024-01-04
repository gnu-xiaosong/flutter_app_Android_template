/*
* @Author: xskj
* @Date: 2024-01-02 10:26:13
* @LastEditors: xskj
* @LastEditTime: 2024-01-02 10:35:29
* @Description: Tab 在頂部的AppBar
*/
import 'package:flutter/material.dart';
List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

class AppBarTabsInTop_1 extends StatelessWidget {
  const AppBarTabsInTop_1({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: const Text('AppBar Sample'),
          // This check specifies which nested Scrollable's scroll notification
          // should be listened to.
          //
          // When `ThemeData.useMaterial3` is true and scroll view has
          // scrolled underneath the app bar, this updates the app bar
          // background color and elevation.
          //
          // This sets `notification.depth == 1` to listen to the scroll
          // notification from the nested `ListView.builder`.
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,

        );
  }
}
