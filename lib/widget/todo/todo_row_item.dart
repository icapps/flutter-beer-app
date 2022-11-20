import 'package:flutter/material.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/general/styled/beer_app_checkbox.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';

class TodoRowItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const TodoRowItem({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
      childBuilderTheme: (context, theme) => GestureDetector(
        onTap: () => onChanged(!value),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeDimens.padding16,
            vertical: ThemeDimens.padding8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.coreTextTheme.bodyNormal,
                ),
              ),
              BeerAppCheckBox(
                value: value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
