import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/debug/debug_repository.dart';
import 'package:beer_app/repository/locale/locale_repository.dart';
import 'package:beer_app/repository/login/login_repository.dart';
import 'package:beer_app/repository/refresh/refresh_repository.dart';
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart';
import 'package:beer_app/repository/secure_storage/secure_storage.dart';
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart';
import 'package:beer_app/repository/todo/todo_repository.dart';
import 'package:beer_app/viewmodel/debug/debug_platform_selector_viewmodel.dart';
import 'package:beer_app/viewmodel/debug/debug_viewmodel.dart';
import 'package:beer_app/viewmodel/global/global_viewmodel.dart';
import 'package:beer_app/viewmodel/license/license_viewmodel.dart';
import 'package:beer_app/viewmodel/login/login_viewmodel.dart';
import 'package:beer_app/viewmodel/splash/splash_viewmodel.dart';
import 'package:beer_app/viewmodel/todo/todo_add/todo_add_viewmodel.dart';
import 'package:beer_app/viewmodel/todo/todo_list/todo_list_viewmodel.dart';
import 'package:beer_app/webservice/todo/todo_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_injectable.dart';

@GenerateMocks([
  MainNavigator,
  DebugRepository,
  LocaleRepository,
  LoginRepository,
  RefreshRepository,
  SecureStorage,
  AuthStorage,
  SharedPreferenceStorage,
  LocalStorage,
  TodoRepository,
  Connectivity,
  FlutterSecureStorage,
  SharedPreferences,
  Dio,
  TodoService,
  DebugPlatformSelectorViewModel,
  DebugViewModel,
  GlobalViewModel,
  LicenseViewModel,
  LoginViewModel,
  SplashViewModel,
  TodoAddViewModel,
  TodoListViewModel,
])
void main() {
  setUp(() async => initTestInjectable());

  test('Injectable', () async {
    final loginRepo = getIt<LoginRepository>();
    expect(loginRepo, isA<LoginRepository>());
  });
}
