import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityTracker {
  VisibilityTracker._();
  static VisibilityTracker get newInstance => VisibilityTracker._();

  final Map<String, int> _visibilityMap = {};
  void trackVisibility({required Key key, required VisibilityInfo visibilityInfo, required void Function() onVisible, required void Function(int diffSec) onInvisible}) {
    bool isVisible = visibilityInfo.visibleFraction > 0.4;
    String viewKey = key.toString();

    if (isVisible) {
      if (!_visibilityMap.containsKey(viewKey)) {
        _visibilityMap.addAll({viewKey: DateTime.now().millisecondsSinceEpoch});
        onVisible.call();
      }
    } else {
      if (_visibilityMap.containsKey(viewKey)) {
        int startTimeSec = _visibilityMap[viewKey]!;
        int endTimeSec = DateTime.now().millisecondsSinceEpoch;
        int diffSec = (endTimeSec - startTimeSec) ~/ 1000;
        _visibilityMap.remove(viewKey);
        onInvisible.call(diffSec);
      }
    }
  }
}