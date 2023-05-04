import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/weather_daily_data.dart';

class DailyWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyWidget({super.key, required this.weatherDataDaily});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.only(left: 30, right: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cardColor,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'next_day'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          dailyList(),
          // Text("${weatherDataDaily.daily[0].dt}")
        ],
      ),
    );
  }

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(
      timeStamp * 1000000,
    );
    String x = DateFormat("EEE").format(time);
    return x;
  }

  Widget dailyList() {
    return SizedBox(
      height: 330,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weatherDataDaily.daily.length > 7
              ? 7
              : weatherDataDaily.daily.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTime(weatherDataDaily.daily[index].dt),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Image.asset(
                        "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png",
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        "${weatherDataDaily.daily[index].temp?.max!.toInt()}°/${weatherDataDaily.daily[index].temp?.min!.toInt()}°",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
