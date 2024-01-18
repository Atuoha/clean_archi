import 'package:flutter/material.dart';


class NumberTriviaDesc extends StatelessWidget {
  const NumberTriviaDesc({
    super.key,
    required this.numberTrivia,
  });

  final String numberTrivia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        child: Text(
          numberTrivia,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 23,
          ),
        ),
      ),
    );
  }
}
