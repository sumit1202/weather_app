import 'package:flutter/material.dart';

class HourlyForecastRowItem extends StatelessWidget {
  final String temperature;
  final IconData icon;
  final String time;
  const HourlyForecastRowItem(
      {super.key,
      required this.temperature,
      required this.icon,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              temperature,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(
              icon,
              size: 35,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              time,
              maxLines: 1,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
