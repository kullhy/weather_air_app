import 'package:flutter/material.dart';

class AirHeader extends StatelessWidget {
  const AirHeader({
    super.key,
    required this.city,
    required this.country,
    required this.dt,
    required this.textcolor,
  });

  final String city;
  final String country;
  final String dt;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: TextStyle(
            fontSize: 35,
            color: textcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          country,
          style: TextStyle(
            fontSize: 20,
            color: textcolor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          dt,
          style: TextStyle(
            fontSize: 16,
            color: textcolor,
          ),
        ),
      ],
    );
  }
}
