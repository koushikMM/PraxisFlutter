import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:praxis_flutter/application/widgets/abstract_plaform_widget.dart';
import 'package:praxis_flutter/routing/routes.dart';

class PraxisApp extends AbstractPlatformWidget<CupertinoApp, MaterialApp> {
  /// Platform dependent app widget (CupertinoApp for iOS, MaterialApp for android)
  const PraxisApp({
    Key? key,
  }) : super(key: key);

  static const String title = 'Praxis';

  @override
  CupertinoApp buildCupertino(BuildContext context) {
    return CupertinoApp.router(
      title: title,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      routeInformationParser: praxisRoutes.routeInformationParser,
      routerDelegate: praxisRoutes.routerDelegate,
    );
  }

  @override
  MaterialApp buildMaterial(BuildContext context) {
    return MaterialApp.router(
      title: title,
      theme: FlexColorScheme.light(scheme: FlexScheme.blueWhale).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.blueWhale).toTheme,
      themeMode: ThemeMode.system,
      routeInformationParser: praxisRoutes.routeInformationParser,
      routerDelegate: praxisRoutes.routerDelegate,
    );
  }
}
