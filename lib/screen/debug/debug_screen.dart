import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/util/keys.dart';
import 'package:beer_app/viewmodel/debug/debug_viewmodel.dart';
import 'package:beer_app/viewmodel/global/global_viewmodel.dart';
import 'package:beer_app/widget/debug/debug_row_item.dart';
import 'package:beer_app/widget/debug/debug_row_title.dart';
import 'package:beer_app/widget/debug/debug_switch_row_item.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class DebugScreen extends StatefulWidget {
  static const String routeName = RouteNames.debugScreen;

  const DebugScreen({super.key});

  @override
  DebugScreenState createState() => DebugScreenState();
}

@visibleForTesting
class DebugScreenState extends State<DebugScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DebugViewModel>(
      create: () => getIt()..init(),
      consumerWithThemeAndLocalization: (context, viewModel, child, theme, localization) => Scaffold(
        backgroundColor: theme.colorsTheme.background,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(localization.settingsTitle),
          backgroundColor: theme.colorsTheme.primary,
        ),
        body: ListView(
          children: [
            DebugRowTitle(title: localization.debugAnimationsTitle),
            DebugRowSwitchItem(
              key: Keys.debugSlowAnimations,
              title: localization.debugSlowAnimations,
              value: viewModel.slowAnimationsEnabled,
              onChanged: viewModel.onSlowAnimationsChanged,
            ),
            DebugRowTitle(title: localization.debugThemeTitle),
            DebugRowItem(
              key: Keys.debugTargetPlatform,
              title: localization.debugTargetPlatformTitle,
              subTitle: localization.debugTargetPlatformSubtitle(localization.getTranslation(Provider.of<GlobalViewModel>(context).getCurrentPlatform())),
              onClick: viewModel.onTargetPlatformClicked,
            ),
            DebugRowItem(
              key: Keys.debugThemeMode,
              title: localization.debugThemeModeTitle,
              subTitle: localization.debugThemeModeSubtitle,
              onClick: viewModel.onThemeModeClicked,
            ),
            DebugRowTitle(title: localization.debugLocaleTitle),
            DebugRowItem(
              key: Keys.debugSelectLanguage,
              title: localization.debugLocaleSelector,
              subTitle: localization.debugLocaleCurrentLanguage(Provider.of<GlobalViewModel>(context).getCurrentLanguage()),
              onClick: viewModel.onSelectLanguageClicked,
            ),
            DebugRowSwitchItem(
              key: Keys.debugShowTranslations,
              title: localization.debugShowTranslations,
              value: Provider.of<GlobalViewModel>(context, listen: false).showsTranslationKeys,
              onChanged: (_) => Provider.of<GlobalViewModel>(context, listen: false).toggleTranslationKeys(),
            ),
            DebugRowTitle(title: localization.debugLicensesTitle),
            DebugRowItem(
              key: Keys.debugLicense,
              title: localization.debugLicensesGoTo,
              onClick: viewModel.onLicensesClicked,
            ),
            DebugRowTitle(title: localization.debugDatabase),
            DebugRowItem(
              key: Keys.debugDatabase,
              title: localization.debugViewDatabase,
              onClick: viewModel.goToDatabase,
            ),
          ],
        ),
      ),
    );
  }
}
