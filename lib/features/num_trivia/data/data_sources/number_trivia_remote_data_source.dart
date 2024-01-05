import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  // concrete number trivia
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  // random number trivia
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
