import 'package:domain_package/enums/api.dart';
import 'package:domain_package/enums/environment.dart';


abstract class AppConfiguration {
  late Environment env;
  Map<AppURLsType, String> get appURLs;
}
