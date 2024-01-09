import 'package:clean_archi/core/error/exceptions.dart';
import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/platform/network_info.dart';
import '../models/number_trivia_model.dart';

typedef _ConcreteOrRandomTrivia = Future<NumberTriviaModel> Function();

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
    return await _getNumberTrivia(
      () => numberTriviaRemoteDataSource.getConcreteNumberTrivia(number),
    );
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getNumberTrivia(
      () => numberTriviaRemoteDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<Failure, NumberTrivia>> _getNumberTrivia(
      _ConcreteOrRandomTrivia getNumberTrivia) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getNumberTrivia();
        // await numberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia =
            await numberTriviaLocalDataSource.getNumberTriviaLocalData;
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
