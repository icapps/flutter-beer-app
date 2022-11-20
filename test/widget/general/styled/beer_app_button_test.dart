import 'package:flutter/material.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../di/test_injectable.dart';
import '../../../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());
  group('Android', () {
    testWidgets('BeerAppButton initial state', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.android),
        child: BeerAppButton(
          text: 'Hallokes',
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_default_state_android');
    });

    testWidgets('BeerAppButton initial state with height', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.android),
        child: BeerAppButton(
          text: 'Hallokes',
          height: ThemeDimens.padding96,
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_with_height_android');
    });

    testWidgets('BeerAppButton initial state with key', (tester) async {
      const key = ValueKey('A-Testing-Key');
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.android),
        child: BeerAppButton(
          text: 'Hallokes',
          key: key,
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_with_key_android');
      final finder = find.byKey(key);
      expect(finder, findsOneWidget);
    });

    testWidgets('BeerAppButton initial state is not enabled', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.android),
        child: BeerAppButton(
          text: 'Hallokes',
          isEnabled: false,
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_not_enabled_android');
    });

    group('Clicked', () {
      testWidgets('BeerAppButton initial state with key', (tester) async {
        var clicked = false;
        final sut = Theme(
          data: ThemeData(platform: TargetPlatform.android),
          child: BeerAppButton(
            text: 'Hallokes',
            onClick: () {
              clicked = true;
            },
          ),
        );

        await TestUtil.loadWidgetWithText(tester, sut);
        final finder = find.byType(BeerAppButton);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(clicked, true);
      });
    });
  });

  group('iOS', () {
    testWidgets('BeerAppButton initial state', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.iOS),
        child: BeerAppButton(
          text: 'Hallokes',
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_default_state_ios');
    });

    testWidgets('BeerAppButton initial state with height', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.iOS),
        child: BeerAppButton(
          text: 'Hallokes',
          height: ThemeDimens.padding96,
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_with_height_ios');
    });

    testWidgets('BeerAppButton initial state with key', (tester) async {
      const key = ValueKey('A-Testing-Key');
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.iOS),
        child: BeerAppButton(
          text: 'Hallokes',
          key: key,
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_with_key_ios');
      final finder = find.byKey(key);
      expect(finder, findsOneWidget);
    });

    testWidgets('BeerAppButton initial state is not enabled', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.iOS),
        child: BeerAppButton(
          text: 'Hallokes',
          isEnabled: false,
          onClick: () {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_button_not_enabled_ios');
    });

    group('Clicked', () {
      testWidgets('BeerAppButton initial state with key', (tester) async {
        var clicked = false;
        final sut = Theme(
          data: ThemeData(platform: TargetPlatform.iOS),
          child: BeerAppButton(
            text: 'Hallokes',
            onClick: () {
              clicked = true;
            },
          ),
        );

        await TestUtil.loadWidgetWithText(tester, sut);
        final finder = find.byType(BeerAppButton);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(clicked, true);
      });
    });
  });
}
