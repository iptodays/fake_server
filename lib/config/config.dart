/*
 * @Author: iptoday 
 * @Date: 2021-10-24 21:45:25 
 * @Last Modified by: iptoday
 * @Last Modified time: 2021-10-24 22:05:14
 */
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sp_util/sp_util.dart';

class AppConfig {
  AppConfig._();

  static AppConfig get instance => _instance;
  static late final AppConfig _instance = AppConfig._();

  /// 导航key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  late final GlobalKey<NavigatorState> _navigatorKey;

  /// 设备信息
  AndroidDeviceInfo? get android => _android;
  late final AndroidDeviceInfo? _android;
  IosDeviceInfo? get ios => _ios;
  late final IosDeviceInfo? _ios;
  MacOsDeviceInfo? get macos => _macos;
  late final MacOsDeviceInfo? _macos;
  WindowsDeviceInfo? get windows => _windows;
  late final WindowsDeviceInfo? _windows;
  LinuxDeviceInfo? get linux => _linux;
  late final LinuxDeviceInfo? _linux;

  /// 应用信息
  PackageInfo get package => _package;
  late final PackageInfo _package;

  /// 打开app的时间/Milliseconds
  late final int _openAppMs;

  /// 初始化
  Future<void> initializes() async {
    LogUtil.init(isDebug: kDebugMode);
    _navigatorKey = GlobalKey<NavigatorState>();
    _openAppMs = DateUtil.getNowDateMs();
    LogUtil.v('打开App时间: $_openAppMs');
    if (!SpUtil.isInitialized()) {
      await SpUtil.getInstance();
    }

    if (Platform.isIOS) {
      _ios = await DeviceInfoPlugin().iosInfo;
    } else if (Platform.isAndroid) {
      _android = await DeviceInfoPlugin().androidInfo;
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      );
    } else if (Platform.isMacOS) {
      _macos = await DeviceInfoPlugin().macOsInfo;
    } else if (Platform.isWindows) {
      _windows = await DeviceInfoPlugin().windowsInfo;
    } else if (Platform.isLinux) {
      _linux = await DeviceInfoPlugin().linuxInfo;
    }
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: <SystemUiOverlay>[],
    );
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    _package = await PackageInfo.fromPlatform();
  }
}
