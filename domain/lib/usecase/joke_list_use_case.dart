import 'package:domain_package/entities/api/api.dart';
import 'package:domain_package/entities/joke/joke_response.dart';
import 'package:domain_package/repositories/joke_list_repository.dart';

class JokeListUseCase {
  final JokeListRepository _repository;
  JokeListUseCase(this._repository);

  Future<List<String>> retrieveJokes() => _repository.retrieveJokes();

  Future<Stream<Future<List<String>>>> stream() => _repository.stream();
}