class WeatherDataHourly {
  List <Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromjson(Map<String, dynamic> json) =>
      WeatherDataHourly(hourly: List<Hourly>.from(json['hourly'].map((e)=> Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  int? temp;
  double? feelsLike;
  // int? pressure;
  int? humidity;
  // double? dewPoint;
  double? uvi;
  // int? clouds;
  // int? visibility;
  // double? windSpeed;
  // int? windDeg;
  // double? windGust;
  List<Weather>? weather;
  // int? pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    // this.pressure,
    this.humidity,
    // this.dewPoint,
    this.uvi,
    // this.clouds,
    // this.visibility,
    // this.windSpeed,
    // this.windDeg,
    // this.windGust,
    this.weather,
    // this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.round(),
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        humidity: json['humidity'] as int?,
        uvi: (json['uvi'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feels_like': feelsLike,
        // 'pressure': pressure,
        'humidity': humidity,
        // 'dew_point': dewPoint,
        'uvi': uvi,
        // 'clouds': clouds,
        // 'visibility': visibility,
        // 'wind_speed': windSpeed,
        // 'wind_deg': windDeg,
        // 'wind_gust': windGust,
        'weather': weather?.map((e) => e.toJson()).toList(),
        // 'pop': pop,
      };
}

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
