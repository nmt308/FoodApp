import 'package:appf_review/components/HomeCategories.dart';
import 'package:appf_review/components/HomeProducts.dart';
import 'package:appf_review/services/auth_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [HomeCategories(), HomeProducts()],
      ),
    );
  }
}
