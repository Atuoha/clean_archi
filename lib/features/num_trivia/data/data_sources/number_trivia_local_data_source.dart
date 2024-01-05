import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> get getNumberTriviaLocalData;

  Future<void> setNumberTriviaLocalData(NumberTriviaModel numberTriviaModel);
}
