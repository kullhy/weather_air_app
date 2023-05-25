import 'package:flutter/material.dart';
import 'package:weather_air_app/contains/colors.dart';
import 'package:weather_air_app/models/weather_data_current.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const CurrentWeatherWidget({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tempArea(),
        const SizedBox(
          height: 15,
        ),
        currentMoreArea(),
      ],
    );
  }

  Widget tempArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          // margin: ,
          height: 50,
          width: 1,
          color: Colors.white,
        ),
        Row(
          children: [
            Text(
              "${weatherDataCurrent.current.temp!.toInt()}°",
              style: const TextStyle(
                  fontSize: 68,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor),
            ),
            Text(
              "${weatherDataCurrent.current.weather![0].description}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: secondTextColor),
            )
          ],
        )
      ],
    );
  }

  Widget currentMoreArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Image(
                image: AssetImage("assets/icons/windspeed.png"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${weatherDataCurrent.current.windSpeed} km/h",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: secondTextColor),
            )
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                child: Text(
                  "UV",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 84, 181, 233)),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${weatherDataCurrent.current.uvi}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: secondTextColor),
            )
          ],
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Image(
                image: AssetImage("assets/icons/clouds.png"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${weatherDataCurrent.current.humidity} %",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: secondTextColor),
            )
          ],
        ),
      ],
    );
  }
}
