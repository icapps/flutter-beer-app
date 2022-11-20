import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/di/db/setup_drift_none.dart'
    if (dart.library.io) 'package:beer_app/di/db/setup_drift_io.dart'
    if (dart.library.js) 'package:beer_app/di/db/setup_drift_web.dart';
import 'package:beer_app/di/injectable.config.dart';
import 'package:beer_app/main_common.dart';
import 'package:beer_app/navigator/middle_ware/init_middle_ware.dart';
import 'package:beer_app/repository/secure_storage/secure_storage.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/util/interceptor/network_auth_interceptor.dart';
import 'package:beer_app/util/interceptor/network_error_interceptor.dart';
import 'package:beer_app/util/interceptor/network_log_interceptor.dart';
import 'package:beer_app/util/interceptor/network_refresh_interceptor.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:get_it/get_it.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.asNewInstance();

@InjectableInit(
  initializerName: r'$initGetIt',
  generateForDir: ['lib'],
)
Future<void> configureDependencies(String environment) async {
  // ignore: avoid_print
  print('Using environment: $environment');
  await $initGetIt(getIt, environment: environment);
  await getIt.allReady();
  await initMiddleWare();
  await initLocale();
  updateAppTheme();
}

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<SharedPreferences> prefs() {
    if (FlavorConfig.isInTest()) {
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues(<String, Object>{});
    }
    return SharedPreferences.getInstance();
  }

  @lazySingleton
  Localization localization() => Localization();

  @lazySingleton
  SharedPreferenceStorage sharedPreferences(SharedPreferences preferences) => SharedPreferenceStorage(preferences);

  @singleton
  ConnectivityHelper connectivityHelper() => ConnectivityHelper();

  @singleton
  @preResolve
  Future<DatabaseConnection> provideDatabaseConnection() {
    return createDriftDatabaseConnection('db');
  }

  @lazySingleton
  FlutterSecureStorage storage() => const FlutterSecureStorage();

  @lazySingleton
  SimpleKeyValueStorage keyValueStorage(SharedPreferenceStorage preferences, SecureStorage secure) {
    if (kIsWeb) return preferences;
    return secure;
  }

  @lazySingleton
  BeerAppTheme theme() => BeerAppTheme();

  @injectable
  Brightness brightness() => MediaQueryData.fromWindow(WidgetsBinding.instance.window).platformBrightness;

  @lazySingleton
  CombiningSmartInterceptor provideCombiningSmartInterceptor(
    NetworkLogInterceptor logInterceptor,
    NetworkAuthInterceptor authInterceptor,
    NetworkErrorInterceptor errorInterceptor,
    NetworkRefreshInterceptor refreshInterceptor,
  ) =>
      CombiningSmartInterceptor()
        ..addInterceptor(authInterceptor)
        ..addInterceptor(refreshInterceptor)
        ..addInterceptor(errorInterceptor)
        ..addInterceptor(logInterceptor);

  @lazySingleton
  Dio provideDio(CombiningSmartInterceptor interceptor) {
    final dio = Dio(
      BaseOptions(baseUrl: FlavorConfig.instance.values.baseUrl),
    );
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    dio.interceptors.add(interceptor);
    return dio;
  }

  @lazySingleton
  BeerAppDatabase provideBeerAppDatabase(DatabaseConnection databaseConnection) => BeerAppDatabase.connect(databaseConnection);
}

dynamic _parseAndDecode(String response) => jsonDecode(response);

dynamic parseJson(String text) => compute<String, dynamic>(_parseAndDecode, text);
