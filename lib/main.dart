import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:receitas/screens/home.dart';
import 'package:receitas/screens/cuisines.dart';
import 'package:receitas/screens/recipes.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      builder: (BuildContext context) => MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: Colors.redAccent,
            useMaterial3: true,
          ),
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => Home());
              case '/cuisines':
                final List value = settings.arguments as List;
                return MaterialPageRoute(
                    builder: (context) => Cuisines(title: value));
              case '/recipes':
                final String value = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => Recipes(id: value));
            }
          })));
}
