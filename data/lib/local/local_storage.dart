import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalStorage {
  static const _storageName = 'joke-storage';
  static const _jokeTableName = 'joke-table';

  Future<void> initialize();

  Future<int> addJoke(String joke);

  Future<void> removeJoke();

  Future<List<String>> getJokes();

  Future<Stream<BoxEvent>> stream();

  void close();
}

class LocalStorageImpl implements LocalStorage {
  late BoxCollection _storage;

  @override
  Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    _storage = await BoxCollection.open(LocalStorage._storageName, {LocalStorage._jokeTableName}, path: appDir.path);

    return Future.value();
  }

  @override
  Future<int> addJoke(String joke) async {
    final jokeBox = await Hive.openBox(LocalStorage._jokeTableName);
    final returnValue = await jokeBox.add(joke);
    return Future.value(returnValue);
  }

  @override
  Future<void> removeJoke() async {
    final jokeBox = await Hive.openBox(LocalStorage._jokeTableName);
    await jokeBox.deleteAt(0);
    return Future.value();
  }

  @override
  Future<List<String>> getJokes() async {
    final jokeBox = await Hive.openBox(LocalStorage._jokeTableName);
    final jokeList =  jokeBox.values.toList().map((e) => e as String).toList();
    final returnValue = jokeList.reversed.toList();
    return Future.value(returnValue);
  }

  @override
  Future<Stream<BoxEvent>> stream() async {
    final jokeBox = await Hive.openBox(LocalStorage._jokeTableName);
    final stream = jokeBox.watch();
    return Future.value(stream);
  }

  @override
  void close() => _storage.close();
}
