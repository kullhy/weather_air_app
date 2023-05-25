import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:weather_air_app/contains/colors.dart';

import 'package:weather_air_app/screens/other_city_screens.dart';
import 'dart:convert';

import '../../models/city/city.dart';

import 'package:flutter/material.dart';

Future<List<City>> loadCities() async {
  String jsonString = await rootBundle.loadString('assets/json/vn.json');
  final jsonList = json.decode(jsonString) as List<dynamic>;
  return jsonList.map((e) => City.fromJson(e)).toList();
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.unitn, required this.langn});
  final String unitn;
  final String langn;

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<City> cities;
  List<City> filteredCities = [];

  @override
  void initState() {
    super.initState();
    loadCities().then((loadedCities) {
      setState(() {
        cities = loadedCities;
        filteredCities = cities;
      });
    });
  }

  void filterCities(String query) {
    setState(() {
      filteredCities = cities
          .where(
              (city) => city.city!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text(
          'Search Cities',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterCities,
              decoration: InputDecoration(
                hintText: 'enter_city_name'.tr,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (BuildContext context, int index) {
                final city = filteredCities[index];
                return ListTile(
                  title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city.city!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          city.adminName!,
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[850]),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ]),
                  onTap: () {
// Xử lý khi người dùng chọn một thành phố
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtherCityScreens(
                          lang: widget.langn,
                          lat: city.lat!,
                          lng: city.lng!,
                          unit: widget.unitn,
                          cityName: city.city!,
                          country: city.country!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
