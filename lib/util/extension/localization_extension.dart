import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/util/locale/localization.dart';

extension LocalizationExtension on Object {
  Localization get localization => getIt();
}
