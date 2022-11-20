import 'package:flutter/material.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';

class BeerAppProgressIndicator extends StatelessWidget {
  final bool dark;

  const BeerAppProgressIndicator({
    required this.dark,
    super.key,
  });

  const BeerAppProgressIndicator.dark({Key? key})
      : dark = true,
        super(key: key);

  const BeerAppProgressIndicator.light({Key? key})
      : dark = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
      childBuilderTheme: (context, theme) {
        if (FlavorConfig.isInTest()) {
          return Container(
            color: theme.colorsTheme.accent,
            height: 50,
            width: 50,
            child: const Text(
              'CircularProgressIndicator',
              style: TextStyle(fontSize: 8),
            ),
          );
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(dark ? theme.colorsTheme.progressIndicator : theme.colorsTheme.inverseProgressIndicator),
        );
      },
    );
  }
}
