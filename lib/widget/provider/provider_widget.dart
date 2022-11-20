import 'package:flutter/widgets.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

class ProviderWidget<T extends ChangeNotifier> extends BaseProviderWidget<T, BeerAppTheme, Localization> {
  const ProviderWidget({
    required T Function() create,
    Widget? child,
    Widget Function(BuildContext context, BeerAppTheme theme, Localization localization)? childBuilder,
    Widget Function(BuildContext context, T viewModel, BeerAppTheme theme, Localization localization)? childBuilderWithViewModel,
    Widget? consumerChild,
    Widget Function(BuildContext context, T viewModel, Widget? child)? consumer,
    Widget Function(BuildContext context, T viewModel, Widget? child, BeerAppTheme theme, Localization localization)? consumerWithThemeAndLocalization,
    bool lazy = true,
  }) : super(
          create: create,
          child: child,
          childBuilder: childBuilder,
          childBuilderWithViewModel: childBuilderWithViewModel,
          consumerChild: consumerChild,
          consumer: consumer,
          consumerWithThemeAndLocalization: consumerWithThemeAndLocalization,
          lazy: lazy,
        );
}
