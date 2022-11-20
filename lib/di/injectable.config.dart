// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i40;
import 'package:drift/drift.dart' as _i8;
import 'package:flutter/foundation.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i16;

import '../database/beer_app_database.dart' as _i19;
import '../database/todo/todo_dao_storage.dart' as _i22;
import '../navigator/main_navigator.dart' as _i12;
import '../repository/debug/debug_repository.dart' as _i25;
import '../repository/locale/locale_repository.dart' as _i27;
import '../repository/login/login_repository.dart' as _i28;
import '../repository/refresh/refresh_repository.dart' as _i32;
import '../repository/secure_storage/auth/auth_storage.dart' as _i24;
import '../repository/secure_storage/secure_storage.dart' as _i15;
import '../repository/shared_prefs/local/local_storage.dart' as _i26;
import '../repository/todo/todo_repository.dart' as _i23;
import '../styles/theme_data.dart' as _i3;
import '../util/cache/cache_controller.dart' as _i6;
import '../util/cache/cache_controlling.dart' as _i5;
import '../util/interceptor/network_auth_interceptor.dart' as _i31;
import '../util/interceptor/network_error_interceptor.dart' as _i13;
import '../util/interceptor/network_log_interceptor.dart' as _i14;
import '../util/interceptor/network_refresh_interceptor.dart' as _i39;
import '../util/locale/localization.dart' as _i11;
import '../util/snackbar/error_util.dart' as _i9;
import '../viewmodel/debug/debug_platform_selector_viewmodel.dart' as _i20;
import '../viewmodel/debug/debug_theme_selector_viewmodel.dart' as _i36;
import '../viewmodel/debug/debug_viewmodel.dart' as _i37;
import '../viewmodel/global/global_viewmodel.dart' as _i38;
import '../viewmodel/license/license_viewmodel.dart' as _i21;
import '../viewmodel/login/login_viewmodel.dart' as _i29;
import '../viewmodel/login/login_viewmodel_old.dart' as _i30;
import '../viewmodel/splash/splash_viewmodel.dart' as _i33;
import '../viewmodel/todo/todo_add/todo_add_viewmodel.dart' as _i34;
import '../viewmodel/todo/todo_list/todo_list_viewmodel.dart' as _i35;
import '../webservice/todo/todo_dummy_service.dart' as _i18;
import '../webservice/todo/todo_service.dart' as _i17;
import '../webservice/todo/todo_webservice.dart' as _i41;
import 'injectable.dart' as _i42;

const String _dummy = 'dummy';
const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.BeerAppTheme>(() => registerModule.theme());
  gh.factory<_i4.Brightness>(() => registerModule.brightness());
  gh.singleton<_i5.CacheControlling>(_i6.CacheController());
  gh.singleton<_i7.ConnectivityHelper>(registerModule.connectivityHelper());
  await gh.singletonAsync<_i8.DatabaseConnection>(
    () => registerModule.provideDatabaseConnection(),
    preResolve: true,
  );
  gh.lazySingleton<_i9.ErrorUtil>(() => _i9.ErrorUtil());
  gh.lazySingleton<_i10.FlutterSecureStorage>(() => registerModule.storage());
  gh.lazySingleton<_i11.Localization>(() => registerModule.localization());
  gh.lazySingleton<_i12.MainNavigator>(
      () => _i12.MainNavigator(get<_i9.ErrorUtil>()));
  gh.singleton<_i13.NetworkErrorInterceptor>(
      _i13.NetworkErrorInterceptor(get<_i7.ConnectivityHelper>()));
  gh.singleton<_i14.NetworkLogInterceptor>(_i14.NetworkLogInterceptor());
  gh.lazySingleton<_i15.SecureStorage>(
      () => _i15.SecureStorage(get<_i10.FlutterSecureStorage>()));
  await gh.singletonAsync<_i16.SharedPreferences>(
    () => registerModule.prefs(),
    preResolve: true,
  );
  gh.singleton<_i17.TodoService>(
    _i18.TodoDummyService(),
    registerFor: {_dummy},
  );
  gh.lazySingleton<_i19.BeerAppDatabase>(() =>
      registerModule.provideBeerAppDatabase(get<_i8.DatabaseConnection>()));
  gh.factory<_i20.DebugPlatformSelectorViewModel>(
      () => _i20.DebugPlatformSelectorViewModel(get<_i12.MainNavigator>()));
  gh.factory<_i21.LicenseViewModel>(
      () => _i21.LicenseViewModel(get<_i12.MainNavigator>()));
  gh.lazySingleton<_i7.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i16.SharedPreferences>()));
  gh.lazySingleton<_i7.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i7.SharedPreferenceStorage>(),
            get<_i15.SecureStorage>(),
          ));
  gh.lazySingleton<_i22.TodoDaoStorage>(
      () => _i22.TodoDaoStorage(get<_i19.BeerAppDatabase>()));
  gh.lazySingleton<_i23.TodoRepository>(() => _i23.TodoRepository(
        get<_i17.TodoService>(),
        get<_i22.TodoDaoStorage>(),
      ));
  gh.lazySingleton<_i24.AuthStorage>(
      () => _i24.AuthStorage(get<_i7.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i25.DebugRepository>(
      () => _i25.DebugRepository(get<_i7.SharedPreferenceStorage>()));
  gh.lazySingleton<_i26.LocalStorage>(() => _i26.LocalStorage(
        get<_i24.AuthStorage>(),
        get<_i7.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i27.LocaleRepository>(
      () => _i27.LocaleRepository(get<_i7.SharedPreferenceStorage>()));
  gh.lazySingleton<_i28.LoginRepository>(
      () => _i28.LoginRepository(get<_i24.AuthStorage>()));
  gh.factory<_i29.LoginViewModel>(() => _i29.LoginViewModel(
        get<_i28.LoginRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i30.LoginViewModel>(() => _i30.LoginViewModel(
        get<_i28.LoginRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.singleton<_i31.NetworkAuthInterceptor>(
      _i31.NetworkAuthInterceptor(get<_i24.AuthStorage>()));
  gh.lazySingleton<_i32.RefreshRepository>(
      () => _i32.RefreshRepository(get<_i24.AuthStorage>()));
  gh.factory<_i33.SplashViewModel>(() => _i33.SplashViewModel(
        get<_i28.LoginRepository>(),
        get<_i26.LocalStorage>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i34.TodoAddViewModel>(() => _i34.TodoAddViewModel(
        get<_i23.TodoRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i35.TodoListViewModel>(() => _i35.TodoListViewModel(
        get<_i23.TodoRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i36.DebugThemeSelectorViewmodel>(
      () => _i36.DebugThemeSelectorViewmodel(
            get<_i12.MainNavigator>(),
            get<_i26.LocalStorage>(),
          ));
  gh.factory<_i37.DebugViewModel>(() => _i37.DebugViewModel(
        get<_i25.DebugRepository>(),
        get<_i12.MainNavigator>(),
        get<_i19.BeerAppDatabase>(),
        get<_i26.LocalStorage>(),
      ));
  gh.lazySingleton<_i38.GlobalViewModel>(() => _i38.GlobalViewModel(
        get<_i27.LocaleRepository>(),
        get<_i25.DebugRepository>(),
        get<_i26.LocalStorage>(),
        get<_i11.Localization>(),
      ));
  gh.singleton<_i39.NetworkRefreshInterceptor>(_i39.NetworkRefreshInterceptor(
    get<_i24.AuthStorage>(),
    get<_i32.RefreshRepository>(),
  ));
  gh.lazySingleton<_i7.CombiningSmartInterceptor>(
      () => registerModule.provideCombiningSmartInterceptor(
            get<_i14.NetworkLogInterceptor>(),
            get<_i31.NetworkAuthInterceptor>(),
            get<_i13.NetworkErrorInterceptor>(),
            get<_i39.NetworkRefreshInterceptor>(),
          ));
  gh.lazySingleton<_i40.Dio>(
      () => registerModule.provideDio(get<_i7.CombiningSmartInterceptor>()));
  gh.singleton<_i17.TodoService>(
    _i41.TodoWebService(get<_i40.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  return get;
}

class _$RegisterModule extends _i42.RegisterModule {}
