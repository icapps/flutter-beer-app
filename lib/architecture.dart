import 'package:flutter/widgets.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

L _getLocale<L>(BuildContext context) => getIt.get<Localization>() as L;

T _getTheme<T>(BuildContext context) => getIt.get<BeerAppTheme>() as T;

Future<void> initArchitecture() async {
  await OsInfo.init();
  localizationLookup = _getLocale;
  themeLookup = _getTheme;
}
