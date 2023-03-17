import 'package:myapp/core/core_models/user_model/user.model.dart';

abstract class IUserService {
  Future<UserModel?> getContextUserDetails();
}
