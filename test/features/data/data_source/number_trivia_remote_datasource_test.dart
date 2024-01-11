import 'dart:convert';

import 'package:clean_archi/core/error/exceptions.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_archi/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:integration_test/common.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/trivia_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;
  int number = 1;
  final String triviaFixture = fixture('trivia.json');
  final NumberTriviaModel numberTriviaJson =
      NumberTriviaModel.fromJson(jsonDecode(triviaFixture));
  final NumberTriviaModel numberTriviaModel = NumberTriviaModel.initial();

  setUp(() {
    mockClient = MockHttpClient();
    numberTriviaRemoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });

  // CONCRETE ----------------
  group('getConcreteNumberTrivia', () {
    test(
        'should check if a GET request is successful '
        'when called using number endpoint and application/json content-type ',
        () async {
      when(
        () => mockClient.get(
          Uri.parse('$URL/$number'),
          headers: headers,
        ),
      ).thenAnswer(
        (_) async => http.Response(triviaFixture, 200),
      );

      numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(number);
      verify(
        () => mockClient.get(
          Uri.parse('$URL/$number'),
          headers: headers,
        ),
      );
    });

    test(
        'should return a concrete NumberTrivia when getConcreteNumberTrivia is called and status code is 200',
        () async {
      when(
        () => mockClient.get(
          Uri.parse('$URL/$number'),
          headers: headers,
        ),
      ).thenAnswer(
        (_) async => http.Response(triviaFixture, 200),
      );

      final result = await numberTriviaRemoteDataSourceImpl
          .getConcreteNumberTrivia(number);
      verify(
        () => mockClient.get(
          Uri.parse('$URL/$number'),
          headers: headers,
        ),
      );
      expect(result, equals(numberTriviaModel));
    });

    test(
        'should return ServerException when getConcreteNumberTrivia '
        'is called and there is an error', () async {
      when(() => mockClient.get(
            Uri.parse('$URL/$number'),
            headers: headers,
          )).thenAnswer(
        (_) async => http.Response('Something went wrong!', 404),
      );

      expect(
        ()  async => numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(number),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });

  // RANDOM -----------------
  group('getRandomNumberTrivia', () {
    test(
        'should return a random NumberTrivia when getRandomNumberTrivia is called and status code is 200',
        () async {
      when(() => mockClient.get(
            Uri.parse('$URL/random'),
            headers: headers,
          )).thenAnswer(
        (_) async => http.Response(triviaFixture, 200),
      );

      final result =
          await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();
      verify(
        () => mockClient.get(
          Uri.parse('$URL/random'),
          headers: headers,
        ),
      );
      expect(result, equals(numberTriviaModel));
    });

    test(
        'should return ServerException when getRandomNumberTrivia '
        'is called and there is an error', () async {
      when(() => mockClient.get(
            Uri.parse('$URL/random'),
            headers: headers,
          )).thenAnswer(
        (_) async => http.Response('Something went wrong!', 404),
      );

      expect(
        () async => numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia(),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
