import 'package:domain_package/entities/api/api.dart';
import 'package:domain_package/entities/joke/joke_response.dart';

abstract class JokeListRepository {
  Future<List<String>> retrieveJokes();
  Future<Stream<Future<List<String>>>> stream();
}