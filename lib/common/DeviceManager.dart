/*
 * @Author: xskj
 * @Date: 2023-12-29 13:25:12
 * @LastEditors: xskj
 * @LastEditTime: 2023-12-29 13:40:14
 * @Description: 设备管理器工具类
 */
import 'package:device_info_plus/device_info_plus.dart';


class DeviceManager  {




  //获取设备版本等信息
  Future<Map> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    return allInfo;
  }
}