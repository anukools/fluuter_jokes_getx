import 'package:jokes_app/core/controllers/base_controller.dart';
import 'package:jokes_app/core/widgets/base_screen_widget.dart';

abstract class BaseReactiveScreenWidget<T extends BaseController> extends BaseScreenWidget {
  final T controller;
  BaseReactiveScreenWidget({required super.widgetKey, required super.params, required this.controller}): super();

  @override
  void onResume() => controller.onResume();

  @override
  void onPause() => controller.onPause();
}