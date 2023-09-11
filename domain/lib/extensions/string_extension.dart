import 'package:flutter/material.dart';

extension StringExtension on String? {
  String toCapitalized() => (this?.length ?? 0) > 0 ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}' : '';

  String toTitleCase() => this!.replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  bool get isNullEmptyOrWhitespace => this == null || this!.isEmpty || this!.trim().isEmpty;

  String? get validate {
    String? returnValue = this;
    if (isNullEmptyOrWhitespace) {
      returnValue = null;
    }
    return returnValue;
  }

  String capitalize() {
    return "${this?[0].toUpperCase()}${this?.substring(1)}";
  }

  String? firstSegment({var stopChar}) {
    int? index = this?.indexOf(stopChar);
    if (index == -1) {
      if (this?.isNotEmpty == true) {
        return this;
      } else {
        return '';
      }
    } else {
      return this?.substring(0, index);
    }
  }

  String removeSegment(String? block) {
    return this?.replaceFirst('$block/', '').replaceFirst('$block', '') ?? '';
  }

  int? toInt() {
    int? returnValue;
    try {
      if (this != null) {
        returnValue = int.parse(this!);
      }
    } catch(ex) {
      returnValue = null;
    }

    return returnValue;
  }

  Color? toColor() {
    Color? returnValue;
    try {
      var hexColor = this?.replaceAll("#", "");
      if (hexColor?.length == 6) {
        hexColor = 'FF$hexColor';
      }
      if (hexColor?.length == 8) {
        returnValue = Color(int.parse("0x$hexColor"));
      }
    } catch(ex) {
      debugPrint(ex.toString());
    }

    return returnValue;
  }

  String? toCamelCase() {
    String? returnValue;

    try {
      returnValue = this![0].toUpperCase() + this!.substring(1, this!.length).toLowerCase();
    } catch(ex) {
      debugPrint(ex.toString());
    }
    return returnValue;
  }

  String? subString({required int start, int? end}) {
    if (this == null) return '';

    int newStart = (start < 0 || start > this!.length) ? 0 : start;
    int newEnd = (end == null || end < 0 || end >= this!.length) ? this!.length : end;

    String returnValue = this!.substring(newStart, newEnd);
    return returnValue;
  }
}