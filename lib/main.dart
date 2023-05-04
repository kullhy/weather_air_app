import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_air_app/contains/local_string.dart';
// import 'package:weather_air_app/controller/noti_sv.dart';
// import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/screens/home_page.dart';

// import 'controller/notifications_service.dart';ơ

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: const Locale('vi'),
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const HomePage(),
      title: "Weather",
    );
  }
}
