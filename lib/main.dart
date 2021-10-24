import 'package:fake_server/config/config.dart';
import 'package:fake_server/routes/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.instance.initializes();
  NavigatorUtils.defineRoutes(Routes.routes);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: AppConfig.instance.navigatorKey,
      navigatorObservers: <NavigatorObserver>[
        NavigatorUtils.routeObserver,
      ],
      initialRoute: Routes.index,
      onGenerateRoute: NavigatorUtils.onGenerateRoute,
      theme: ThemeData(),
      builder: EasyLoading.init(
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
      ),
    );
  }
}
