abstract class ILoginService {
  Future<bool> loginWithCredentials(String userName, String password);

  Future<bool> loginWithExpiredAccessToken();

  Future<bool> logout();
}
