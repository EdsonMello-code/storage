import 'package:flutter/material.dart';
import 'package:storage/app/core/theme.dart' hide Theme;

extension AppThemeExtension on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
}
