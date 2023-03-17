import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/Notifications/notification.service.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/exceptions/exceptions.dart';
import 'package:myapp/core/router/router.dart';
import 'package:myapp/core/services/token/itoken.service.dart';
import 'package:myapp/core/shared/error-pages/error_page.dart';

class GlobalExceptionHandler {
  void onException(err, trace) {
    NotificationService notificationService =
        Injector.get<NotificationService>();

    if (err is DioError) {
      print("Http error broooo");
    } else if (err is NoInternetException) {
      notificationService.showError(
          'No Internet', 'Please make sure to connect to internet');
    } else if (err is ForbiddenException) {
      notificationService.showError(
          'Error!', 'You are not allowed to access this operation',
          onActionPressed: _navigateToLogin);
    } else if (err is BadRequestException) {
      notificationService.showError('Error!', err.message);
    } else if (err is ServerException) {
      notificationService.showError('Error', 'Something went wrong!!');
    } else if (err is TimedOutException) {
      _navigateToTimeoutPage();
    } else {
      print(err.toString());
    }
  }

  void _navigateToLogin() async {
    var tokenService = Injector.get<ITokenService>();
    var appContext = Injector.get<AppContext>();

    await tokenService.clearToken();
    appContext.clearAppContext();

    CustomRouter.navigatorKey.currentState!.popUntil((route) => false);
    CustomRouter.navigatorKey.currentState!.pushNamed('/login');
  }

  void _navigateToTimeoutPage() {
    CustomRouter.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => ErrorPage(
              title: 'Timeout',
              description: 'This is taking more time than expected',
              isButtonRequired: false,
              assetUrl: 'assets/svg/server_down.svg',
            ),
        fullscreenDialog: true));
  }
}
