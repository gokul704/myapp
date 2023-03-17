import 'package:flutter/foundation.dart';
import 'package:myapp/core/core_models/token/token.model.dart';
import 'package:myapp/core/core_models/user_model/user.model.dart';

class AppContext with ChangeNotifier {
  Token? token;
  String? tenantName;
  bool isDarkTheme = false;
  UserModel? userDetail;

  AppContext();

  void setToken(Token token) {
    this.token = token;
  }

  void clearAppContext() {
    this.token = null;
    this.tenantName = null;
  }

  void setDarkMode(bool darkMode) {
    this.isDarkTheme = darkMode;
    notifyListeners();
  }

  void setName(String name) {
    print(name);
    this.tenantName = name;
  }
}

enum CacheKey { doctors, states }
