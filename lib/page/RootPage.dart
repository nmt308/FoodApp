import 'package:appf_review/components/HomeHeader.dart';
import 'package:appf_review/page/AccountPage.dart';
import 'package:appf_review/page/FavoritePage.dart';
import 'package:appf_review/page/HomePage.dart';
import 'package:appf_review/page/OrderPage.dart';
import 'package:appf_review/page/NotiPage.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomePage(),
      FavoritePage(),
      NotiPage(),
      OrderPage(),
      AccountPage(),
    ];
    List<dynamic> titles = [
      HomeHeader(),
      HomeHeader(),
      Text("Notifications"),
      Text("Your orders"),
      Text("Account Detail")
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: titles[selectIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          screen[selectIndex]
        ],
      )),
    );
  }
}
