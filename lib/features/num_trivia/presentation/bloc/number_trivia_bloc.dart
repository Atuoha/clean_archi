import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_archi/core/constants/enums/processing_state.dart';
import 'package:clean_archi/core/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/use_cases/get_concrete_number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaInitial> {
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.inputConverter,
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
  }) : super(NumberTriviaInitial.initial()) {
    on<GetConcreteNumberTriviaEvent>(fetchConcreteNumberTrivia);
    on<GetRandomNumberTriviaEvent>(fetchRandomNumberTrivia);
  }

  Future<void> fetchConcreteNumberTrivia(
    GetConcreteNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(state.copyWith(processingState: ProcessingState.waiting));
    try {
      // int number = inputConverter.stringToInt(event.numberString);
      // final response = await getConcreteNumberTrivia.call(
      //   Params(number: number),
      // );
      // emit(state.copyWith(
      //   numberTrivia: response,
      //   processingState: ProcessingState.success,
      // ));
    } catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error));
    }
  }

  Future<void> fetchRandomNumberTrivia(
    GetRandomNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(state.copyWith(processingState: ProcessingState.waiting));
    try {
      // final response = await getRandomNumberTrivia.call(NoParams());
      // emit(state.copyWith(
      //   numberTrivia: response,
      //   processingState: ProcessingState.success,
      // ));
    } catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error));
    }
  }
}
