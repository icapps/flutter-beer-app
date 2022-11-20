import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/viewmodel/debug/debug_platform_selector_viewmodel.dart';
import 'package:beer_app/viewmodel/global/global_viewmodel.dart';
import 'package:beer_app/widget/debug/selector_item.dart';
import 'package:beer_app/widget/general/styled/beer_app_back_button.dart';
import 'package:beer_app/widget/general/theme_widget.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class DebugPlatformSelectorScreen extends StatefulWidget {
  static const String routeName = RouteNames.debugPlatformSelectorScreen;

  const DebugPlatformSelectorScreen({super.key});

  @override
  DebugPlatformSelectorScreenState createState() => DebugPlatformSelectorScreenState();
}

@visibleForTesting
class DebugPlatformSelectorScreenState extends State<DebugPlatformSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DebugPlatformSelectorViewModel>(
      create: getIt,
      consumerWithThemeAndLocalization: (context, value, _, theme, localization) => ThemeWidget(
        child: Scaffold(
          backgroundColor: theme.colorsTheme.background,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: BeerAppBackButton.light(onClick: value.onBackClicked),
            title: const Text('Select a platform'),
            backgroundColor: theme.colorsTheme.primary,
          ),
          body: Consumer<GlobalViewModel>(
            builder: (context, viewModel, child) => ListView(
              children: [
                SelectorItem(
                  title: localization.generalLabelSystemDefault,
                  onClick: viewModel.setSelectedPlatformToDefault,
                  selected: viewModel.targetPlatform == null,
                ),
                SelectorItem(
                  title: localization.generalLabelAndroid,
                  onClick: viewModel.setSelectedPlatformToAndroid,
                  selected: viewModel.targetPlatform == TargetPlatform.android,
                ),
                SelectorItem(
                  title: localization.generalLabelIos,
                  onClick: viewModel.setSelectedPlatformToIOS,
                  selected: viewModel.targetPlatform == TargetPlatform.iOS,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
