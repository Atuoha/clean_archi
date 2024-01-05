import 'package:equatable/equatable.dart';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number,
    required bool found,
  }) : super(text: text, number: number, found: found);

  factory NumberTriviaModel.initial() =>
      const NumberTriviaModel(text: 'Lorem', number: 1, found: false);

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
      'found': found,
    };
  }

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: (json['number'] as num).toInt(),
      found: json['found'],
    );
  }
}
