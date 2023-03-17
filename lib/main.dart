import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/auth/splash_screen.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/exceptions/global_exception_handler.dart';
import 'package:myapp/core/router/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var exceptionHandler = GlobalExceptionHandler();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (err) => FlutterError.presentError(err);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    await Injector.loadDependencies();
    runApp(
      MyApp(),
    );
  }, exceptionHandler.onException);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppContext>(
      create: (_) => AppContext(),
      builder: (context, child) => Consumer<AppContext>(
        builder: (_, appContext, child) {
          return MaterialApp(
            navigatorKey: CustomRouter.navigatorKey,
            onGenerateRoute: CustomRouter.onRoute,
            home: SplashScreen(),
            title: 'HCN',
            theme: appContext.isDarkTheme
                ? ThemeData.dark()
                : ThemeData(fontFamily: 'Nunito'),
            // home: HCNLoginPage(title: 'HealthcareNow'),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
