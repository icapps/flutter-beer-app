import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart';

Future<void> initMiddleWare() async {
  await getIt<AuthStorage>().hasLoggedInUser();
}
