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

class FeatchWeatherAPI {
  WeatherData? weatherData;

  final String _unitString;
  final String _lang;
  FeatchWeatherAPI(this._unitString, this._lang);

  // final StreamController<WeatherData> _weatherStreamController =
  //     StreamController.broadcast();

  // Stream<WeatherData> get weatherDataStream =>
  //     _weatherStreamController.stream;

  String apiUrl(var lat, var lon) {
    String url;
    // uc uc1 = new uc();
    url =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apikey&units=$_unitString&exclude=minutely&lang=$_lang";
    return url;
  }

  String apiUrl2(var lat, var lon) {
    String url;
    url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apikey";
    return url;
  }

  Future<WeatherData> processData(lat, lon) async {
    var response1 = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString1 = jsonDecode(response1.body);
    var response2 = await http.get(Uri.parse(apiUrl2(lat, lon)));
    var jsonString2 = jsonDecode(response2.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromjson(jsonString1),
      WeatherDataHourly.fromjson(jsonString1),
      WeatherDataDaily.fromjson(jsonString1),
      AirData.fromjson(jsonString2),
    );
    return weatherData!;
  }
}
