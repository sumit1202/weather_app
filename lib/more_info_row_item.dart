import 'package:flutter/material.dart';

class MoreInfoRowItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String labelvalue;
  const MoreInfoRowItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.labelvalue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            labelvalue,
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
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
