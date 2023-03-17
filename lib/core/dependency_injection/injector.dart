import 'package:get_it/get_it.dart';
import 'package:myapp/auth/service/Ilogin.service.dart';
import 'package:myapp/auth/service/login.service.dart';
import 'package:myapp/auth/service/user/iuser.service.dart';
import 'package:myapp/auth/service/user/user.service.dart';
import 'package:myapp/configuration/app_config.model.dart';
import 'package:myapp/core/Notifications/notification.service.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/dialogs/overloay_loader.dart';
import 'package:myapp/core/network/http_service.dart';
import 'package:myapp/core/services/context.service.dart';
import 'package:myapp/core/services/token/itoken.service.dart';
import 'package:myapp/core/services/token/token.service.dart';
import 'package:myapp/core/storage/local_storage.dart';

class Injector {
  static final GetIt injector = GetIt.instance;
  static Future<void> loadDependencies() async {
    await loadSingletons();
    loadFactories();
  }

  static Future<void> loadFactories() async {
    injector.registerFactory<HttpService>(() => HttpService());
    injector.registerFactory<ITokenService>(
        () => TokenService(injector<HttpService>(), injector<LocalStorage>()));

    injector.registerFactory<ILoginService>(
        () => LoginService(injector<HttpService>(), injector<ITokenService>()));
    injector.registerFactory<IUserService>(
        () => UserService(httpService: HttpService()));
    injector.registerFactory<NotificationService>(() => NotificationService());
    injector.registerFactory<ContextService>(() => ContextService(
          httpService: get<HttpService>(),
          userService: get<IUserService>(),
        ));
  }

  static Future<void> loadSingletons() async {
    var appConfig = AppConfiguration();
    await appConfig.initConfiguration();
    injector.registerSingleton<AppConfiguration>(appConfig);

    injector.registerSingleton<LocalStorage>(LocalStorage());
    injector.registerSingleton<AppContext>(AppContext());
    injector.registerSingleton<OverlayLoader>(OverlayLoader());
  }

  static T get<T extends Object>({String? instanceName}) {
    return injector.get<T>(instanceName: instanceName);
  }
}
