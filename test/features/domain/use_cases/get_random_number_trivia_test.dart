import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRandomNumberTrivia extends Mock
    implements NumberTriviaRepository {}

void main() {
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late GetRandomNumberTrivia useCase;
  NumberTrivia numberTrivia = NumberTrivia.initial();

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    useCase = GetRandomNumberTrivia(
        numberTriviaRepository: mockGetRandomNumberTrivia);
  });

  test('Test for get random number trivia', () async {
    when(() => mockGetRandomNumberTrivia.getRandomNumberTrivia()).thenAnswer(
      (invocation) async => Right(numberTrivia),
    );

    final result = await useCase();
    expect(result, Right(numberTrivia));
    verify(() => mockGetRandomNumberTrivia.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockGetRandomNumberTrivia);
  });
}
