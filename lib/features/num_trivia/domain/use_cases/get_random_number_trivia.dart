import 'package:clean_archi/core/use_cases/use_cases.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  const GetRandomNumberTrivia({required this.numberTriviaRepository});

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams noParams) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}


