import 'package:appf_review/model/notification.dart';
import 'package:appf_review/services/firestore_method.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotiPage extends StatefulWidget {
  static String routeName = "/noti";
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<Notifications> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotiItem(notification: notifications[index]);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    FirestoreMethods().getNotifications().then((value) {
      setState(() {
        notifications = value;
      });
    });
  }
}

class NotiItem extends StatelessWidget {
  final Notifications notification;

  NotiItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: Image.network(notification.image),
            ),
            SizedBox(height: 20, width: 20),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${notification.title}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${notification.body}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
