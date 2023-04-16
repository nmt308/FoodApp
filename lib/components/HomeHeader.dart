import 'package:appf_review/page/CartPage.dart';
import 'package:appf_review/page/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            child: TextField(
              decoration: InputDecoration(
                enabled: false,
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Product",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, CartPage.routeName);
          },
          child: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(10),
              child: Icon(Icons.shopping_cart_outlined)),
        ),
      ],
    );
  }
}
