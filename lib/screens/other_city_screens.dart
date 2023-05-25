import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_air_app/api/featch_in_new_city.dart';
import 'package:weather_air_app/api/featch_weather.dart';

import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/air_main.dart';

import 'package:weather_air_app/screens/homescreens_details/current_weather.dart';
import 'package:weather_air_app/screens/homescreens_details/daily_widget.dart';
import 'package:weather_air_app/screens/homescreens_details/hourly_widget.dart';
import 'package:weather_air_app/screens/homescreens_details/more_widget.dart';

import '../models/weather_data.dart';
import 'other_city/header_new_city.dart';

// String unitText = "";

class OtherCityScreens extends StatefulWidget {
  final String unit;
  final String lang;
  final String lat;
  final String lng;
  final String cityName;
  final String country;
  // final cityName = "vinh";
  const OtherCityScreens({
    super.key,
    required this.lang,
    required this.lat,
    required this.lng,
    required this.unit,
    required this.cityName,
    required this.country,
  });
  @override
  State<OtherCityScreens> createState() => _OtherCityScreensState();
}

class _OtherCityScreensState extends State<OtherCityScreens> {
  WeatherData? newCity;
  AirData? airData;
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    featchAirData();
  }

  Future<void> fetchWeatherData() async {
    FeatchInNewCity featchInNewCity =
        FeatchInNewCity(widget.unit, widget.lang, widget.lat, widget.lng);
    WeatherData data = await featchInNewCity.processData();
    setState(() {
      newCity = data;
    });
  }

  Future<void> featchAirData() async {
    FeatchWeatherAPI featchWeatherAPI =
        FeatchWeatherAPI(widget.unit, widget.unit);
    WeatherData data =
        await featchWeatherAPI.processData(widget.lat, widget.lng);
    setState(() {
      if (data.airData != null) {
        airData = data.airData!;
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Container(
        color: primaryColor,
        child: SafeArea(
            child: newCity != null || airData != null
                ? ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      HeaderNewCityWidget(
                        cityName: widget.cityName,
                        country: widget.country,
                        airData: airData,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CurrentWeatherWidget(
                          weatherDataCurrent: newCity!.getCurrentWeather()),
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
                          weatherDataHourly: newCity!.getHourlyWeather()),
                      const SizedBox(
                        height: 20,
                      ),
                      DailyWidget(weatherDataDaily: newCity!.getDailyWeather()),
                      const SizedBox(
                        height: 20,
                      ),
                      MoreWidget(
                          weatherDataCurrent: newCity!.getCurrentWeather()),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
