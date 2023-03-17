import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth/service/Ilogin.service.dart';

import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/exceptions/exceptions.dart';
import 'package:myapp/core/router/router.dart';
import 'package:myapp/core/shared/error-pages/error_page.dart';

import '../../keys/app_keys.dart';
import '../Notifications/notification.service.dart';

class HttpInterceptor extends QueuedInterceptor {
  CancelToken token;
  static late HttpInterceptor _interceptor = HttpInterceptor._();

  factory HttpInterceptor.getInstance() {
    return _interceptor;
  }

  /// Maintaining the constructor private and the interceptor is singleton.
  HttpInterceptor._() : this.token = CancelToken();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    options.cancelToken = this.token;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is List) {
      response.data = (response.data as List)
          .map((d) => d as Map<String, dynamic>)
          .toList();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    var notificationService = Injector.get<NotificationService>();

    if (err.type == DioErrorType.cancel ||
        (err.requestOptions.cancelToken?.isCancelled ?? false)) {
      // For concurrent requests made, we just ignore the response.
      print('Ignoring interceptor for ${err.requestOptions.path}');
      return;
    }

    switch (err.response!.statusCode) {
      case 401:
        // UnAuthorized case
        if (err.requestOptions.path == LoginApiKeys.basicLoginApi) {
          // Occurs when refresh token also got expired, so sending the user to login page to login.
          notificationService.showError('Error', 'Session Expired !!',
              onActionPressed: _navigateToLogin);
        } else {
          this.token.cancel();
          this.token = CancelToken();

          // Refresh the access token with refresh token
          handler.reject(err);

          if (await this._getNewAccessToken()) {
            _navigateToSplashScreen();
          }

          return;
        }
        break;
    }

    super.onError(err, handler);
    return;
  }

  void _navigateToLogin() {
    CustomRouter.navigatorKey.currentState!.popUntil((route) => false);
    CustomRouter.navigatorKey.currentState!.pushNamed('/login');
  }

  void _navigateToSplashScreen() {
    CustomRouter.navigatorKey.currentState!.popUntil((route) => false);
    CustomRouter.navigatorKey.currentState!.pushNamed('/splash');
  }

  Future<bool> _getNewAccessToken() async {
    var loginService = Injector.get<ILoginService>();

    try {
      if (await loginService.loginWithExpiredAccessToken()) {
        return true;
      }
    } on BadRequestException {
      CustomRouter.navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (_) => ErrorPage.sessionExpired(
                onClose: _navigateToLogin,
                onButtonPressed: _navigateToLogin,
                buttonTitle: 'Retry Login',
              ),
          fullscreenDialog: true));
    }

    return false;
  }
}
