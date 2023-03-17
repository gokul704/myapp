import 'package:flutter/widgets.dart';

import 'package:myapp/auth/service/Ilogin.service.dart';
import 'package:myapp/auth/service/user/iuser.service.dart';
import 'package:myapp/core/Notifications/notification.service.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/exceptions/exceptions.dart';

class LoginState extends ChangeNotifier {
  bool isLoading = false;
  late ILoginService loginService;
  late IUserService userService;

  LoginState() {
    this.loginService = Injector.get<ILoginService>();
    // this.userService = Injector.get<IUserService>();
  }

  Future<bool> login(String username, String password) async {
    this.isLoading = true;
    notifyListeners();
    bool loginStatus = false;
    try {
      loginStatus =
          await this.loginService.loginWithCredentials(username, password);
      this.isLoading = false;
    } on Exception catch (e) {
      this.isLoading = false;
      notifyListeners();

      var appContext = Injector.get<AppContext>();
      var notificationService = Injector.get<NotificationService>();
      appContext.clearAppContext();
      await this.loginService.logout();
      if (e is UnAuthorizedException ||
          e is BadRequestException &&
              e.errorDescription == "Invalid user credentials") {
        notificationService.showError('Invalid Credentials',
            'The user credentials are invalid, please verify them and login');
        return false;
      } else {
        notificationService.showError(
            'Error', 'something went wrong please try again');
        return false;
      }

      // The cases which are unhandled in this page will be handled by the global exception handler.
    }

    return loginStatus;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Username  cannot be empty';
    }
    // else if (!email.isValidEmail()) {
    //   return 'Invalid email address';
    // }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  Future<bool> fetchUserDetails() async {
    var userDetails = await this.userService.getContextUserDetails();

    if (userDetails == null) throw UserNotFoundException();

    var appContext = Injector.get<AppContext>();
    appContext.userDetail = userDetails;
    return true;
  }
}
