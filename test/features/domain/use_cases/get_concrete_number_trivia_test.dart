import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_archi/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;
  int number = 1;
  NumberTrivia numberTrivia = NumberTrivia.initial();

  setUp(() => {
        mockNumberTriviaRepository = MockNumberTriviaRepository(),
        usecase = GetConcreteNumberTrivia(
            numberTriviaRepository: mockNumberTriviaRepository),
      });

  test('Test for get concrete number trivia', () async {

  });
}
