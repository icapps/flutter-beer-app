import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/viewmodel/debug/debug_theme_selector_viewmodel.dart';
import 'package:beer_app/widget/debug/selector_item.dart';
import 'package:beer_app/widget/general/styled/beer_app_back_button.dart';
import 'package:beer_app/widget/general/theme_widget.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';

class ThemeModeSelectorScreen extends StatefulWidget {
  static const String routeName = RouteNames.themeModeSelectorScreen;

  const ThemeModeSelectorScreen({super.key});

  @override
  ThemeModeSelectorScreenState createState() => ThemeModeSelectorScreenState();
}

@visibleForTesting
class ThemeModeSelectorScreenState extends State<ThemeModeSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DebugThemeSelectorViewmodel>(
      create: getIt,
      childBuilderWithViewModel: (context, viewModel, theme, localization) => ThemeWidget(
        child: Scaffold(
          backgroundColor: theme.colorsTheme.background,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: BeerAppBackButton.light(onClick: viewModel.onBackClicked),
            title: const Text('Select a theme mode'),
            backgroundColor: theme.colorsTheme.primary,
          ),
          body: ListView(
            children: [
              SelectorItem(
                title: localization.generalLabelSystemDefault,
                onClick: () => viewModel.updateThemeMode(ThemeMode.system),
                selected: viewModel.themeMode == ThemeMode.system,
              ),
              SelectorItem(
                title: localization.themeModeLabelLight,
                onClick: () => viewModel.updateThemeMode(ThemeMode.light),
                selected: viewModel.themeMode == ThemeMode.light,
              ),
              SelectorItem(
                title: localization.themeModeLabelDark,
                onClick: () => viewModel.updateThemeMode(ThemeMode.dark),
                selected: viewModel.themeMode == ThemeMode.dark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
