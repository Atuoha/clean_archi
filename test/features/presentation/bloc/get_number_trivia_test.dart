import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_archi/core/constants/enums/processing_state.dart';
import 'package:clean_archi/core/use_cases/use_cases.dart';
import 'package:clean_archi/core/utils/input_converter.dart';
import 'package:clean_archi/features/num_trivia/data/models/number_trivia_model.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:clean_archi/features/num_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/trivia_reader.dart';

class MockInputConverter extends Mock implements InputConverter {}

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

void main() {
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc numberTriviaBloc;

  int number = 1;
  final NumberTriviaModel numberTriviaModel = NumberTriviaModel.initial();

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
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return concrete NumberTriviaModel '
      'when GetConcreteNumberTriviaEvent is called',
      build: () {
        when(() => mockGetConcreteNumberTrivia.call(Params(number: number)))
            .thenAnswer(
          (_) async => Right(numberTriviaModel),
        );

        return numberTriviaBloc = NumberTriviaBloc(
          inputConverter: mockInputConverter,
          getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
          getRandomNumberTrivia: mockGetRandomNumberTrivia,
        );
      },
      seed: () => NumberTriviaInitial.initial(),
      act: (bloc) async {
        bloc.add(GetConcreteNumberTriviaEvent(numberString: number.toString()));
        await bloc.stream.firstWhere(
            (state) => state.processingState == ProcessingState.success);
      },
      expect: () => [
        NumberTriviaInitial.initial(),
        NumberTriviaInitial(
          numberTrivia: NumberTriviaModel.initial(),
          processingState: ProcessingState.waiting,
        ),
        NumberTriviaInitial(
          numberTrivia: NumberTriviaModel.initial(),
          processingState: ProcessingState.success,
        ),
      ],
    );
  });
}
