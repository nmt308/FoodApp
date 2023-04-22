import 'package:appf_review/model/notification.dart';
import 'package:flutter/material.dart';

class NotiPage extends StatefulWidget {
  static String routeName = "/noti";
  const NotiPage({Key? key}) : super(key: key);

  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<NotificationItem> _notifications = [
    NotificationItem(
        title: "Flash sale 30/4", content: "Sale 50% tất cả trà sữa"),
    NotificationItem(
        title: "Flash sale 30/4", content: "Sale 50% tất cả trà sữa"),
    NotificationItem(
        title: "Flash sale 30/4", content: "Sale 50% tất cả trà sữa"),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            return NotiItem(notification: _notifications[index]);
          },
        ),
      ),
    );
  }
}

class NotiItem extends StatelessWidget {
  final NotificationItem notification;

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
              child: Image.network(
                  "https://cdn.tgdd.vn/hoi-dap/1311826/flashsale-la-gi-vao-nhung-ngay-nao-cach-san-flashsale22.jpg"),
            ),
            SizedBox(height: 20, width: 20),
            Expanded(
              child: SizedBox(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiêu đề: ${notification.title}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Nội dung: ${notification.content}',
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
