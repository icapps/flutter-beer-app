# Flutter workshop: Beer app

## Prerequisites

### Install Flutter

Follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install).

### Install Visual Studio Code

Follow the instructions on the [Visual Studio Code website](https://code.visualstudio.com/).

Follow the instructions on the [Flutter extension for Visual Studio Code website](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter).

### Install Android Studio

Follow the instructions on the [Android Studio website](https://developer.android.com/studio).
If you don't have a device to test the app on, you can use the Android emulator. Follow the instructions on the [Android Studio website](https://developer.android.com/studio/run/emulator).

### Install FVM

`fvm` is a tool that allows you to manage multiple Flutter SDK versions on your machine. We use this in our scripts and to ensure the project keeps working, even if you install a new Flutter version.

Run `./tool/install_fvm.sh` to install `fvm`.

### Swagger API

The API is available at [TODO](TODO).

### Login

username: `star_developer@icapps.com`

password: `developer`

## Workshop

### Step 1: Copy this repository

This repository contains the starting point for the workshop. You can copy download the repository and open it in Visual Studio Code.

### Step 2: Run the app

Run the app on your device, an emulator or your browser. You can use the following command:

```bash
fvm flutter run --flavor dev
```

or use the `Run` button in Visual Studio Code (select the target bottom right in VSC).

### Step 3: Add login

Create a new file `screen/login/login_screen.dart` and add the following code:

```dart
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Login Screen'),
      ),
    );
  }
}
```

This adds a new widget `LoginScreen`. For now this widget is stateless, which means it doesn't change. The `build` method is called when the widget is created and returns a `Scaffold` widget. The `Scaffold` widget is a widget that contains the basic material design visual layout structure of the app. It contains a `body` property that contains the content of the screen.

The next step is to add a route to the `LoginScreen` widget so we can see it in the app. First add the following code to the `RouteNames`:

```dart
  static const loginScreen = '/login';
```

Then add the routeName to the `LoginScreen`:

```dart
class LoginScreen extends StatelessWidget {
  static const String routeName = RouteNames.loginScreen;

  const LoginScreen({super.key});
...
```

Now we can add the route to the `MainNavigator` in `lib/navigator/main_navigator.dart`:

```dart
  static final pages = [
...
    BasePage<void>(
      name: LoginScreen.routeName,
      page: () => const FlavorBanner(child: LoginScreen()),
    ),
...
```

To navigate automatically to the `LoginScreen`, we need to update the SplashViewModel. Open `viewmodel/splash/splash_viewmodel.dart` and add the following code to the `init` method.

```dart
final result = await _loginRepo.isLoggedIn;
if (result) {
  _navigator.goToHome();
} else {
  _navigator.goToLogin();
}
```

Run the app and you should see the `LoginScreen` widget.

![Empty login screen](/assets_workshop/login_v1.png)

### Step 4: Add login form

The next step is to add input fields to the `LoginScreen` widget so the user can enter their details. First we need to change the layout of the `LoginScreen` to a `Column`. Simply change the `body` property of the `Scaffold` widget to a `Column` widget:

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TODO: Add email field
          // TODO: Add password field
        ],
      ),
    );
  }
```

To add an input field, we can use `BeerAppInputField`. This is a custom widget that is available in our template. It contains a `TextField` widget with some custom styling. It constains the following properties:

```dart
final String hint;
final bool enabled;
final ValueChanged<String> onChanged;
final TextEditingController? controller;
```

The `hint` field is the text that is shown when the field is empty. The `enabled` field is a boolean that indicates if the field is enabled. The `onChanged` field is a callback that is called when the value of the field changes. The `controller` field is a `TextEditingController` that can be used to control the value of the field.

To add the email field, add the following code to the `LoginScreen` widget:

```dart
BeerAppInputField(
  hint: 'Email',
  onChanged: (value) => print(value),
),
```

_Note:_ `onChanged` requires a function. You can enter the following values: `(value) { print(value); }`, `(value) => print(value)` or simply provide the print function itself `onChanged: print,`. All of these are valid, to have a more clear codebase we prefer the last option.

When you enter text in the field, you should see the value printed in the console:

![Email field](/assets_workshop/login_prints.png)

You can add the password field in the same way.

If you run this on a device with rounded corners, you will see that the input field is not entirely visible. To fix this, we can add a `SafeArea` widget. This widget ensures that the content is not covered by the device's status bar. Add a `SafeArea` between the Scaffold and Column widget to fix this:

```dart
return Scaffold(
  body: SafeArea(
    child: Column(
...
```

Next add a `BeerAppButton` widget to the `LoginScreen`. This widget is a custom widget that contains a `MaterialButton` with some custom styling. Add this to the `Column`. To add a little bit of spacing between the password field and the button, add a `SizedBox` with a height of 8.

```dart
SizedBox(height: 8),
BeerAppButton(
  text: 'Login',
  onClick: () => print('Login button pressed'),
),
```

### Step 5: Login ViewModel

The next step is to add a ViewModel to the `LoginScreen`. This ViewModel will contain the logic for the `LoginScreen`. Create a new file `viewmodel/login/login_viewmodel.dart`.

Before we begin with the ViewModel, take a look at the `SplashViewModel`. This contains a good example of what a ViewModel should look like.

```dart
@injectable // This annotation is used by the dependency injection library, it tells the library that this class can be injected, but isn't a singleton.
class SplashViewModel with ChangeNotifierEx { // ChangeNotifierEx is a custom class that extends ChangeNotifier. A ChangeNotifier is a class that notifies listeners when a value changes. This means that the UI will be rebuild when we call `notifyListeners();`.
  final LoginRepository _loginRepo; // These are some private fields that are injected by the dependency injection library. The library will (create an instance of these classes and) inject them in the constructor.
  final LocalStorage _localStorage;
  final MainNavigator _navigator;

  SplashViewModel(
    this._loginRepo,
    this._localStorage,
    this._navigator,
  );

  Future<void> init() async { // This function is called in the screen when it is created. This is not needed for the LoginViewModel, but is a good example of what a ViewModel should contain.
    await _localStorage.checkForNewInstallation();
    final result = await _loginRepo.isLoggedIn;
    if (result) {
      _navigator.goToHome();
    } else {
      _navigator.goToLogin();
    }
  }
}
```

The `LoginViewModel` will contain the following fields:

```dart
final LoginRepository _loginRepo;
final MainNavigator _navigator;

var _password = '';
var _email = '';
```

The `LoginRepository` is used to log the user in. The `MainNavigator` is used to navigate to the `HomeScreen` after the user is logged in.

The `_password` and `_email` fields are used to store the value of the password and email fields. These fields are prefixed with an underscore to make them private.

Before we continue, we need to update our injectable file. This is automatically generated code by adding the `@injectable` annotation to the `LoginViewModel`. After you added the annotation run the following command in the terminal:

```bash
fvm flutter pub run build_runner build
```

Or run the script `./tool/build_runner.sh` which will run the command for you.

To update `_password` and `_email` we can use the `onChanged` callback of the `BeerAppInputField` widgets. Add the following code to the `LoginScreen` widget:

```dart
  void onEmailUpdated(String email) {
    _email = email;
    notifyListeners();
  }
```

Note that we call `notifyListeners()` after updating the value. This will notify the UI that the value has changed and it will rebuild. Do the same for the password field.

To log the user in, we need to call the `login` function of the `LoginRepository`. Since this may throw an error if the login fails, we need to wrap this in a try-catch block. Add the following code to the `LoginViewModel`:

```dart
Future<void> onLoginClicked() async {
  try {
    await _loginRepo.login(email: _email, password: _password);
    return _navigator.goToHome();
  } catch (e, stack) {
    logger.error('Failed to login', error: e, trace: stack);
  }
}
```

The next step is to add this ViewModel to the `LoginScreen`. To do this, we need to add a `ProviderWidget`. Add the following code to the `LoginScreen` widget:

```dart
@override
Widget build(BuildContext context) {
  return ProviderWidget<LoginViewModel>(
    create: () => getIt()..init(),
    childBuilderWithViewModel: (context, viewModel, theme, localization) => Scaffold(
...
```

Note that there are additional parameters in the `childBuilderWithViewModel` callback. These are the `theme` and `localization` parameters. These are used to access the theme and localization of the app. These will not be covered in this workshop, but you can take a look at our template project to see how this works [icapps Template project](https://github.com/icapps/flutter-template)

We can now change the `onChanged` callbacks of the `BeerAppInputField` widgets to call the `onEmailUpdated` and `onPasswordUpdated` functions of the ViewModel. This is very easy to use: `onChanged: viewModel.onEmailUpdated,`. Do the same for the password field and the button and you will see that we are able to login.

You can expand the login screen with more functionality. For example show a loading indicator when the user is logging in. You can also add an error message when the login fails (look at `showErrorWithLocaleKey`).

### Step 6: Login call

## Extra

### Add LoginGuard and AuthenticationGuards

To automatically redirect the user to the login screen when the user is not logged in, we can use the `AuthenticationGuard`. This guard checks if the user is logged in and if not, it redirects the user to the login screen.

The `LoginGuard` is the opposite of the `AuthenticationGuard`. It checks if the user is logged in and if so, it redirects the user to the home screen.

To add a Guard, look at the following code:

```dart
class LoginGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // TODO: Check if the user is logged in and if so, redirect to the home screen by returning the home route name
  }
}
```

Transform this to a `LoginGuard` and a `AuthenticationGuard` and add them to the `MainNavigator`:

```dart
    BasePage<void>(
      name: LoginScreen.routeName,
      page: () => const FlavorBanner(child: LoginScreen()),
      middlewares: [LoginGuard()],
    ),
```
