import 'package:flutter/material.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/env/flavor_config.dart';

class TestThemeUtil {
  static void setDarkMode() {
    FlavorConfig.instance.themeMode = ThemeMode.dark;
    final flutterTemplateTheme = getIt<BeerAppTheme>();
    flutterTemplateTheme.configureForThemeStyle(BeerAppThemeStyle.dark);
  }

  static void setLightMode() {
    FlavorConfig.instance.themeMode = ThemeMode.light;
    final flutterTemplateTheme = getIt<BeerAppTheme>();
    flutterTemplateTheme.configureForThemeStyle(BeerAppThemeStyle.light);
  }
}
