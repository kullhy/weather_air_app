import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/weather_data_current.dart';

class MoreWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const MoreWidget({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(35),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                appearance: CircularSliderAppearance(
                    infoProperties: InfoProperties(
                        bottomLabelText: 'humidity'.tr,
                        bottomLabelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                        trackColor: primaryColor,
                        progressBarColors: [primaryColor, Colors.white])),
              ),
              SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: 91,
                appearance: CircularSliderAppearance(
                    infoProperties: InfoProperties(
                        bottomLabelText: 'air'.tr,
                        bottomLabelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                        trackColor: primaryColor,
                        progressBarColors: [primaryColor, Colors.white])),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Moreitem(
                image: "feelslike",
                moreName: 'feels_like'.tr,
                moreDetail: weatherDataCurrent.current.feelsLike!.toInt(),
              ),
              Moreitem(
                image: "pressure",
                moreName: 'pressure'.tr,
                moreDetail: weatherDataCurrent.current.pressure!.toInt(),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Moreitem extends StatelessWidget {
  final String image;
  final String moreName;
  final int moreDetail;
  const Moreitem(
      {super.key,
      required this.image,
      required this.moreName,
      required this.moreDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 140,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: cardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            image: AssetImage("assets/icons/$image.png"),
            height: 25,
            width: 35,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "$moreName\n",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: primaryTextColor)),
              TextSpan(
                text: "$moreDetail",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
