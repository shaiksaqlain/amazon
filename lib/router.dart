import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/features/admin/screens/add_a_product.dart';
import 'package:amazon/features/screens/auth_screen.dart';
import 'package:amazon/features/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddProduct.routeName:
      return MaterialPageRoute(builder: (_) => const AddProduct());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text("Page 404 not found")),
              ));
  }
}
