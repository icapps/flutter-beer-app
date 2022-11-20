import 'package:beer_app/widget/general/styled/beer_app_back_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../di/test_injectable.dart';
import '../../../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());

  group('BeerAppBackButton dark', () {
    testWidgets('BeerAppBackButton dark initial state', (tester) async {
      final sut = BeerAppBackButton.dark(onClick: () {});

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_back_button_dark');
    });

    testWidgets('BeerAppBackButton dark initial state fullscreen', (tester) async {
      final sut = BeerAppBackButton.dark(
        onClick: () {},
        fullScreen: true,
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_back_button_full_screen_dark');
    });

    testWidgets('BeerAppBackButton dark click', (tester) async {
      var clicked = false;
      final sut = BeerAppBackButton.dark(onClick: () {
        clicked = true;
      });

      await TestUtil.loadWidgetWithText(tester, sut);
      final finder = find.byType(BeerAppBackButton);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(clicked, true);
    });
  });

  group('BeerAppBackButton light', () {
    testWidgets('BeerAppBackButton light initial state', (tester) async {
      final sut = BeerAppBackButton.light(onClick: () {});

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_back_button_light');
    });

    testWidgets('BeerAppBackButton light initial state fullscreen', (tester) async {
      final sut = BeerAppBackButton.light(
        onClick: () {},
        fullScreen: true,
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_back_button_full_screen_light');
    });

    testWidgets('BeerAppBackButton light click', (tester) async {
      var clicked = false;
      final sut = BeerAppBackButton.light(onClick: () {
        clicked = true;
      });

      await TestUtil.loadWidgetWithText(tester, sut);
      final finder = find.byType(BeerAppBackButton);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(clicked, true);
    });
  });
}
