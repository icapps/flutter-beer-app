import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:beer_app/architecture.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/repository/locale/locale_repository.dart';
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:beer_app/util/web/app_configurator.dart' if (dart.library.html) 'package:beer_app/util/web/app_configurator_web.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

Future<void> initLocale() async {
  final localization = getIt.get<Localization>();
  final localeRepo = getIt.get<LocaleRepository>();
  await localization.load(locale: localeRepo.getCustomLocale());
}

FutureOr<R>? wrapMain<R>(FutureOr<R> Function() appCode) async {
  PlatformDispatcher.instance.onError = (error, trace) {
    try {
      WidgetsFlutterBinding.ensureInitialized();
    } catch (_) {}

    try {
      staticLogger.e('Uncaught platform error', error: error, trace: trace);
    } catch (_) {
      // ignore: avoid_print
      print(error);
      // ignore: avoid_print
      print(trace);
    }

    return true; // Handled
  };

  WidgetsFlutterBinding.ensureInitialized();
  configureWebApp();
  await initArchitecture();

  return await appCode();
}

bool updateAppTheme() {
  if (!FlavorConfig.instance.isThemingSupported) return false;

  final flutterTemplateTheme = getIt.get<BeerAppTheme>();
  final localStorage = getIt.get<LocalStorage>();

  var themeMode = FlavorConfig.instance.themeMode;
  if (localStorage.getThemeMode() != null) {
    themeMode = localStorage.getThemeMode()!;
  }
  if (themeMode == ThemeMode.system) {
    final brightness = getIt.get<Brightness>();
    themeMode = (brightness == Brightness.dark) ? ThemeMode.dark : ThemeMode.light;
  }
  return flutterTemplateTheme.configureForThemeStyle(themeMode == ThemeMode.dark ? BeerAppThemeStyle.dark : BeerAppThemeStyle.light);
}
