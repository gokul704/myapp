import 'package:flutter/material.dart';
import 'package:myapp/views/home/home.dart';

class CustomRouter {
  // Used as a Global Navigator context key.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;

  static Route<dynamic> onRoute(RouteSettings settings) {
    late Widget target;
    switch (settings.name!.trim()) {
      case '/splash':
        // target = SplashScreen();
        break;
      case '/login':
        // target = LoginScreen();
        break;
      case '/dashboard':
        target = const HomePage();
        break;
    }

    return MaterialPageRoute(builder: (_) => target);
  }
}
