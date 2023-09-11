import 'package:data_package/local/local_storage.dart';
import 'package:data_package/remote/api_controller.dart';
import 'package:domain_package/entities/joke/joke_response.dart';
import 'package:domain_package/extensions/string_extension.dart';
import 'package:domain_package/repositories/joke_list_repository.dart';
import 'package:hive/hive.dart';

class JokeListRepositoryImpl implements JokeListRepository {
  final ApiController _baseAPI;
  final LocalStorage _localStorage;

  JokeListRepositoryImpl(this._baseAPI, this._localStorage);

  @override
  Future<Stream<Future<List<String>>>> stream() async {
    final Stream<BoxEvent> stream = await _localStorage.stream();
    final Stream<Future<List<String>>> streamMapper = stream.map((event) async {
      final jokeList = await _fetchJokeListFromDataBase();
      return jokeList;
    });
    return streamMapper;
  }

  @override
  Future<List<String>> retrieveJokes() async {
    _retrieveJokesFromApi();
    return await _fetchJokeListFromDataBase();
  }

  void _retrieveJokesFromApi() async {
    final apiResponse = await _baseAPI.get<JokeListResponse>('api', queryParams: {'format': 'json'});
    if (apiResponse.isSuccess) {
      final joke = apiResponse.data?.joke;
      if (joke.isNullEmptyOrWhitespace == false) {
        final jokes = await _localStorage.getJokes();
        /// max number of jokes to keep in memory
        if (jokes.length == 10) {
          await _localStorage.removeJoke();
        }
        await _localStorage.addJoke(joke!);
      }
    }
  }

  Future<List<String>> _fetchJokeListFromDataBase() async {
    return _localStorage.getJokes();
  }
}