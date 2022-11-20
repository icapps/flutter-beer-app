import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/util/extension/localization_extension.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ErrorUtil {
  String? showError(dynamic error) {
    String key;
    if (error is String) {
      _showError(error);
      return null;
    } else if (error is NetworkError) {
      if (error.showInProduction) {
        key = error.getLocalizedKey();
      } else if (FlavorConfig.instance.values.showFullErrorMessages) {
        final code = error.getErrorCode;
        if (code == null) {
          key = LocalizationKeys.errorGeneral;
        } else {
          showError(localization.getTranslation(LocalizationKeys.errorGeneralWithCode, args: <String>[code]));
          return null;
        }
      } else {
        key = LocalizationKeys.errorGeneral;
      }
    } else if (error is LocalizedError) {
      key = error.getLocalizedKey();
    } else {
      logger.warning('Caught an error that is not handled by the BeerAppError $error');
      key = LocalizationKeys.errorGeneral;
    }
    showErrorWithLocaleKey(key);
    return key;
  }

  void _showError(String error) => getIt.get<MainNavigator>().showCustomSnackBar(message: error);

  void showErrorWithLocaleKey(String errorKey, {List<dynamic>? args}) => _showError(localization.getTranslation(errorKey));
}
