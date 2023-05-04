class WeatherDataCurrent {
  final Current current;
  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromjson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json["current"]));
}

class Current {
	int? dt;
  
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  // double? dewPoint;
  // int? uvi;
  double? uvi;
  int? visibility;
  double? windSpeed;
  // int? windDeg;
  List<Weather>? weather;

  Current({
    this.dt,
    // this.sunrise,
    // this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    // this.dewPoint,
    // this.uvi,
    this.uvi,
    this.visibility,
    this.windSpeed,
    // this.windDeg,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json['dt'] as int?,
        // sunrise: json['sunrise'] as int?,
        // sunset: json['sunset'] as int?,
        temp: (json['temp'] as num?)?.toDouble(),
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        pressure: json['pressure'] as int?,
        humidity: json['humidity'] as int?,
        // dewPoint: (json['dew_point'] as num?)?.toDouble(),
        // uvi: json['uvi'] as int?,
        uvi: json['uvi'] as double?,
        visibility: json['visibility'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        // windDeg: json['wind_deg'] as int?,
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        // 'sunrise': sunrise,
        // 'sunset': sunset,
        'temp': temp,
        'feels_like': feelsLike,
        'pressure': pressure,
        'humidity': humidity,
        // 'dew_point': dewPoint,
        // 'uvi': uvi,
        'uvi': uvi,
        'visibility': visibility,
        'wind_speed': windSpeed,
        // 'wind_deg': windDeg,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}

// import 'current.dart';
// import 'daily.dart';
// import 'hourly.dart';

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
    // this.hourly,
    // this.daily,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
