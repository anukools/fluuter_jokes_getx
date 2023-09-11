import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

extension CoreUIExtensions on Widget {
  /// Extension for [Expanded]
  Expanded expanded({Key? key, int flex = 1}) {
    return Expanded(
      key: key,
      flex: flex,
      child: this,
    );
  }

  /// Extension for [Flexible]
  Flexible flexible({Key? key, int flex = 1, FlexFit flexFit = FlexFit.loose}) {
    return Flexible(
      key: key,
      flex: flex,
      fit: flexFit,
      child: this,
    );
  }

  /// Visibility tracker
  VisibilityDetector visibilityDetector({required Key key, Function(VisibilityInfo info)? onVisibilityChanged}) {
    return VisibilityDetector(
      key: key,
      onVisibilityChanged: onVisibilityChanged,
      child: this,
    );
  }

  /// on click
  InkWell onTap(VoidCallback callback) {
    return InkWell(
      key: key,
      onTap: callback,
      child: this,
    );
  }

  /// on touch
  InkWell onTouch({required VoidCallback onTap,  VoidCallback? onDoubleTap, VoidCallback? onLongPress}) {
    return InkWell(
      key: key,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: this,
    );
  }

  Visibility visibility({required bool visible}) {
    return Visibility(
      visible: visible,
      child: this,
    );
  }
}