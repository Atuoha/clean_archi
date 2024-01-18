import 'package:bloc_test/bloc_test.dart';
import 'package:clean_archi/core/constants/enums/processing_state.dart';
import 'package:clean_archi/core/constants/error_msg.dart';
import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/core/use_cases/use_cases.dart';
import 'package:clean_archi/core/utils/input_converter.dart';
import 'package:clean_archi/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:clean_archi/features/num_trivia/domain/entities/number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:clean_archi/features/num_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInputConverter extends Mock implements InputConverter {}

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

void main() {
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc numberTriviaBloc;
  NumberTrivia numberTrivia = NumberTrivia.initial();

  String numberString = '1';
  int number = 1;
  String negativeNumberString = '-1';

  final NumberTriviaModel numberTriviaModel = NumberTriviaModel.initial();

  NumberTriviaState waitingState = NumberTriviaState(
    numberTrivia: NumberTriviaModel.initial(),
    processingState: ProcessingState.loading,
  );

  NumberTriviaState successState = NumberTriviaState(
    numberTrivia: NumberTriviaModel.initial(),
    processingState: ProcessingState.success,
  );

  NumberTriviaState inputErrorState = NumberTriviaState(
    numberTrivia: NumberTriviaModel.initial(),
    processingState: ProcessingState.error,
    errorMsg: ErrorMsg.INPUT_CONVERTER_ERROR_MSG,
  );

  NumberTriviaState serverErrorState = NumberTriviaState(
    numberTrivia: NumberTriviaModel.initial(),
    processingState: ProcessingState.error,
    errorMsg: ErrorMsg.SERVER_ERROR_MSG,
  );

  NumberTriviaState cacheErrorState = NumberTriviaState(
    numberTrivia: NumberTriviaModel.initial(),
    processingState: ProcessingState.error,
    errorMsg: ErrorMsg.CACHE_ERROR_MSG,
  );

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockInputConverter = MockInputConverter();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    numberTriviaBloc = NumberTriviaBloc(
      inputConverter: mockInputConverter,
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
    );
  });

  group('concrete number trivia', () {
    test(
        'should call InputConverter to validate and return int from the string passed',
        () async {
      when(() => mockInputConverter.stringToInt(numberString)).thenReturn(
        Right(number),
      );

      numberTriviaBloc.add(
        GetConcreteNumberTriviaEvent(numberString: numberString),
      );

      await untilCalled(() => mockInputConverter.stringToInt(numberString));

      verify(() => mockInputConverter.stringToInt(numberString));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit an error state from Bloc when the input is invalid',
      build: () {
        when(() => mockInputConverter.stringToInt(negativeNumberString))
            .thenReturn(
          Left(InvalidInputType()),
        );
        return numberTriviaBloc;
      },
      seed: () => NumberTriviaState.initial(),
      act: (bloc) async {
        bloc.add(
          GetConcreteNumberTriviaEvent(numberString: negativeNumberString),
        );
        await bloc.stream.firstWhere(
          (state) => state.processingState == ProcessingState.error,
        );
      },
      expect: () => [
        waitingState,
        inputErrorState,
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return a concrete number trivia from concrete number usecase when the action is successful',
      build: () {
        when(() => mockInputConverter.stringToInt(numberString)).thenReturn(
          Right(number),
        );

        when(() => mockGetConcreteNumberTrivia.call(Params(number: number)))
            .thenAnswer(
          (_) async => Right(numberTrivia),
        );
        return numberTriviaBloc;
      },
      seed: () => NumberTriviaState.initial(),
      act: (bloc) async {
        bloc.add(
          GetConcreteNumberTriviaEvent(numberString: numberString),
        );
        await untilCalled(
          () => mockGetConcreteNumberTrivia.call(Params(number: number)),
        );
        await bloc.stream.firstWhere(
          (state) => state.processingState == ProcessingState.success,
        );
      },
      expect: () => [
        waitingState,
        successState,
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return an error state from concrete number usecase when the action is unsuccessful',
      build: () {
        when(() => mockInputConverter.stringToInt(numberString)).thenReturn(
          Right(number),
        );

        when(() => mockGetConcreteNumberTrivia.call(Params(number: number)))
            .thenAnswer(
          (_) async => Left(ServerFailure()),
        );
        return numberTriviaBloc;
      },
      seed: () => NumberTriviaState.initial(),
      act: (bloc) async {
        bloc.add(
          GetConcreteNumberTriviaEvent(numberString: numberString),
        );

        await bloc.stream.firstWhere(
          (state) => state.processingState == ProcessingState.error,
        );
      },
      expect: () => [
        waitingState,
        serverErrorState,
      ],
    );
  });

// random number trivia
  group('random number trivia', () {
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return a random number trivia from random number usecase when the action is successful',
      build: () {
        when(() => mockGetRandomNumberTrivia.call(NoParams())).thenAnswer(
          (_) async => Right(numberTrivia),
        );
        return numberTriviaBloc;
      },
      seed: () => NumberTriviaState.initial(),
      act: (bloc) async {
        bloc.add(
          GetRandomNumberTriviaEvent(),
        );
        await untilCalled(
          () => mockGetRandomNumberTrivia.call(NoParams()),
        );
        await bloc.stream.firstWhere(
          (state) => state.processingState == ProcessingState.success,
        );
      },
      expect: () => [
        waitingState,
        successState,
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return an error state from random number usecase when the action is unsuccessful',
      build: () {
        when(() => mockGetRandomNumberTrivia.call(NoParams())).thenAnswer(
          (_) async => Left(CacheFailure()),
        );
        return numberTriviaBloc;
      },
      seed: () => NumberTriviaState.initial(),
      act: (bloc) async {
        bloc.add(
          GetRandomNumberTriviaEvent(),
        );

        await bloc.stream.firstWhere(
          (state) => state.processingState == ProcessingState.error,
        );
      },
      expect: () => [
        waitingState,
        cacheErrorState,
      ],
    );
  });
}
