import 'package:flutter/material.dart';
import 'package:weather_air_app/contains/colors.dart';

class IntroduteScreens extends StatelessWidget {
  const IntroduteScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: const Center(
            child: Text(
              "Xin chào tất cả mọi người, đây là một sản phẩm của Đoàn Quang Huy tạo nên, sử dụng ngôn ngữ lập trình Dart và framework Flutter\n Một sản phẩm ra đời với mục đích phục vụ môn học thực tập cơ sở\n App dự báo thời tiết và hiển thị thông tin về không khí dựa theo vị trí của người dùng",
              style: TextStyle(fontSize: 14, color: primaryTextColor),
            ),
          ),
        ));
  }
}
