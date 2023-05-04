import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/air_main.dart';

class DetailsAirScreens extends StatelessWidget {
  const DetailsAirScreens(
      {super.key, required this.airData, required this.textcolor});
  final AirData airData;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: textcolor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Chi tiết",
              style: TextStyle(
                  color: textcolor, fontSize: 20, fontWeight: FontWeight.w100),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 30, right: 35, bottom: 35),
          // height: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Column(children: [
            ItemDetailWidget(
              iteamName: "PM2.5",
              iteamInfo: 'pm2.5'.tr,
              iteamIndex: airData.lista[0].components?.pm25,
              iteamIndexMax: 0.75,
            ),
            ItemDetailWidget(
              iteamName: "CO",
              iteamInfo: "(Carbon Monoxide)\n",
              iteamIndex: airData.lista[0].components?.co,
              iteamIndexMax: 154,
            ),
            ItemDetailWidget(
              iteamName: "NO2",
              iteamInfo: "(Nitrogen Dioxide)\n",
              iteamIndex: airData.lista[0].components?.no2,
              iteamIndexMax: 2,
            ),
            ItemDetailWidget(
              iteamName: "O3",
              iteamInfo: "(Ozone)\n",
              iteamIndex: airData.lista[0].components?.o3,
              iteamIndexMax: 1.8,
            ),
            ItemDetailWidget(
              iteamName: "PM10",
              iteamInfo: 'pm10'.tr,
              iteamIndex: airData.lista[0].components?.pm10,
              iteamIndexMax: 2,
            ),
            ItemDetailWidget(
              iteamName: "SO2",
              iteamInfo: "(Sulful Dioxide)\n",
              iteamIndex: airData.lista[0].components?.so2,
              iteamIndexMax: 3.5,
            ),
            ItemDetailWidget(
              iteamName: "NH3",
              iteamInfo: "(Amonia)\n",
              iteamIndex: airData.lista[0].components?.nh3,
              iteamIndexMax: 1,
            ),
          ]),
        )
      ],
    );
  }
}

class ItemDetailWidget extends StatelessWidget {
  const ItemDetailWidget({
    super.key,
    required this.iteamName,
    required this.iteamIndex,
    required this.iteamIndexMax,
    required this.iteamInfo,
  });

  // final AirData airData;
  final String iteamName;
  final String iteamInfo;
  final double? iteamIndex;
  final double iteamIndexMax;

  @override
  Widget build(BuildContext context) {
    double percent = iteamIndex! / iteamIndexMax;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          SleekCircularSlider(
            min: 0,
            max: percent < 100 ? 100 : 200,
            initialValue: iteamIndex! / iteamIndexMax,
            appearance: CircularSliderAppearance(
                angleRange: 360,
                size: 50,
                customColors: CustomSliderColors(
                    trackColor: Colors.red,
                    progressBarColors: [Colors.green, Colors.green])),
          ),
          const SizedBox(
            width: 15,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "$iteamName\n",
                style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: iteamInfo,
                style: const TextStyle(
                    overflow: TextOverflow.clip,
                    color: primaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
              TextSpan(
                text: "$iteamIndex μg/m3",
                style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
