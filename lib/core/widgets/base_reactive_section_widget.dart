import 'package:jokes_app/core/controllers/base_controller.dart';
import 'package:jokes_app/core/widgets/base_section_widget.dart';

abstract class BaseReactiveSectionWidget<T extends BaseController> extends BaseSectionWidget {
  final T controller;
  const BaseReactiveSectionWidget({required super.widgetKey, required super.params, required this.controller}): super();
}