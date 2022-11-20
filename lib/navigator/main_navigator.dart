import 'package:beer_app/model/snackbar/snackbar_data.dart';
import 'package:beer_app/screen/debug/debug_platform_selector_screen.dart';
import 'package:beer_app/screen/debug/debug_screen.dart';
import 'package:beer_app/screen/home/home_screen.dart';
import 'package:beer_app/screen/license/license_screen.dart';
import 'package:beer_app/screen/splash/splash_screen.dart';
import 'package:beer_app/screen/theme_mode/theme_mode_selector.dart';
import 'package:beer_app/screen/todo/todo_add/todo_add_screen.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/util/snackbar/error_util.dart';
import 'package:beer_app/util/snackbar/snackbar_util.dart';
import 'package:beer_app/widget/general/flavor_banner.dart';
import 'package:beer_app/widget/general/navigator_page/base_page.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MainNavigator {
  final ErrorUtil _errorUtil;

  MainNavigator(this._errorUtil);

  static final List<NavigatorObserver> _navigatorObservers = [];

  static String get initialRoute => FlavorConfig.isInTest() ? 'test_route' : SplashScreen.routeName;

  static List<NavigatorObserver> get navigatorObservers => _navigatorObservers;

  static final pages = [
    BasePage<void>(
      name: SplashScreen.routeName,
      page: () => const FlavorBanner(child: SplashScreen()),
    ),
    BasePage<void>(
      name: HomeScreen.routeName,
      page: () => const FlavorBanner(child: HomeScreen()),
    ),
    BasePage<void>(
      name: TodoAddScreen.routeName,
      page: () => const FlavorBanner(child: TodoAddScreen()),
    ),
    BasePage<void>(
      name: LicenseScreen.routeName,
      page: () => const FlavorBanner(child: LicenseScreen()),
    ),
    if (!FlavorConfig.isProd()) ...[
      BasePage<void>(
        name: DebugPlatformSelectorScreen.routeName,
        page: () => const FlavorBanner(child: DebugPlatformSelectorScreen()),
      ),
      BasePage<void>(
        name: ThemeModeSelectorScreen.routeName,
        page: () => const FlavorBanner(child: ThemeModeSelectorScreen()),
      ),
      BasePage<void>(
        name: DebugScreen.routeName,
        page: () => const FlavorBanner(child: DebugScreen()),
      ),
    ],
  ];

  void goToSplash() async => Get.offNamed<void>(SplashScreen.routeName);

  void goToHome() async => Get.offNamed<void>(HomeScreen.routeName);

  Future<void> goToAddTodo() async => Get.toNamed<void>(TodoAddScreen.routeName);

  Future<void> goToDebugPlatformSelector() async => Get.toNamed<void>(DebugPlatformSelectorScreen.routeName);

  Future<void> goToThemeModeSelector() async => Get.toNamed<void>(ThemeModeSelectorScreen.routeName);

  Future<void> goToDebug() async => Get.toNamed<void>(DebugScreen.routeName);

  Future<void> goToLicense() async => Get.toNamed<void>(LicenseScreen.routeName);

  void closeDialog() async => Get.back<void>();

  Future<void> goToDatabase(GeneratedDatabase db) async => Get.to<void>(DriftDbViewer(db));

  void goBack<T>({T? result}) async => Get.back<T>(result: result);

  Future<void> showCustomDialog<T>({Widget? widget}) async => Get.dialog<T>(widget ?? const SizedBox.shrink());

  void showErrorWithLocaleKey(String errorKey, {List<dynamic>? args}) => _errorUtil.showErrorWithLocaleKey(errorKey, args: args);

  void showError(dynamic error) => _errorUtil.showError(error);

  Future<void> showCustomSnackBar({
    required String message,
    String? title,
    SnackBarStyle style = SnackBarStyle.neutral,
  }) async =>
      SnackBarUtil.showSnackbar(
        title: title,
        message: message,
        style: style,
      );
}
