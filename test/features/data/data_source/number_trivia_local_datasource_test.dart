import 'dart:convert';

import 'package:clean_archi/core/constants/string_constants.dart';
import 'package:clean_archi/core/error/exceptions.dart';
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
  final NumberTriviaModel numberTriviaJson =
      NumberTriviaModel.fromJson(jsonDecode(triviaFixture));
  final NumberTriviaModel numberTriviaModel = NumberTriviaModel.initial();

  setUp(() {
    mockSharedPreference = MockSharedPreference();
    numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreference,
    );
  });

  test('should return NumberTrivia when getNumberTriviaLocalData is called',
      () async {
    when(() => mockSharedPreference.getString(AppString.CACHED_NUMBER_TRIVIA)).thenAnswer(
      (_) => triviaFixture,
    );

    final result =
        await numberTriviaLocalDataSourceImpl.getNumberTriviaLocalData;
    verify(() => mockSharedPreference.getString(AppString.CACHED_NUMBER_TRIVIA));
    expect(result, equals(numberTriviaJson));
  });

  test(
      'should throw a CacheException when there is no cache '
      'NumberTrivia when getNumberTriviaLocalData is called', () async {
    when(() => mockSharedPreference.getString(AppString.CACHED_NUMBER_TRIVIA))
        .thenReturn(null);
    expect(
      () async => numberTriviaLocalDataSourceImpl.getNumberTriviaLocalData,
      throwsA(
        const CacheException(),
      ),
    );
  });

  test('should cache NumberTrivia when cacheNumberTrivia is called', () async {
    when(
      () => mockSharedPreference.setString(
        AppString.CACHED_NUMBER_TRIVIA,
        jsonEncode(numberTriviaModel.toJson()),
      ),
    ).thenAnswer(
      (_) async => true,
    );

    numberTriviaLocalDataSourceImpl.cacheNumberTrivia(numberTriviaModel);
    verify(
      () => mockSharedPreference.setString(
        AppString.CACHED_NUMBER_TRIVIA,
        jsonEncode(numberTriviaModel.toJson()),
      ),
    );
  });
}
