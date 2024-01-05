import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/core/use_cases/use_cases.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  const GetConcreteNumberTrivia({required this.numberTriviaRepository});

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}


