import 'dart:convert';

import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_archi/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import '../../../fixtures/trivia_reader.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreference mockSharedPreference;
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;
  final String triviaFixture = fixture('trivia.json');
  final NumberTriviaModel numberTriviaModel =
      NumberTriviaModel.fromJson(jsonDecode(triviaFixture));

  setUp(() {
    mockSharedPreference = MockSharedPreference();
    numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreference,
    );
  });

  test('should return Number Trivia when getNumberTriviaLocalData is called',
      () async {
    when(() => mockSharedPreference.getString(CACHED_NUMBER_TRIVIA)).thenAnswer(
      (_) => triviaFixture,
    );

    final result =
        await numberTriviaLocalDataSourceImpl.getNumberTriviaLocalData;
    verify(() => mockSharedPreference.getString(CACHED_NUMBER_TRIVIA));
    expect(result, equals(numberTriviaModel));
  });
}
