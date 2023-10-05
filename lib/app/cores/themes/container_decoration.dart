import 'package:annotation/app/cores/values/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerDecoration {
  static BoxDecoration rounded({
    double borderRadius = 10,
    double borderWidth = 1,
    Color? borderColor,
    Color? fillColor,
  }) {
    borderColor ??= AppColors.greyF5F5F5;
    fillColor ??= AppColors.blue0066ff;
    return BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }
}
