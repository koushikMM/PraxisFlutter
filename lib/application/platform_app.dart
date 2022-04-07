import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praxis_flutter/application/widgets/abstract_plaform_widget.dart';
import 'package:praxis_flutter/routing/routes.dart';

class PraxisApp extends AbstractPlatformWidget<CupertinoApp, MaterialApp> {
  /// Platform dependent app widget (CupertinoApp for iOS, MaterialApp for android)
  final String title;

  const PraxisApp({Key? key, this.title = 'Praxis'}) : super(key: key);

  @override
  CupertinoApp buildCupertino(BuildContext context) {
    return CupertinoApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: const CupertinoThemeData(brightness: Brightness.dark),
      routeInformationParser: praxisRoutes.routeInformationParser,
      routerDelegate: praxisRoutes.routerDelegate,
    );
  }

  @override
  MaterialApp buildMaterial(BuildContext context) {
    var lightTheme = FlexColorScheme.light(scheme: FlexScheme.amber).toTheme;
    var darkTheme = FlexColorScheme.dark(scheme: FlexScheme.amber).toTheme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routeInformationParser: praxisRoutes.routeInformationParser,
      routerDelegate: praxisRoutes.routerDelegate,
    );
  }
}