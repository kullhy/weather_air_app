// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';

// import '../controller/notification_service.dart';
// import 'details_page.dart';
// import 'noti_setting_detail/action_buttons.dart';
// import 'noti_setting_detail/custom_day_picker.dart';
// import 'noti_setting_detail/date_field.dart';
// import 'noti_setting_detail/header.dart';
// import 'noti_setting_detail/time_field.dart';

// class NotiSettingScreens extends StatefulWidget {
//   const NotiSettingScreens({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _NotiSettingScreens createState() => _NotiSettingScreens();
// }

// class _NotiSettingScreens extends State<NotiSettingScreens> {
//   NotificationService notificationService = NotificationService();

//   final int maxTitleLength = 60;
//   // ignore: prefer_final_fields
//   TextEditingController _textEditingController =
//       TextEditingController(text: "Tuỳ chọn...");

//   int segmentedControlGroupValue = 0;

//   DateTime currentDate = DateTime.now();
//   DateTime? eventDate;

//   TimeOfDay currentTime = TimeOfDay.now();
//   TimeOfDay? eventTime;

//   Future<void> onCreate() async {
//     await notificationService.showNotification(
//       0,
//       _textEditingController.text,
//       "Đã tạo một thông báo",
//       jsonEncode({
//         "Tiêu đề": _textEditingController.text,
//         "Ngày": DateFormat("EEEE, d MMM y").format(eventDate!),
//         "Thời gian": eventTime!.format(context),
//       }),
//     );

//     await notificationService.scheduleNotification(
//       1,
//       _textEditingController.text,
//       // ignore: use_build_context_synchronously
//       "tạo thông báo lúc ${eventTime!.format(context)}",
//       eventDate!,
//       eventTime!,
//       jsonEncode({
//         "Tiêu đề": _textEditingController.text,
//         "Ngày": DateFormat("EEEE, d MMM y").format(eventDate!),
//         // ignore: use_build_context_synchronously
//         "Thời gian": eventTime!.format(context),
//       }),
//       getDateTimeComponents(),
//     );

//     resetForm();
//   }

//   Future<void> cancelAllNotifications() async {
//     await notificationService.cancelAllNotifications();
//   }

//   void resetForm() {
//     segmentedControlGroupValue = 0;
//     eventDate = null;
//     eventTime = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Cài đặt thông báo"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const DetailsPage(payload: null),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.library_books_rounded),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Header(),
//                   TextField(
//                     controller: _textEditingController,
//                     maxLength: maxTitleLength,
//                     decoration: InputDecoration(
//                       counterText: "",
//                       suffix: Container(
//                         padding: const EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4.0),
//                           color: Colors.grey[200],
//                         ),
//                         child: Text((maxTitleLength -
//                                 _textEditingController.text.length)
//                             .toString()),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20.0),
//                   CupertinoSlidingSegmentedControl<int>(
//                     onValueChanged: (value) {
//                       if (value == 1) eventDate = null;
//                       setState(() => segmentedControlGroupValue = value!);
//                     },
//                     groupValue: segmentedControlGroupValue,
//                     padding: const EdgeInsets.all(4.0),
//                     children: const <int, Widget>{
//                       0: Text("Một lần"),
//                       1: Text("Hàng ngày"),
//                       2: Text("Hàng tuần")
//                     },
//                   ),
//                   const SizedBox(height: 24.0),
//                   const Text("Ngày giờ"),
//                   const SizedBox(height: 12.0),
//                   GestureDetector(
//                     onTap: selectEventDate,
//                     child: DateField(eventDate: eventDate),
//                   ),
//                   const SizedBox(height: 12.0),
//                   GestureDetector(
//                     onTap: () async {
//                       eventTime = await showTimePicker(
//                         context: context,
//                         initialTime: TimeOfDay(
//                           hour: currentTime.hour,
//                           minute: currentTime.minute + 1,
//                         ),
//                       );
//                       setState(() {});
//                     },
//                     child: TimeField(eventTime: eventTime),
//                   ),
//                   const SizedBox(height: 20.0),
//                   ActionButtons(
//                     onCreate: onCreate,
//                     onCancel: resetForm,
//                   ),
//                   const SizedBox(height: 12.0),
//                   GestureDetector(
//                     onTap: () async {
//                       await cancelAllNotifications();
//                       // ignore: use_build_context_synchronously
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("Tất cả các thông báo đã bị xoá"),
//                         ),
//                       );
//                     },
//                     child: _buildCancelAllButton(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCancelAllButton() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.indigo[100],
//       ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 24.0,
//         vertical: 12.0,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [
//           Text(
//             "Xoá tất cả các thông báo",
//             style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//           Icon(Icons.clear),
//         ],
//       ),
//     );
//   }

//   DateTimeComponents? getDateTimeComponents() {
//     if (segmentedControlGroupValue == 1) {
//       return DateTimeComponents.time;
//     } else if (segmentedControlGroupValue == 2) {
//       return DateTimeComponents.dayOfWeekAndTime;
//     }
//     return null;
//   }

//   void selectEventDate() async {
//     final today =
//         DateTime(currentDate.year, currentDate.month, currentDate.day);
//     if (segmentedControlGroupValue == 0) {
//       eventDate = await showDatePicker(
//         context: context,
//         initialDate: today,
//         firstDate: today,
//         lastDate: DateTime(currentDate.year + 10),
//       );
//       setState(() {});
//     } else if (segmentedControlGroupValue == 1) {
//       eventDate = today;
//     } else if (segmentedControlGroupValue == 2) {
//       CustomDayPicker(
//         onDaySelect: (val) {
//           // print("$val: ${CustomDayPicker.weekdays[val]}");
//           eventDate = today.add(
//               Duration(days: (val - today.weekday + 1) % DateTime.daysPerWeek));
//         },
//       ).show(context);
//     }
//   }
// }
