import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/styles/theme_data.dart';

extension ThemeExtension on Object {
  BeerAppTheme get theme => getIt();
}
