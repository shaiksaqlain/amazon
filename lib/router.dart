import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/auth/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text("Page 404 not found")),
              ));
  }
}
