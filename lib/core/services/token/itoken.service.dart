import 'package:myapp/core/core_models/token/token.model.dart';

abstract class ITokenService {
  Future<void> saveAccessToken(Token token);

  Future<Token?> getAccessToken();

  Future<void> clearToken();
}
