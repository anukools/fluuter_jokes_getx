import 'package:package_info_plus/package_info_plus.dart';

final dataUtils = DataUtils._instance;
class DataUtils {
  DataUtils._privateConstructor();
  static final DataUtils _instance = DataUtils._privateConstructor();

  Future<String> get packageName async => (await PackageInfo.fromPlatform()).packageName;

  Future<String> get appVersionName async => (await PackageInfo.fromPlatform()).version;

  Future<String> get appVersionCode async => (await PackageInfo.fromPlatform()).buildNumber;
}