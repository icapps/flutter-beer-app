import 'package:flutter/material.dart';
import 'package:beer_app/app.dart';
import 'package:beer_app/di/environments.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/main_common.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:beer_app/util/inspector/database_inspector.dart';
import 'package:beer_app/util/inspector/local_storage_inspector.dart';
import 'package:beer_app/util/inspector/niddler.dart';

Future<void> main() async {
  await wrapMain(() async {
    await initNiddler();
    const values = FlavorValues(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      logNetworkInfo: true,
      showFullErrorMessages: true,
    );
    FlavorConfig(
      flavor: Flavor.dev,
      name: 'DEV',
      color: Colors.red,
      values: values,
      supportsTheming: true,
    );
    // ignore: avoid_print
    print('Starting app from main.dart');
    await configureDependencies(Environments.dev);
    await addDatabaseInspector();
    await initAllStorageInspectors();

    runApp(const MyApp());
  });
}
