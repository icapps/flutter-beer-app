import 'package:flutter/material.dart';
import 'package:beer_app/widget/general/styled/beer_app_switch.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../di/test_injectable.dart';
import '../../../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());
  group('Android', () {
    testWidgets('BeerAppSwitch with false value', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.android),
        child: BeerAppSwitch(
          value: false,
          onChanged: (value) {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_switch_false_android');
    });

    testWidgets('BeerAppSwitch with true value', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.android),
        child: BeerAppSwitch(
          value: true,
          onChanged: (value) {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_switch_true_android');
    });

    group('OnChanged', () {
      testWidgets('BeerAppSwitch onChanged from value true', (tester) async {
        bool? newValue;
        final sut = Theme(
          data: ThemeData(platform: TargetPlatform.android),
          child: BeerAppSwitch(
            value: true,
            onChanged: (value) {
              newValue = value;
            },
          ),
        );

        await TestUtil.loadWidgetWithText(tester, sut);
        final finder = find.byType(BeerAppSwitch);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(newValue, false);
      });
      testWidgets('BeerAppSwitch onChanged from value false', (tester) async {
        bool? newValue;
        final sut = Theme(
          data: ThemeData(platform: TargetPlatform.android),
          child: BeerAppSwitch(
            value: false,
            onChanged: (value) {
              newValue = value;
            },
          ),
        );

        await TestUtil.loadWidgetWithText(tester, sut);
        final finder = find.byType(BeerAppSwitch);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(newValue, true);
      });
    });
  });

  group('iOS', () {
    testWidgets('BeerAppSwitch with false value', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.iOS),
        child: BeerAppSwitch(
          value: false,
          onChanged: (value) {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_switch_false_ios');
    });

    testWidgets('BeerAppSwitch with true value', (tester) async {
      final sut = Theme(
        data: ThemeData(platform: TargetPlatform.iOS),
        child: BeerAppSwitch(
          value: true,
          onChanged: (value) {},
        ),
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_switch_true_ios');
    });

    group('OnChanged', () {
      testWidgets('BeerAppSwitch onChanged from value true', (tester) async {
        bool? newValue;
        final sut = Theme(
          data: ThemeData(platform: TargetPlatform.iOS),
          child: BeerAppSwitch(
            value: true,
            onChanged: (value) {
              newValue = value;
            },
          ),
        );

        await TestUtil.loadWidgetWithText(tester, sut);
        final finder = find.byType(BeerAppSwitch);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(newValue, false);
      });
      testWidgets('BeerAppSwitch onChanged from value false', (tester) async {
        bool? newValue;
        final sut = Theme(
          data: ThemeData(platform: TargetPlatform.iOS),
          child: BeerAppSwitch(
            value: false,
            onChanged: (value) {
              newValue = value;
            },
          ),
        );

        await TestUtil.loadWidgetWithText(tester, sut);
        final finder = find.byType(BeerAppSwitch);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.pumpAndSettle();
        expect(newValue, true);
      });
    });
  });
}
