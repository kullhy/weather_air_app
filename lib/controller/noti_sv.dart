import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'global_control.dart';

final GlobalController globalController = Get.put(GlobalController());

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

Future<void> _setupDailyNotification() async {
  await AndroidAlarmManager.periodic(
      const Duration(hours: 0), dailyNotificationId, _showNotification,
      startAt: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 20, 09)
          .add(const Duration(days: 0)),
      exact: true,
      wakeup: true);
}

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

class Myapp1 extends StatelessWidget {
  const Myapp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _showNotification();
              _setupDailyNotification();
            },
            child: const Text("show")),
      ),
    );
  }
}
