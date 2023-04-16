import 'package:appf_review/services/auth_method.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void initState() {
    super.initState();
    String? currentUserEmail = AuthMethods().user.email;
    // Gán giá trị email đăng nhập hiện tại vào emailController
    email.text = currentUserEmail ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        SizedBox(
          height: 30,
        ),
        emailTextFormField(),
        SizedBox(height: 30),
        passwordTextFormField(),
        SizedBox(height: 30),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: MaterialButton(
            onPressed: () {
              AuthMethods().changePassword(password.text);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.green,
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: MaterialButton(
            onPressed: () {
              AuthMethods().signOut(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color.fromARGB(255, 188, 184, 183),
            child: Text(
              "Sign out",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ]),
    ));
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      controller: email,
      enabled: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your Email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
    );
  }
}
