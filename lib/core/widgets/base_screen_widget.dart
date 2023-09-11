import 'package:flutter/material.dart';
import 'package:jokes_app/core/extensions/core_ui_extension.dart';
import 'package:jokes_app/core/utils/visibility_tracker.dart';

abstract class BaseScreenWidget extends StatelessWidget with WidgetsBindingObserver {
  final Key widgetKey;
  final Map<String, dynamic> params;
  final VisibilityTracker _visibilityTracker = VisibilityTracker.newInstance;

  BaseScreenWidget({required this.widgetKey, required this.params}) : super(key: widgetKey);

  bool get isAutoSwipeBackEnabled => false;
  bool get enableVisibilityTracking => false;

  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var view = buildView(context);

    if (enableVisibilityTracking) {
      view = view.visibilityDetector(
          key: widgetKey,
          onVisibilityChanged: (visibilityInfo) {
            _visibilityTracker.trackVisibility(key: widgetKey, visibilityInfo: visibilityInfo, onVisible: onVisible, onInvisible: onInvisible);
          }
      );
    }

    if (isAutoSwipeBackEnabled) {
      view = WillPopScope(
        onWillPop: () => Future.value(false),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 10 && details.globalPosition.dx < 100) {
              onSwipeBack();
            }
          },
          child: view,
        ),
      );
    }

    return view;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume();
        break;

      case AppLifecycleState.paused:
        onPause();
        break;

      default:
        break;
    }
  }

  void onResume() {}

  void onPause() {}

  void onVisible() {}

  void onInvisible(int diffSec) {}

  void onSwipeBack() {}
}