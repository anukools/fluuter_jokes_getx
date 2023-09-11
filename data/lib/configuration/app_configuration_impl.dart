// ignore_for_file: constant_identifier_names

import 'package:domain_package/enums/api.dart';
import 'package:domain_package/configuration/app_configuration.dart';
import 'package:domain_package/enums/environment.dart';

class AppConfigurationImpl implements AppConfiguration {
  @override
  late Environment env;

  AppConfigurationImpl({required Environment appEnv}) {
    env = appEnv;
  }

  @override
  Map<AppURLsType, String> get appURLs => env.appURLs;
}

extension EnvironmentExtension on Environment {
  Map<AppURLsType, String> get appURLs {
    switch (this) {
      case Environment.Dev:
        return {
          AppURLsType.main: 'https://geek-jokes.sameerkumar.website',
        };
      case Environment.Prod:
        return {
          AppURLsType.main: 'https://geek-jokes.sameerkumar.website',
        };
    }
  }
}