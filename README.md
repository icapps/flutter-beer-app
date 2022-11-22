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

The API is available at [API DOCUMENTATION](https://icapps-nodejs-beers-api.herokuapp.com/api/v1/documentation/#/).

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

You will also need to add `goToLogin()` in `MainNavigator`:

```dart
  void goToLogin() async => Get.offNamed<void>(LoginScreen.routeName);
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

*Note: `onChanged` requires a function. You can enter the following values: `(value) { print(value); }`, `(value) => print(value)` or simply provide the print function itself `onChanged: print,`. All of these are valid, to have a more clear codebase we prefer the last option.*

When you enter text in the field, you should see the value printed in the console:

![Email field](/assets_workshop/login_prints.png)

You can add the password field in the same way.

If you run this on a device with rounded corners or notch, you will see that the input field is not entirely visible. To fix this, we can add a `SafeArea` widget. This widget ensures that the content is not covered by the device's status bar. Add a `SafeArea` between the Scaffold and Column widget to fix this:

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

We are almost complete with the login, the next step is to add the login call. API calls contain a lot of boiler plate, so for this step we will use quite a lot of code generation. First is the response model. Open `config.yaml` and add the following code:

```yaml
LoginResponse:
  path: webservice/login
  properties:
    access_token: string
    refresh_token: string
```

Running `tool/model_generator.sh` will then generate the `LoginResponse` model. This model contains the `access_token` and `refresh_token` fields. These are the fields that we need to store in the `LocalStorage`. It will also generate JSON convertion code for this model.

*Note: For more information about the `config.yaml` file and model generation, take a look at [model_generator](https://pub.dev/packages/model_generator).*

*Note: If the model_generator script ends with `pub finished with exit code 65` you need to run `./tool/build_runner_build.sh` manually. `model_generator` will try to run build_runner, but uses the default flutter instance and not fvm. So if these are incompatible the model_generator will show an error. Model generator will still be successful regardless of this (unless you see a different error ofcourse).*

Now we can create our abstract class for the `LoginRepository`. Create a new file `service/login/login_service.dart` and add the following code:

```dart
abstract class LoginService {
  Future<LoginResponse> login(String email, String password);
}
```

Then create a new file `service/login/login_webservice.dart` and add the following code:

```dart
part 'login_webservice.g.dart';

@Singleton(as: LoginService)
@RestApi()
abstract class LoginWebService extends LoginService {
  @factoryMethod
  factory LoginWebService(Dio dio) = _LoginWebService;

  @override
  @POST('/login')
  Future<LoginResponse> login(String email, String password);
}
```

You need to rerun the `tool/build_runner_build.sh` script to generate the `_LoginWebService` class which includes the actual API code.

TODO: Update body and endpoint

The final step is to add the `LoginService` to the `LoginRepository`. By now you should know how to add the service to the repository. If not, look at `AuthStorage` inside the `LoginRepository` class.

Try to implement the `login` function of the `LoginRepository` yourself. In the end it should look something like this:

```dart
Future<void> login({required String email, required String password}) async {
  final tokens = await _loginService.login(email, password);
  await _storage.saveUserCredentials(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken);
}
```

Now the login should work. You can test this by running the app and logging in with the credentials provided above. If you implemented the error handling in the `LoginViewModel` you can also test this now by providing incorrect credentials.

If you are testing on a device/emulator and want to login again, you can clear the app storage to reset the app or uninstall and reinstall the app.

### Step 7: Beers overview

We've gone through everything we need to know to create the beers overview screen. This screen will show a list of beers. We will use a `BeerRepository` to get the beers. The `BeerRepository` will use a `BeerService` to get the beers from the API. The `BeerService` will use a `BeerWebService` to make the actual API call.

First create a model for the beer in `config.yaml`. See the swagger documentation to see the fields of the beer.

Second, create a `BeersOverviewScreen` widget. Change the `TodoListScreen()` on the HomeScreen to `BeersOverviewScreen()`.

Add a list in the `BeersOverviewScreen` widget (hint, use `ListView.builder`). Hardcode some beers in the list for now. Then create a `BeerItem` widget that takes a `Beer` as a parameter. This widget should show the name of the beer and an image.

If this works, create a `BeersOverviewViewModel` and add it to the `BeersPage` widget. The `BeersOverviewViewModel` should load the beers (first hardcoded like you did in `BeersOverviewScreen`). Hint: don't forget to run `tool/build_runner_build.sh` after adding the `@injectable` annotation.

Create a Repository and Service for the beers. Load the beers from the API and see if you can show the beers in the `BeersOverviewScreen`.

## Extra

### Logout

To logout, we just need to clear the `LocalStorage`. This can be done by calling the `clear` function of the `LocalStorage`. Add a button in the app and call this function when the button is pressed.

### LoginGuard and AuthenticationGuards

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

### Refresh token

There is a `NetworkRefreshInterceptor` that will automatically try to refresh the access token when you do a call that returns an `Unauthorized` response. This is done by calling the `refresh` function of the `RefreshRepository`. You will see the following code in the `RefreshRepository`:

```dart
await _authStorage.getRefreshToken();
// TODO implement refresh call
// await _authStoring.saveRefreshToken(refreshToken: result.refreshToken, accessToken: result.accessToken);
throw UnimplementedError('No implementation for the refresh in the refresh repository');
```

Implement the refresh call and update the above code to refresh expired tokens.

### Save list to database

Now every time you open the overview screen, we do an API call to get the beers. This is not very efficient. The better way of doing this is doing an API call after a user logs in and/or on the splash screen. Then we can save the beers to the database. This way we can show the beers from the database when the user opens the overview screen.

First you need to create a Table. See `DbTodoTable` for inspiration. Note: you need to add your table to `BeerAppDatabase` annotation and run `./tool/build_runner_build.sh` to generate the database models. Then add an extension on the database model and our generated model.

To save and load the beers from the database, you need a dao. See `TodoDaoStorage` for more information.

Now you can save the beers to the database after a user logs in. You can load the beers from the database in the `BeersOverviewViewModel`.

#### Stream

If you use a stream in your BeersDao, you can listen to any changes in the database. This way you can update the UI automatically when the database changes. This is a very powerful feature.

### Switch between list and grid

You have more options than a `ListView.builder`. Another great way to visualize a list is a `GridView.builder`. You can add this and switch between a list and a grid view. Add a button to the `BeersOverviewScreen` that switches between the list and grid view.

### Add a beer detail

There are two options for this. When you click on a beer, you can go to a new screen with the details of the beer. Or you can add a bottom sheet (or dialog) that shows the details of the beer. Feel free to try both.

### Add new beer

Create a new page that allows the user to add a new beer. Add a Floating Action Button to the `BeersOverviewScreen` that opens this page. 

If you've implemented a database with a Stream, you can add the new beer to the database and the UI will automatically update.

Otherwise you can return the beer from the new beer page and add it to the list of beers in the `BeersOverviewViewModel`.

### Theming

The app already contains code for theming and light/dark mode. Add some new colors to the theme and use them in the app. You can also add a button to switch between light and dark mode.

### Icons

To add your own launch icons, replace the files in assets_launcher_icons/.

You can also change the adaptive_icon_background in the flutter_launcher_icons-{flavor}.yaml (currently "#CB2E63") (only available for Android 8.0 devices and above)

After this, run the following command

```dart
fvm flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-dev.yaml
```

### Tests

You will notice that there are quite a few tests in the project. You can run the tests by running `fvm flutter test` in the root of the project. Since you've added a lot of new code, the current tests will likely fail. Try to fix the tests and add new tests for the new code you've added.

### Fastlane

The project uses Fastlane to automate the build process. You can run the following commands:

```bash
fastlane ci_alpha
```

This will build alpha versions of the app for Android and iOS. You can find the APK and IPA in the `build` folder.

It can also be configured to upload directly to appcenter. We use this script on our build server, so it is automatically build and uploaded to appcenter.
