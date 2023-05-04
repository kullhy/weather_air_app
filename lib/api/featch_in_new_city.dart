import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:weather_air_app/api/api_key.dart';

import 'package:weather_air_app/models/air_main.dart';
import 'package:weather_air_app/models/weather_daily_data.dart';
import 'package:weather_air_app/models/weather_data_current.dart';
import 'package:weather_air_app/models/weather_data_hourly.dart';

import '../models/weather_data.dart';


// String x = unitString;

class FeatchInNewCity {
  WeatherData? weatherData;

  final String _unitString;
  final String _lang;
  FeatchInNewCity(this._unitString, this._lang);

  // final StreamController<WeatherData> _weatherStreamController =
  //     StreamController.broadcast();

  // Stream<WeatherData> get weatherDataStream =>
  //     _weatherStreamController.stream;

  

  String apiUrl(var lat, var lon) {
    String url;
    url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=b6adef308b3d93d1e934c43bd49d3800";
    return url;
  }

  Future<WeatherData> processData(lat, lon) async {
    var response1 = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString1 = jsonDecode(response1.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromjson(jsonString1),
      WeatherDataHourly.fromjson(jsonString1),
      WeatherDataDaily.fromjson(jsonString1),
    );
    return weatherData!;
    // _weatherStreamController.add(weatherData!);
  }
  // void dispose() {
  //   _weatherStreamController.close();
  // }
}
