import 'package:beer_app/widget/general/styled/beer_app_progress_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../di/test_injectable.dart';
import '../../../util/test_util.dart';

void main() {
  setUp(() async => initTestInjectable());

  testWidgets('BeerAppProgressIndicator initial state', (tester) async {
    const sut = BeerAppProgressIndicator.light();

    await TestUtil.loadWidgetWithText(tester, sut);
    await TestUtil.takeScreenshot(tester, 'beer_app_progress_indicator_light');
  });

  testWidgets('BeerAppProgressIndicator initial state dark', (tester) async {
    const sut = BeerAppProgressIndicator.dark();

    await TestUtil.loadWidgetWithText(tester, sut);
    await TestUtil.takeScreenshot(tester, 'beer_app_progress_indicator_dark');
  });
}
