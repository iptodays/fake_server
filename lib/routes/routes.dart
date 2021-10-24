/*
 * @Author: iptoday 
 * @Date: 2021-10-24 21:56:59 
 * @Last Modified by: iptoday
 * @Last Modified time: 2021-10-24 22:07:51
 */
import 'package:fake_server/pages/tabbar.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  /// 首页
  static String index = '/';

  static Map<String, Widget Function(BuildContext, Map<String, dynamic>)>
      get routes {
    return <String, Widget Function(BuildContext, Map<String, dynamic>)>{
      index: (BuildContext context, Map<String, dynamic> arguments) {
        return const TabBarPage();
      },
    };
  }
}
