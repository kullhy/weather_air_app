import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:weather_air_app/models/weather_daily_data.dart';
import 'package:weather_air_app/models/weather_data_current.dart';
import 'package:weather_air_app/models/weather_data_hourly.dart';


import '../models/weather_data.dart';

// String x = unitString;

class FeatchInNewCity {
  WeatherData? weatherData;

  final String _unitString;
  final String lang;
  final String lat;
  final String lng;
  FeatchInNewCity(this._unitString, this.lang, this.lat, this.lng);

  String apiUrl() {
    String url;
    url =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lng&appid=b6adef308b3d93d1e934c43bd49d3800&units=$_unitString&exclude=minutely&lang=$lang";
    return url;
  }

  Future<WeatherData> processData() async {
    var response1 = await http.get(Uri.parse(apiUrl()));
    var jsonString1 = jsonDecode(response1.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromjson(jsonString1),
      WeatherDataHourly.fromjson(jsonString1),
      WeatherDataDaily.fromjson(jsonString1),
    );
    return weatherData!;
  }
}
