import 'package:appf_review/page/AllCategoryPage.dart';
import 'package:appf_review/page/AllProductPage.dart';
import 'package:appf_review/page/CartPage.dart';
import 'package:appf_review/page/HomePage.dart';
import 'package:appf_review/page/OrderPage.dart';
import 'package:appf_review/page/ProductPage.dart';
import 'package:appf_review/page/SearchPage.dart';
import 'package:appf_review/page/SignInPage.dart';
import 'package:appf_review/page/SignUpPage.dart';
import 'package:appf_review/page/splashpage.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  SignInPage.routeName: (context) => SignInPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  HomePage.routeName: (context) => HomePage(),
  ProductPage.routeName: (context) => ProductPage(),
  CartPage.routeName: (context) => CartPage(),
  SearchPage.routeName: (context) => SearchPage(),
  OrderPage.routeName: (context) => OrderPage(),
  AllProductPage.routeName: (context) => AllProductPage(),
  AllCategoryPage.routeName: (context) => AllCategoryPage()
};
