import 'package:flutter/material.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/air_main.dart';
import 'package:get/get.dart';

class AirQualityWidget extends StatelessWidget {
  final AirData airData;

  const AirQualityWidget({super.key, required this.airData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 100,
      width: 200,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Image(
                image: AssetImage("assets/icons/airmain.png"),
                height: 20,
                width: 20,
              ),
              Text(
                'air_quality'.tr,
                style: const TextStyle(
                  color: primaryTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            airData.lista[0].main!.quality(),
            style: const TextStyle(
              color: primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
