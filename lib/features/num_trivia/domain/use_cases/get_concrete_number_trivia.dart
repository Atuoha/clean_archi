import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  const GetConcreteNumberTrivia({required this.numberTriviaRepository});

  Future<Either<Failure, NumberTrivia>> call({required int number}) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
