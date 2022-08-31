import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatefulWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  State<AddressBox> createState() => _AddressBoxState();
}

class _AddressBoxState extends State<AddressBox> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Delivary to ${user.name} - ${user.address}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 5,
            top: 2,
          ),
        )
      ]),
    );
  }
}
