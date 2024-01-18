import 'package:flutter/material.dart';

import '../../domain/entities/number_trivia.dart';


class NumberTriviaDisplay extends StatelessWidget {
  const NumberTriviaDisplay({
    super.key,
    required this.numberTrivia,
  });

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height /3.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
          Text(
          numberTrivia.number.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 100,
          ),
        ),
            const SizedBox(height: 10),
            Text(
              numberTrivia.text,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
