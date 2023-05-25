import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/controller/global_control.dart';
import 'package:weather_air_app/screens/homescreens_details/air_quality_widget.dart';
import 'package:weather_air_app/screens/homescreens_details/current_weather.dart';
import 'package:weather_air_app/screens/homescreens_details/daily_widget.dart';
import 'package:weather_air_app/screens/homescreens_details/header.dart';
import 'package:weather_air_app/screens/homescreens_details/hourly_widget.dart';
import 'package:weather_air_app/screens/homescreens_details/more_widget.dart';
import 'package:weather_air_app/screens/menu_sidebar.dart';
import 'package:weather_air_app/screens/other_city/search_city_screens.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// String unitText = "";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _unitString = 'metric';
  String _lang = 'vi';
  int _selectedIndex = 0;
  int _selectedIndexLang = 0;
  bool _isNoti = true;
  // late Timer _timer;

  final GlobalController globalController = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
    _loadSavedData();
    _showNotification();
    _setupDailyNotification();
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int toggleButtonIndex = prefs.getInt('toggleButtonIndex') ?? 0;
    String unitString = prefs.getString('unitString') ?? 'metric';

    int toggleButtonIndexLang = prefs.getInt('toggleButtonIndexLang') ?? 0;
    String lang = prefs.getString('lang') ?? 'vi';
    setState(() {
      _selectedIndex = toggleButtonIndex;
      _unitString = unitString;
      _selectedIndexLang = toggleButtonIndexLang;
      _lang = lang;
      var locale = Locale(_lang);
      Get.updateLocale(locale);
    });
    globalController.updateUnitString(_unitString, _lang);
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('toggleButtonIndex', _selectedIndex);
    await prefs.setString('unitString', _unitString);

    await prefs.setInt('toggleButtonIndexLang', _selectedIndexLang);
    await prefs.setString('lang', _lang);
  }

  @override
  Widget build(BuildContext context) {
    // String _unitString = "metric";
    return Scaffold(
      drawer: MenuSidebar(
        // buttonValues: _buttonValues,
        selectedIndex: _selectedIndex,
        onSelectionChanged: (int index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              _unitString = 'metric';
            } else if (index == 1) {
              _unitString = 'imperial';
            } else {
              _unitString = 'null';
            }
          });
          globalController.updateUnitString(_unitString, _lang);
          _saveData(); // Lưu giá trị mới khi toggle button được chọn
        },
        //lang
        selectedIndexLang: _selectedIndexLang,
        onSelectionChangedLang: (int index) {
          setState(() {
            _selectedIndexLang = index;
            if (index == 0) {
              _lang = 'vi';
            } else {
              _lang = 'en';
            }
          });
          globalController.updateUnitString(_unitString, _lang);
          var locale = Locale(_lang);
          Get.updateLocale(locale);
          _saveData(); // Lưu giá trị mới khi toggle button được chọn
        },
        isNoti: _isNoti,
        onSelectionChangedisNoti: (value) {
          setState(() {
            _isNoti = value;
            if (_isNoti == true) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Myapp1()),
              );
            }
          });
        },
      ),
      // backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          "W.A.I",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            langn: _lang,
                            unitn: _unitString,
                          )),
                );
              },
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        color: primaryColor,
        child: SafeArea(
          child: Obx(
            () => globalController.checkLoading().isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const HeaderWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'today'.tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      HourlyWiget(
                          weatherDataHourly: globalController
                              .getWeatherData()
                              .getHourlyWeather()),
                      const SizedBox(
                        height: 20,
                      ),
                      DailyWidget(
                          weatherDataDaily: globalController
                              .getWeatherData()
                              .getDailyWeather()),
                      const SizedBox(
                        height: 20,
                      ),
                      MoreWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather(),
                      ),
                      AirQualityWidget(
                          airData:
                              globalController.getWeatherData().getAirData())
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

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

Future<void> _setupDailyNotification() async {
  await AndroidAlarmManager.periodic(
      const Duration(hours: 0), dailyNotificationId, _showNotification,
      startAt: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 23, 36)
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
                  
                },
                child: const Text("show")),
            // ignore: dead_code
            isText ? const Text("xxxxx") : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
