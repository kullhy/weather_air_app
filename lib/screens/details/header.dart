import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_air_app/contains/colors.dart';

import '../../controller/global_control.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String country = "";

  String datetime = DateFormat("dd.MM.yyyy hh:mm aaa").format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLattitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.administrativeArea ?? "Hà Nội";
      country = place.country ?? "Việt Nam";
    });
    // print(place.administrativeArea);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 0),
          alignment: Alignment.topLeft,
          child: Text(
            city,
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
    );
  }
}
