import 'package:clean_archi/core/error/exceptions.dart';
import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/core/platform/network_info.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_archi/features/num_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_archi/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:clean_archi/features/num_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockNumberTriviaLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;

  const number = 1;
  NumberTriviaModel numberTriviaModel = NumberTriviaModel.initial();
  NumberTrivia numberTrivia = numberTriviaModel;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
      networkInfo: mockNetworkInfo,
      numberTriviaLocalDataSource: mockNumberTriviaLocalDataSource,
      numberTriviaRemoteDataSource: mockNumberTriviaRemoteDataSource,
    );
  });

  // online test
  void runTestOnline(Function body) {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    body();
  }

  // offline test
  void runTestOffline(Function body) {
    setUp(() {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    body();
  }

  // get concrete number trivia
  group('getConcreteNumberTrivia', () {


    test('test if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);
      verify(() => mockNetworkInfo.isConnected);
    });

    // online test ----------------------
    runTestOnline(() {
      test('number trivia should be returned from remote data source',
          () async {
        when(() => mockNumberTriviaRemoteDataSource
            .getConcreteNumberTrivia(number)).thenAnswer(
          (_) async => numberTriviaModel,
        );

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);
        verify(
          () =>
              mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(number),
        );

        expect(result, Right(numberTrivia));
      });

      test(
          'should cache data locally when request from remote data source is successful',
          () async {
        when(() => mockNumberTriviaRemoteDataSource
            .getConcreteNumberTrivia(number)).thenAnswer(
          (_) async => numberTriviaModel,
        );

        await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);
        verify(() =>
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(number));
        verify(() => mockNumberTriviaLocalDataSource
            .cacheNumberTrivia(numberTriviaModel));
      });

      test(
          'should return server error when request from remote data source is unsuccessful',
          () async {
        when(() => mockNumberTriviaRemoteDataSource
            .getConcreteNumberTrivia(number)).thenThrow(
          const ServerException(),
        );

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verify(() =>
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(number));
        verifyZeroInteractions(mockNumberTriviaLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    // offline test ----------------------
    runTestOffline(() {
      test('number trivia should be returned from local data source', () async {
        when(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData)
            .thenAnswer(
          (_) async => numberTriviaModel,
        );

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData);
        expect(result, equals(Right(numberTrivia)));
      });

      test('should return cache failure when there is no data cached locally',
          () async {
        when(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData)
            .thenThrow(const CacheException());

        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(number);

        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData);
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  // get random number trivia
  group('getRandomNumberTrivia', () {
    test('test if device is online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      numberTriviaRepositoryImpl.getRandomNumberTrivia();
      verify(() => mockNetworkInfo.isConnected);
    });

    // online test ----------------------
    runTestOnline(() {
      test('number trivia should be returned from remote data source',
              () async {
            when(() => mockNumberTriviaRemoteDataSource
                .getRandomNumberTrivia()).thenAnswer(
                  (_) async => Future.value(numberTriviaModel),
            );

            final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();
            verify(
                  () =>
                  mockNumberTriviaRemoteDataSource.getRandomNumberTrivia(),
            );

            expect(result, Right(numberTrivia));
          });

      test(
          'should cache data locally when request from remote data source is successful',
              () async {
            when(() => mockNumberTriviaRemoteDataSource
                .getRandomNumberTrivia()).thenAnswer(
                  (_) async => numberTriviaModel,
            );

            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

            verifyInOrder([
                  () =>
                  mockNumberTriviaRemoteDataSource.getRandomNumberTrivia(),
                  () => mockNumberTriviaLocalDataSource
                  .cacheNumberTrivia(numberTriviaModel),
            ]);
          });

      test(
          'should return server error when request from remote data source is unsuccessful',
              () async {
            when(() => mockNumberTriviaRemoteDataSource
                .getRandomNumberTrivia()).thenThrow(
              const ServerException(),
            );

            final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

            verify(() =>
                mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
            verifyZeroInteractions(mockNumberTriviaLocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });

    // offline test ----------------------
    runTestOffline(() {
      test('number trivia should be returned from local data source', () async {
        when(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData)
            .thenAnswer(
              (_) async => numberTriviaModel,
        );

        final result =
        await numberTriviaRepositoryImpl.getRandomNumberTrivia();

        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        verify(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData);
        expect(result, equals(Right(numberTrivia)));
      });

      test('should return cache failure when there is no data cached locally',
              () async {
            when(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData)
                .thenThrow(const CacheException());

            final result =
            await numberTriviaRepositoryImpl.getRandomNumberTrivia();

            verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
            verify(() => mockNumberTriviaLocalDataSource.getNumberTriviaLocalData);
            expect(result, equals(Left(CacheFailure())));
          });
    });
  });
}
