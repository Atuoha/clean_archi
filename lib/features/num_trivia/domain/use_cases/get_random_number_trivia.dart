import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  const GetRandomNumberTrivia({required this.numberTriviaRepository});

  Future<Either<Failure, NumberTrivia>> call() async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}
