import 'package:beer_app/widget/general/styled/beer_app_input_field.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../di/test_injectable.dart';
import '../../../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());
  testWidgets('BeerAppInputField with enabled true', (tester) async {
    final sut = BeerAppInputField(
      onChanged: (value) {},
      enabled: true,
      hint: 'Hint text',
    );

    await TestUtil.loadWidgetWithText(tester, sut);
    await TestUtil.takeScreenshot(tester, 'beer_app_input_field_with_hint_and_enabled');
  });

  testWidgets('BeerAppInputField with enabled false', (tester) async {
    final sut = BeerAppInputField(
      onChanged: (value) {},
      enabled: false,
      hint: 'Hint text',
    );

    await TestUtil.loadWidgetWithText(tester, sut);
    await TestUtil.takeScreenshot(tester, 'beer_app_input_field_with_hint_and_disabled');
  });

  group('OnChanged', () {
    testWidgets('BeerAppInputField with false value', (tester) async {
      String? newText;
      final sut = BeerAppInputField(
        onChanged: (value) {
          newText = value;
        },
        enabled: true,
        hint: 'Hint text',
      );

      await TestUtil.loadWidgetWithText(tester, sut);
      await TestUtil.takeScreenshot(tester, 'beer_app_input_field_type_text_before');
      final finder = find.byType(BeerAppInputField);
      expect(finder, findsOneWidget);
      await tester.showKeyboard(finder);
      await tester.enterText(finder, 'Testing');
      await tester.pumpAndSettle();
      await TestUtil.takeScreenshot(tester, 'beer_app_input_field_type_text_after');
      expect(newText, 'Testing');
    });
  });
}
