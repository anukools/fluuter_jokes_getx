import 'package:data_package/utils/data_utils.dart';
import 'package:domain_package/enums/environment.dart';
import 'package:domain_package/src/domain_layer.dart';

final domainUtils = DomainUtils._instance;
class DomainUtils {
  DomainUtils._privateConstructor();
  static final DomainUtils _instance = DomainUtils._privateConstructor();

  Future<String> get packageName async => await dataUtils.packageName;

  Future<String> get appVersionName async => await dataUtils.appVersionName;

  Future<String> get appVersionCode async => await dataUtils.appVersionCode;

  Environment get appEnv => injector.get<Environment>();
}