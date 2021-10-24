import 'package:common_utils/common_utils.dart';
import 'package:fake_server/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'routes.dart';

enum NavigatorTransition {
  push,
  present,
}

class NavigatorUtils {
  NavigatorUtils._();

  /// 记录路由
  static List<String> routers = <String>[
    '/',
  ];

  /// 用于路由返回监听
  static final RouteObserver<PageRoute<dynamic>> routeObserver =
      RouteObserver<PageRoute<dynamic>>();

  static const String kTransitionKey = '_transition';

  static Map<String, Widget Function(BuildContext, Map<String, dynamic>)>
      routes = <String, Widget Function(BuildContext, Map<String, dynamic>)>{};

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic> arguments = <String, dynamic>{};
    if (settings.arguments != null && settings.arguments is Map) {
      arguments = settings.arguments! as Map<String, dynamic>;
    }
    assert(
      routes.containsKey(settings.name),
      'Route ${settings.name} is not define',
    );

    if (!arguments.containsKey(kTransitionKey)) {
      arguments[kTransitionKey] = NavigatorTransition.push;
    }

    final NavigatorTransition transition =
        arguments[kTransitionKey] as NavigatorTransition;

    switch (transition) {
      case NavigatorTransition.present:
        return CupertinoPageRoute<Widget>(
          builder: (BuildContext context) {
            return routes[settings.name]!(context, arguments);
          },
          fullscreenDialog: true,
          settings: settings,
        );
      default:
        return CupertinoPageRoute<Widget>(
          builder: (BuildContext context) {
            return routes[settings.name]!(context, arguments);
          },
          settings: settings,
        );
    }
  }

  static void defineRoutes(
    Map<String, Widget Function(BuildContext, Map<String, dynamic>)> newRoutes,
  ) {
    newRoutes.forEach(
      (String k, Widget Function(BuildContext, Map<String, dynamic>) v) {
        routes[k] = v;
      },
    );
  }

  /// 跳转
  static Future<dynamic> push(
    BuildContext context,
    String path, {
    Map<String, dynamic>? arguments,
    bool replace = false,
    bool clearStack = false,
    NavigatorTransition transition = NavigatorTransition.push,
    Duration duration = const Duration(milliseconds: 250),
  }) {
    if (replace) {
      // AppConfig.instance.analytics.setCurrentScreen(
      //   screenName: routers.last,
      // );
      routers.removeLast();
    }
    routers.add(path);
    LogUtil.d(
      path,
      tag: 'PUSH',
    );

    FocusScope.of(context).requestFocus(FocusNode());
    arguments ??= <String, dynamic>{};
    final List<String> parseUrl = path.split('?');
    path = parseUrl.first;
    if (parseUrl.length > 1) {
      parseUrl.last.split('&').forEach((String item) {
        final List<String> kv = item.split('=');
        arguments![kv.first] = kv.last;
      });
    }

    arguments[kTransitionKey] = transition;
    Future<dynamic> result;
    if (clearStack) {
      result = Navigator.pushNamedAndRemoveUntil(
        context,
        path,
        (Route<dynamic> check) => false,
        arguments: arguments,
      );
    } else {
      result = replace
          ? Navigator.pushReplacementNamed(
              context,
              path,
              arguments: arguments,
            )
          : Navigator.pushNamed(
              context,
              path,
              arguments: arguments,
            );
    }
    return result;
  }

  /// 返回
  ///
  /// * [router] 返回到指定页面
  /// * [result] 返回上一级携带的参数
  /// * [gestures] 手势返回
  static Future<void> pop(
    BuildContext context, {
    String? router,
    dynamic result,
    bool gestures = false,
  }) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (gestures) {
      LogUtil.d(
        routers.last,
        tag: 'POP',
      );
      routers.removeLast();
      return;
    }
    if (ObjectUtil.isNotEmpty(router)) {
      Navigator.popUntil(context, ModalRoute.withName(router!));
    } else {
      Navigator.maybePop(context, result);
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}
