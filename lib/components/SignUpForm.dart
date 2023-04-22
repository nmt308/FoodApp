import 'package:appf_review/services/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          emailTextFormField(),
          SizedBox(
            height: 30,
          ),
          passwordTextFormField(),
          SizedBox(
            height: 30,
          ),
          conformTextFormField(),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              onPressed: () {
                AuthMethods()
                    .signUp(emailController.text, passwordController.text);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.green,
              child: Text(
                "Continue",
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                  child: Image.asset(''),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                  child: Image.asset(''),
                ),
                Container(
                  height: 40,
                  width: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9), shape: BoxShape.circle),
                  child: Image.asset(''),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        }
        return null;
      },
    );
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      key: _passKey,
      controller: passwordController,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outlined),
      ),
      validator: (value) {
        // Perform password validation logic here
        // Example: check if password meets certain criteria
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null; // Return null if password is valid
      },
    );
  }

  TextFormField conformTextFormField() {
    return TextFormField(
      controller: conformController,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outlined),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm password is required';
        } else if (value != passwordController.text) {
          return 'Confirm password does not match';
        }
        return null;
      },
    );
  }
}
