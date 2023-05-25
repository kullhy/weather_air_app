import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather_air_app/contains/colors.dart';

import 'package:weather_air_app/screens/menu_details/info_screens.dart';

const List<Widget> units = <Widget>[Text('°C'), Text('°F'), Text('°K')];
const List<Widget> lang = <Widget>[Text('Vi'), Text('En')];

// String unitString = "";

class MenuSidebar extends StatelessWidget {
  const MenuSidebar(
      {super.key,
      required this.selectedIndex,
      required this.onSelectionChanged,
      required this.selectedIndexLang,
      required this.onSelectionChangedLang,
      required this.onSelectionChangedisNoti,
      required this.isNoti});
  final int selectedIndex;
  final Function(int) onSelectionChanged;

  final int selectedIndexLang;
  final Function(int) onSelectionChangedLang;

  final bool isNoti;
  final Function(bool) onSelectionChangedisNoti;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.00),
                  ),
                  child: Image.asset(
                    "assets/icons/clouds.png",
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Weather Air\nInfomation",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 0.5,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(134, 180, 180, 180)),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/feelslike.png",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'temp'.tr,
                          style: const TextStyle(
                              color: primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        onSelectionChanged(index);
                      },
                      isSelected: <bool>[
                        selectedIndex == 0,
                        selectedIndex == 1,
                        selectedIndex == 2,
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      selectedBorderColor: secondColor,
                      selectedColor: Colors.white,
                      fillColor: secondColor,
                      color: secondColor,
                      constraints: const BoxConstraints(
                        minHeight: 20.0,
                        minWidth: 40.0,
                      ),
                      children: units,
                    ),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'noti'.tr,
                        style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Switch(
                    value: isNoti,
                    onChanged: onSelectionChangedisNoti,
                    activeTrackColor: primaryColor,
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/lang.png",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'lang'.tr,
                          style: const TextStyle(
                              color: primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        onSelectionChangedLang(index);
                      },
                      isSelected: <bool>[
                        selectedIndexLang == 0,
                        selectedIndexLang == 1,
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      selectedBorderColor: secondColor,
                      selectedColor: Colors.white,
                      fillColor: secondColor,
                      color: secondColor,
                      constraints: const BoxConstraints(
                        minHeight: 20.0,
                        minWidth: 40.0,
                      ),
                      children: lang,
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 0.5,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(134, 180, 180, 180)),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IntroduteScreens()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'info'.tr,
                      style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Controller extends GetxController {
//   var count = 0;
//   void increment() {
//     count++;
//     update();
//   }
// }
