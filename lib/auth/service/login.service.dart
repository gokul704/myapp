import 'package:dio/dio.dart';
import 'package:myapp/auth/service/Ilogin.service.dart';
import 'package:myapp/configuration/app_config.model.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/core_models/token/token.model.dart';
import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/network/http_service.dart';
import 'package:myapp/core/services/token/itoken.service.dart';
import 'package:myapp/keys/app_keys.dart';

class LoginService implements ILoginService {
  HttpService httpService;
  ITokenService tokenService;
  LoginService(this.httpService, this.tokenService);
  @override
  Future<bool> loginWithCredentials(String userName, String password) async {
    var form = {
      'email': userName,
      'password': password,
    };

    this.httpService.setContentType(Headers.formUrlEncodedContentType);
    this.httpService.setInterceptorStatus(false);

    var tokenResponse =
        await this.httpService.post(LoginApiKeys.basicLoginApi, form);
    if (tokenResponse != null) {
      this._saveToken(tokenResponse);
      return true;
    }

    return false;
  }

  @override
  Future<bool> logout() async {
    await this.tokenService.clearToken();
    return true;
  }

  void _saveToken(Map<String, dynamic> tokenResponse) {
    // Do post login steps, like Building context, Saving token
    var token = Token.fromJson(tokenResponse);
    this.tokenService.saveAccessToken(token);
    var appContext = Injector.get<AppContext>();
    appContext.setToken(token);
  }

  @override
  Future<bool> loginWithExpiredAccessToken() async {
    var appContext = Injector.get<AppContext>();
    var appConfig = Injector.get<AppConfiguration>();
    var payload = {};

    this.httpService.setContentType(Headers.formUrlEncodedContentType);
    this.httpService.setInterceptorStatus(false);

    var tokenResponse =
        await this.httpService.post(LoginApiKeys.basicLoginApi, payload);
    if (tokenResponse != null) {
      this._saveToken(tokenResponse);
      return true;
    }

    return false;
  }
}
