import 'package:domain_package/src/domain_layer.dart';
import 'package:domain_package/usecase/joke_list_use_case.dart';

mixin UseCaseExtension {
  JokeListUseCase get jokeListUseCase {
    return injector<JokeListUseCase>();
  }
}