import 'package:myapp/auth/service/user/iuser.service.dart';
import 'package:myapp/core/core_models/user_model/user.model.dart';
import 'package:myapp/core/network/http_service.dart';
import 'package:myapp/keys/app_keys.dart';

class UserService implements IUserService {
  HttpService httpService;
  UserService({required this.httpService});

  @override
  Future<UserModel?> getContextUserDetails() async {
    var response = await this.httpService.post(UserApiKeys.profile, {});

    return response != null ? UserModel.fromJson(response) : null;
  }
}
