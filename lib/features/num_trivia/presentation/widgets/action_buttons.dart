import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.search,
    required this.getRandomTrivia,
    required this.isTextEmpty,
  });

  final Function search;
  final Function getRandomTrivia;
  final bool isTextEmpty;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => search(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isTextEmpty? Colors.orange.shade300: Colors.orange,
          ),
          child: const Text(
            'Search',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => getRandomTrivia(),
          style: ElevatedButton.styleFrom(
            backgroundColor: isTextEmpty? Colors.grey: Colors.grey.shade800,
          ),
          child: const Text(
            'Get Random Trivia',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
