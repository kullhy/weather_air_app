import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/air_main.dart';
import 'package:weather_air_app/screens/air_quality_screens.dart';
import 'package:weather_air_app/screens/homescreens_details/air_quality_widget.dart';

import '../../controller/global_control.dart';

class HeaderNewCityWidget extends StatefulWidget {
  const HeaderNewCityWidget(
      {super.key,
      required this.cityName,
      required this.country,
      required this.airData});
  final String cityName;
  final String country;
  final AirData? airData;

  @override
  State<HeaderNewCityWidget> createState() => _HeaderNewCityWidgetState();
}

class _HeaderNewCityWidgetState extends State<HeaderNewCityWidget> {
  String city = "";
  String country = "";

  String datetime = DateFormat("dd.MM.yyyy hh:mm aaa").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();
    city = widget.cityName;
    country = widget.country;
  }

  // getAddress(lat, lon) async {
  //   List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
  //   Placemark place = placemark[0];
  //   setState(() {
  //     city = place.administrativeArea!;
  //     country = place.country!;
  //   });
  //   // print(place);
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 0),
              alignment: Alignment.topLeft,
              child: Text(
                city,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                    fontSize: 28,
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 0),
              alignment: Alignment.topLeft,
              child: Text(
                country,
                style: const TextStyle(
                  fontSize: 14,
                  color: primaryTextColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 0),
              alignment: Alignment.topLeft,
              child: Text(
                datetime,
                style: const TextStyle(
                  fontSize: 14,
                  color: primaryTextColor,
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => InkWell(
            onTap: () {
              Get.to(AirQualityScreen(
                airData: widget.airData!,
                city: city,
                country: country,
                dt: datetime,
              ));
            },
            child: AirQualityWidget(
              airData: globalController.getWeatherData().getAirData(),
            ),
          ),
        )
      ],
    );
  }
}
