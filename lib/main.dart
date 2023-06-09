import 'package:appf_review/model/routes.dart';
import 'package:appf_review/page/HomePage.dart';
import 'package:appf_review/page/RootPage.dart';
import 'package:appf_review/page/SignInPage.dart';
import 'package:appf_review/page/splashpage.dart';
import 'package:appf_review/services/auth_method.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message);
  });
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      'add success ${message.notification?.title}+${message.notification?.body}');

  try {
    await FirebaseFirestore.instance.collection('notifications').add({
      'title': message.notification?.title,
      'body': message.notification?.body,
    });
  } catch (e) {
    print('error ${e}');
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
