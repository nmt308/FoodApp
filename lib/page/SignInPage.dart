import 'package:appf_review/components/SignInForm.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                headerScreen(context),
                SignInForm(),
                footerScreen(context)
              ],
            ),
          ),
        )));
  }
}

Widget headerScreen(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Expanded(
        child: Image.asset("assets/images/food_signIn1.png"),
      ));
}

Widget footerScreen(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.3,
    alignment: Alignment.center,
    child: Image.asset("assets/images/food_signIn2.png"),
  );
}
