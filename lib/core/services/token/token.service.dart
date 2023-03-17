import 'dart:convert';

import 'package:myapp/core/core_models/token/token.model.dart';
import 'package:myapp/core/network/http_service.dart';
import 'package:myapp/core/services/token/itoken.service.dart';
import 'package:myapp/core/storage/local_storage.dart';

class TokenService implements ITokenService {
  final LocalStorage localStorage;
  final HttpService httpService;

  TokenService(this.httpService, this.localStorage);

  @override
  Future<Token?> getAccessToken() async {
    var accessToken = await this.localStorage.getValue('userToken');

    return accessToken != null ? Token.fromJson(jsonDecode(accessToken)) : null;
    // return Token(accessToken: '');
  }

  @override
  Future<void> saveAccessToken(Token token) {
    return this.localStorage.setValue('userToken', jsonEncode(token.toMap()));
  }

  @override
  Future<void> clearToken() {
    return this.localStorage.removeValue('userToken');
  }
}
