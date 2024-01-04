import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  // concrete number trivia
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);

  // random number trivia
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
