import 'dart:convert';

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.payload,
  }) : super(key: key);
  final String? payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Reminder"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (payload != null) _buildNotifiedReminderCard(payload!),
            if (payload == null)
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "No reminders yet!",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildNotifiedReminderCard(String payload) {
    final data = jsonDecode(payload);
    final title = data["title"];
    final eventDate = data["eventDate"];
    final eventTime = data["eventTime"];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.alarm,
              size: 60.0,
            ),
            const SizedBox(height: 12.0),
            const Text(
              "Your reminder for",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              eventDate,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8.0),
                Text(
                  eventTime,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
