import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/platform/network_info.dart';
import '../models/number_trivia_model.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NetworkInfo networkInfo;
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;

  const NumberTriviaRepositoryImpl({
    required this.networkInfo,
    required this.numberTriviaLocalDataSource,
    required this.numberTriviaRemoteDataSource,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    await networkInfo.isConnected;
    final remoteTrivia =
        await numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);

    numberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia);
    return Right(remoteTrivia);
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
