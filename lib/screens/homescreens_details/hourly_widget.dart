import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/controller/global_control.dart';
// import 'package:get/get.dart';
// import 'package:weather_air_app/models/weather_data_current.dart';
import 'package:weather_air_app/models/weather_data_hourly.dart';

//ignore: must_be_immutable
class HourlyWiget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyWiget({super.key, required this.weatherDataHourly});

  RxInt cardInd = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // child: Text("${weatherDataHourly.hourly[0].temp}"),
      height: 150,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx((() => InkWell(
                onTap: () {
                  cardInd.value = index;
                  // print(CardInd.value);
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cardInd.value == index ? cardColor : Colors.white),
                  child: HourlyDetails(
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    temp: weatherDataHourly.hourly[index].temp!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              )));
        },
      ),
    );
  }
}

//ignore: must_be_immutable
class HourlyDetails extends StatelessWidget {
  int temp;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {super.key,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon});

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(
      timeStamp * 1000000,
    );
    String x = DateFormat("jm").format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text("$temp°"),
        ),
      ],
    );
  }
}
