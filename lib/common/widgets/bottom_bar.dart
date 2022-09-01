// ignore_for_file: depend_on_referenced_packages

import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/screens/account_screen.dart';
import 'package:amazon/features/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 3;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text("Cart Page"),
    ),
  ];

  updatePage(int pagepara) {
    setState(() {
      page = pagepara;
      print(page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: page == 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: bottomBarBorderWidth))),
                  child: const Icon(Icons.person_outline)),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: page == 2
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: Badge(
                    elevation: 0,
                    badgeContent: const Text("5"),
                    badgeColor: Colors.white,
                    child: const Icon(Icons.shopping_cart_outlined)),
              ),
              label: "")
        ],
      ),
    );
  }
}
