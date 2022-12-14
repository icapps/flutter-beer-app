import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

class CodeError with LocalizedError {
  @override
  String getLocalizedKey() {
    if (FlavorConfig.isDev()) {
      return LocalizationKeys.errorDuringDev;
    }
    return LocalizationKeys.errorGeneral;
  }
}
