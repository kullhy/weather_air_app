import 'package:get/get.dart';

class Main {
  int? aqi;

  Main({this.aqi});

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json['aqi'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'aqi': aqi,
      };
  String quality() {
    String qua = "";
    switch (aqi) {
      case 1:
        qua = 'aqi1'.tr;
        break;
      case 2:
        qua = 'aqi2'.tr;
        break;
      case 3:
        qua = 'aqi3'.tr;
        break;
      case 4:
        qua = 'aqi4'.tr;
        break;
      case 5:
        qua = 'aqi5'.tr;
        break;
    }
    return qua;
  }
}
