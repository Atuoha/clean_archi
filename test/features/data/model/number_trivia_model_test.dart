import 'dart:convert';

import 'package:clean_archi/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/trivia_reader.dart';

void main() {
  NumberTriviaModel numberTriviaModel = NumberTriviaModel.initial();

  test('expect NumberTrivia to be the superclass of NumberTriviaModel', () {
    expect(numberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('test that a valid model is returned when json number is integer', () {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, equals(numberTriviaModel));
    });

    test(
        'test that a valid model is returned when json number is regarded as double',
        () {
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, equals(numberTriviaModel));
    });
  });

  group('toJson', () {
    test('should return a map contain containing the proper data', () {
      final result = numberTriviaModel.toJson();

      expect(result, isA<Map<String,dynamic>>());
    });
  });
}
