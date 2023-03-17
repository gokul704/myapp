import 'package:myapp/auth/service/user/iuser.service.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/core_models/user_model/user.model.dart';
import 'package:myapp/core/dependency_injection/injector.dart';
import 'package:myapp/core/network/http_service.dart';

/// Service to make initial API calls for fetching required initial app data.
/// Just call the [loadData] method and it will fetch the data.
class ContextService {
  IUserService userService;
  HttpService httpService;
  ContextService({
    required this.userService,
    required this.httpService,
  });

  var appContext = Injector.get<AppContext>();

  Future<bool> loadData() async {
    var result = await Future.wait([
      userService.getContextUserDetails(),
      // Injector.get<IdoctorAvailabilityService>().getDoctorAvailability()
    ]);

    if (result.isNotEmpty) {
      //Storing the API data in cache map to use across application.
      appContext.userDetail = result[0] as UserModel;
      return true;
    }

    return false;
  }
}
