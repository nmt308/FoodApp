import 'package:appf_review/model/routes.dart';
import 'package:appf_review/page/HomePage.dart';
import 'package:appf_review/page/RootPage.dart';
import 'package:appf_review/page/SignInPage.dart';
import 'package:appf_review/page/splashpage.dart';
import 'package:appf_review/services/auth_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routes: routes,
        home: StreamBuilder(
          //Lắng nghe luồng dữ liệu được publish từ AuthMethods
          stream: AuthMethods().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return RootPage();
            }
            return SignInPage();
          },
        ));
  }
}
