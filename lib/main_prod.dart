import 'package:beer_app/app.dart';
import 'package:beer_app/architecture.dart';
import 'package:beer_app/di/environments.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/main_common.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await wrapMain(() async {
    await initArchitecture();
    const values = FlavorValues(
      baseUrl: 'https://beers.icapps-projects.com/api/v1/',
      logNetworkInfo: false,
      showFullErrorMessages: false,
    );
    FlavorConfig(
      flavor: Flavor.prod,
      name: 'PROD',
      color: Colors.transparent,
      values: values,
      supportsTheming: true,
    );
    await configureDependencies(Environments.prod);
    runApp(const MyApp());
  });
}
