import 'package:domain_package/usecase_extension.dart';
import 'package:get/get.dart';

class BaseController extends GetxController with UseCaseExtension {
  void onResume() {}

  void onPause() {}
}