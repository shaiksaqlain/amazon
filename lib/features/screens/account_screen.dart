import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/widgets/below_app_bar.dart';
import 'package:amazon/features/widgets/orders.dart';
import 'package:amazon/features/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/amazon_in.png",
                  width: 120,
                  color: Colors.black,
                  height: 45,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(
            height: 10,
          ),
          TopButtons(),
          SizedBox(
            height: 20,
          ),
          Orders(),
        ],
      ),
    );
  }
}
