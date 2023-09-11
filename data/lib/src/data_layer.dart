import 'package:data_package/configuration/app_configuration_impl.dart';
import 'package:data_package/local/local_storage.dart';
import 'package:data_package/remote/api_controller.dart';
import 'package:data_package/repositories/joke_list_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain_package/configuration/app_configuration.dart';
import 'package:domain_package/enums/environment.dart';
import 'package:domain_package/repositories/joke_list_repository.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;
class DataLayer {
  static Future<void> initializeDependencies(Environment env) async {
    injector.registerLazySingleton<AppConfiguration>(() => AppConfigurationImpl(appEnv: env));

    injector.registerLazySingleton<Dio>(() => Dio());

    LocalStorage localStorage = LocalStorageImpl();
    await localStorage.initialize();
    injector.registerLazySingleton<LocalStorage>(() => localStorage);

    injector.registerLazySingleton<ApiController>(() => ApiController(apiClient: injector(), appConfiguration: injector()));

    injector.registerLazySingleton<JokeListRepository>(() => JokeListRepositoryImpl(injector(), injector()));
  }
}