import 'package:flutter/widgets.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

class DataProviderWidget extends BaseThemeProviderWidget<BeerAppTheme, Localization> {
  const DataProviderWidget({
    Widget Function(BuildContext context, BeerAppTheme theme)? childBuilderTheme,
    Widget Function(BuildContext context, Localization localization)? childBuilderLocalization,
    Widget Function(BuildContext context, BeerAppTheme theme, Localization localization)? childBuilder,
  }) : super(
          childBuilderTheme: childBuilderTheme,
          childBuilderLocalization: childBuilderLocalization,
          childBuilder: childBuilder,
        );
}
