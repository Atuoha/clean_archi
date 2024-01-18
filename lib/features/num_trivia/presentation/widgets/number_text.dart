import 'package:flutter/material.dart';

class NumberText extends StatelessWidget {
  const NumberText({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Text(
      number,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 100,
      ),
    );
  }
}