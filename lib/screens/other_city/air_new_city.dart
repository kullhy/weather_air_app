import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'package:weather_air_app/models/air_main.dart';
import 'package:weather_air_app/screens/air_quality_details/details_screens.dart';

import '../../contains/colors.dart';
import '../air_quality_details/air_header.dart';



class AirNewCity extends StatelessWidget {
  final AirData airData;
  final String city;
  final String country;
  final String dt;

  AirNewCity(
      {super.key,
      required this.airData,
      required this.city,
      required this.country,
      required this.dt});

  final ScrollController _scrollController = ScrollController();

  final lastKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int? aqi = airData.lista[0].main!.aqi;
    Color textcolor = aqi == 2 ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: aqicolor[aqi!],
      appBar: AppBar(
        backgroundColor: aqicolor[aqi],
        elevation: 0,
        title: Text(
          'air_quality'.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textcolor,
          ),
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 35),
          controller: _scrollController,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            AirHeader(
              city: city,
              country: country,
              dt: dt,
              textcolor: textcolor,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AQI",
                      style: TextStyle(
                          color: textcolor,
                          fontSize: 40,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      aqi.toString(),
                      style: TextStyle(
                          color: textcolor,
                          fontSize: 120,
                          fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'aqi'.tr,
                      style: TextStyle(
                          color: textcolor,
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0),
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        clipBehavior: Clip.antiAlias,
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                            width: 2,
                            color: textcolor,
                            style: BorderStyle.solid,
                          )),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15)),
                        ),
                        onPressed: () {
                          add();
                        },
                        child: Text(
                          'click_detail'.tr,
                          style: TextStyle(
                              color: textcolor,
                              fontSize: 14,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 100, left: 50),
                    height: 200,
                    width: 120,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  // Image you need to blur
                  Align(
                    alignment: const Alignment(0, 0),
                    child: Image.asset(
                      "assets/icons/air$aqi.png",
                      height: 300,
                      width: 150,
                    ),
                  ),
                  // BackdropFilter
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  ),
                ]),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            DetailsAirScreens(
              textcolor: textcolor,
              airData: airData,
            ),
          ]),
    );
  }

  void add() {
    SchedulerBinding.instance.addPostFrameCallback((_) => scrollToEnd());
  }

  void scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
