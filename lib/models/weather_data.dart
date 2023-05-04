import 'package:weather_air_app/models/air_main.dart';
import 'package:weather_air_app/models/weather_daily_data.dart';
import 'package:weather_air_app/models/weather_data_current.dart';
import 'package:weather_air_app/models/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  final AirData? airData;

  WeatherData([
    this.current,
    this.hourly,
    this.daily,
    this.airData,
  ]);

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
  AirData getAirData() => airData!;
}
