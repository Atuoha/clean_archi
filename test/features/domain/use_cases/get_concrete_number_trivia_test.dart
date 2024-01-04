import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_archi/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_archi/core/error/failure.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia useCase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  int number = 1;
  NumberTrivia numberTrivia = NumberTrivia.initial();

  setUp(() => {
        mockNumberTriviaRepository = MockNumberTriviaRepository(),
        useCase = GetConcreteNumberTrivia(
            numberTriviaRepository: mockNumberTriviaRepository),
      });

  test('Test for get concrete number trivia', () async {
    when(() => mockNumberTriviaRepository.getConcreteNumberTrivia(number))
        .thenAnswer(
      (_) async => Right<Failure, NumberTrivia>(numberTrivia),
    );

    final result = await useCase(number: number);

    expect(result, Right(numberTrivia));
    verify(() => mockNumberTriviaRepository.getConcreteNumberTrivia(number));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
