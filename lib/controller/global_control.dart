import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_air_app/api/featch_weather.dart';
import 'package:weather_air_app/models/weather_data.dart';

class GlobalController extends GetxController {
  late String _unitString;
  late String _lang;

  void updateUnitString(String unitString, String lang) {
    _unitString = unitString;
    _isLoading.value = true;
    getLocation();
    _lang = lang;
    update(); // triggers an update to all GetBuilder and Obx widgets
  }

  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  // ignore: non_constant_identifier_names
  final RxDouble _Longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _Longitude;

  final weatherData = WeatherData().obs;
  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    getLocation();
    getIndex();
    super.onInit();
    updateLocation();
  }

  Future<void> updateLocation() async {
    _isLoading.value = true;
    await getLocation();
  }

  Future<void> getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location not is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _Longitude.value = value.longitude;
      _lattitude.value = value.latitude;

      return FeatchWeatherAPI(_unitString, _lang)
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
        // print("${weatherData().getAirData().lista.ma} hhhhhh");
      });

      // print("huykull");
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }

  // GetFetUrl() {
  //   return FeatchWeatherAPI(_unitString).apiUrl(_lattitude, _Longitude);
  // }
}
