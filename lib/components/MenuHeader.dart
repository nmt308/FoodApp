import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Expanded(
              child: Text(
            "Account info",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ]),
      ),
    );
  }
}
