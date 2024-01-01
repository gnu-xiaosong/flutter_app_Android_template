/*
 * @Author: xskj
 * @Date: 2023-12-30 18:54:06
 * @LastEditors: xskj
 * @LastEditTime: 2023-12-30 21:52:07
 * @Description: APP配置类
 */

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../common/ToolsManager.dart';

class AppConfig  extends ToolsManager{

  //获取App配置信息
  static Map<String,dynamic> appConfig = {
    "name": "测试App",
    "time": "xxxxx",
    "version": "v1.0",
    "author": "xxxx",
    "company?": "xxxxx",
    "address": "xxxxx",
    "email?": "xxxxx",
    "url": "xxxxxx",
    "descriptions?": "xxxxxxx",
    "license?": {
      "key": "mit",
      "name": "MIT License",
      "spdx_id": "MIT",
      "url": "https://api.github.com/licenses/mit",
      "node_id": "MDc6TGljZW5zZW1pdA=="
    }
  };

  //http类配置参数
  static final Map<String,dynamic> httpConfig = {
    "baseUrl": "https://api.jixs.cc", //基础URL
    "connectTimeout":  Duration(seconds: 30),//连接超时
    "receiveTimeout": Duration(seconds: 30),//接收超时
    "responseType":  ResponseType.plain,//相应类型
  };


  // dio缓存全局配置
  static final cacheOptions =  CacheOptions(
    // 缓存方式 A default store is required for interceptor.Volatile cache with LRU strategy.
    store: MemCacheStore(),
    // 默认缓存策略
    policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(days: 7), //7天
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );


  // dio日志打印拦截参数设置
  static PrettyDioLogger prettyDioLogger =PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90);
  // dio踪迹追踪插件
  static TalkerDioLogger talkerDioLogger = TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: true,
      printResponseMessage: true,
    ),
  );
  // dio重试配置插件
  static RetryInterceptor  getRetryInterceptor(Dio dio){
    return RetryInterceptor(
      dio: dio,
      logPrint: print, //指定日志功能 (optional)
      retries: 3, // 重试次数 (optional)
      retryDelays: const [ // 设置重试延迟间隔 (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    );
  }

  //  dio适配器设置
  static HttpClientAdapter get httpClientAdapter => Http2Adapter(
    ConnectionManager(
      idleTimeout: Duration(seconds: 10),
      onClientCreate: (_, config) =>{
        // config.proxy = Uri.parse('http://login:password@192.168.0.1:8888'),
        config.onBadCertificate = (_) => true
      },
    ),
  );


}