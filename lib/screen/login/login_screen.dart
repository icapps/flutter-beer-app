import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/viewmodel/login/login_viewmodel.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_input_field.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = RouteNames.loginScreen;

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
      create: () => getIt()..init(),
      childBuilderWithViewModel: (context, viewModel, theme, localization) => Scaffold(
        body: Column(
          children: [
            BeerAppInputField(
              hint: 'Email',
              onChanged: viewModel.onEmailUpdated,
            ),
            BeerAppInputField(
              hint: 'Password',
              onChanged: viewModel.onPasswordUpdated,
            ),
            const SizedBox(height: 8),
            BeerAppButton(
              text: 'Login',
              onClick: viewModel.onLoginClicked,
            ),
          ],
        ),
      ),
    );
  }
}
