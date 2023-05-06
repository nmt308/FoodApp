import 'dart:async';

import 'package:appf_review/model/products.dart';
import 'package:appf_review/page/CartPage.dart';
import 'package:appf_review/page/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:appf_review/model/carts.dart';

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
        IncreaseNumber()
      ],
    );
  }
}

class IncreaseNumber extends StatefulWidget {
  Products? products;
  IncreaseNumber({this.products});

  @override
  _IncreaseNumberState createState() => _IncreaseNumberState();
}

class _IncreaseNumberState extends State<IncreaseNumber> {
  List cartDetail = Cart().getCart();
  String text = "0";
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (cartDetail.length != null) text = cartDetail.length.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, CartPage.routeName);
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10),
              child: Icon(Icons.shopping_cart_outlined),
            ),
            Positioned(
              left: 37,
              top: 5,
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ));
  }
}
