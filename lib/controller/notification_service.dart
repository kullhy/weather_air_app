import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final GlobalController globalController = Get.put(GlobalController());

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const int dailyNotificationId = 0;

@override
void initState() {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


// ignore: unused_element
Future<void> _showNotification() async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id', 'your channel name',
      importance: Importance.high, priority: Priority.high);

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      0, 'Notification title', 'Notification body', platformChannelSpecifics,
      payload: 'item x');
}

class Myapp1 extends StatefulWidget {
  const Myapp1({super.key});

  @override
  State<Myapp1> createState() => _Myapp1State();
}

class _Myapp1State extends State<Myapp1> {
  @override
  Widget build(BuildContext context) {
    bool isText = true;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isText = !isText;
                    // print("click noti ok");
                    _showNotification();
                    // _setupDailyNotification();
                  });
                  // print(isText);
                },
                child: const Text("show")),
            isText ? const Text("xxxxx") : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
