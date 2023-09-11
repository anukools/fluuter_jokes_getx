import 'package:flutter/material.dart';
import 'package:jokes_app/core/extensions/core_ui_extension.dart';
import 'package:jokes_app/core/utils/app_constants.dart';
import 'package:jokes_app/core/utils/visibility_tracker.dart';

abstract class BaseSectionWidget extends StatelessWidget {
  final Key widgetKey;
  final Map<String, dynamic> params;

  const BaseSectionWidget({required this.widgetKey, required this.params}) : super(key: widgetKey);

  bool get enableVisibilityTracking => false;
  VisibilityTracker? get _visibilityTracker => params[AppConstants.visibilityTracker];

  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var view = buildView(context);

    if (enableVisibilityTracking) {
      view = view.visibilityDetector(
          key: widgetKey,
          onVisibilityChanged: (visibilityInfo) {
            _visibilityTracker?.trackVisibility(key: widgetKey, visibilityInfo: visibilityInfo, onVisible: onVisible, onInvisible: onInvisible);
          }
      );
    }

    return view;
  }

  void onVisible() {}

  void onInvisible(int diffSec) {}

  void onSwipeBack() {}
}