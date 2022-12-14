import 'package:beer_app/database/beer_app_database.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/debug/debug_repository.dart';
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart';
import 'package:beer_app/widget/debug/select_language_dialog.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

@injectable
class DebugViewModel with ChangeNotifierEx {
  final MainNavigator _navigator;
  final DebugRepository _debugRepo;
  final LocalStorage _localStorage;
  final BeerAppDatabase _db;

  var slowAnimationsEnabled = false;

  DebugViewModel(
    this._debugRepo,
    this._navigator,
    this._db,
    this._localStorage,
  );

  Future<void> init() async {
    _initValues();
  }

  void _initValues() {
    slowAnimationsEnabled = _debugRepo.isSlowAnimationsEnabled();
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> onSlowAnimationsChanged(bool enabled) async {
    await _debugRepo.saveSlowAnimations(enabled: enabled);
    _initValues();
  }

  void onTargetPlatformClicked() => _navigator.goToDebugPlatformSelector();

  void onThemeModeClicked() => _navigator.goToThemeModeSelector();

  void onSelectLanguageClicked() => _navigator.showCustomDialog<void>(widget: SelectLanguageDialog(goBack: _navigator.closeDialog));

  void onLicensesClicked() => _navigator.goToLicense();

  void goToDatabase() => _navigator.goToDatabase(_db);

  void resetAnalyticsPermission() => _localStorage.updateHasAnalyticsPermission(null);
}
