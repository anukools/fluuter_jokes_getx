import 'package:data_package/data_export.dart';
import 'package:domain_package/enums/environment.dart';
import 'package:domain_package/usecase/joke_list_use_case.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;
class DomainLayer {
  static Future<void> initializeDependencies(Environment environment) async {
    await DataLayer.initializeDependencies(environment);

    injector.registerLazySingleton<JokeListUseCase>(() => JokeListUseCase(injector()));
  }
}