import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/auth/authcheck.dart';
import 'package:myapp/auth/login/loginscreen.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/services/context.service.dart';
import 'package:myapp/core/services/token/itoken.service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<StatefulWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (3)),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // adding this in callback so that it renders smooth
      // This callback gets called after the build method completes its frame.
      _navigateToTargetPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.all(80),
            child: Container(
              margin: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  Expanded(
                      child: Lottie.asset(
                    'assets/splash_lottie.json',
                    controller: _controller,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 5,
                    animate: true,
                    onLoaded: (composition) => _controller
                      ..duration = composition.duration
                      ..repeat(),
                  )),
                  Expanded(
                      child: SizedBox(
                    width: 200,
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  )),
                  Expanded(
                    child: Lottie.asset(
                      'assets/beat.json',
                      controller: _controller,
                      height: MediaQuery.of(context).size.height * 0.2,
                      animate: true,
                      onLoaded: (composition) => _controller
                        ..duration = composition.duration
                        ..repeat(),
                    ),
                  )
                ],
              ),
            )));
  }

  void _navigateToTargetPage() async {
    if (await _checkForLoginSession()) {
      // Some login session is present, so get the user data.
      this._loadUserData();
    } else {
      // No session is present in the app, redirect the user to login page.
      // this._navigateToPage(HCNLoginPage(title: "HealthcareNow"));
      this._navigateToPage(LoginScreen());
    }
  }

  Future<bool> _checkForLoginSession() async {
    var tokenService = Injector.get<ITokenService>();
    var token = await tokenService.getAccessToken();
    var appContext = Injector.get<AppContext>();
    if (token != null) {
      appContext.setToken(token);
    }

    return token != null;
  }

  void _loadUserData() async {
    // Widget targetPage = LoginScreen();
    // var contextService = Injector.get<ContextService>();
    Widget targetPage = Container();
    var contextService = Injector.get<ContextService>();
    if (await contextService.loadData()) {
      targetPage = AuthCheck();
    }

    this._navigateToPage(targetPage);
  }

  void _navigateToPage(Widget targetPage) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => targetPage));
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }
}
