import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:clean_archi/core/constants/enums/processing_state.dart';
import 'package:clean_archi/core/constants/error_msg.dart';
import 'package:clean_archi/core/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/input_converter.dart';
import '../../data/models/number_trivia_model.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/use_cases/get_concrete_number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.inputConverter,
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
  }) : super(NumberTriviaState.initial()) {
    on<GetConcreteNumberTriviaEvent>(fetchConcreteNumberTrivia);
    on<GetRandomNumberTriviaEvent>(fetchRandomNumberTrivia);
  }

  Future<void> fetchConcreteNumberTrivia(
    GetConcreteNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(
      state.copyWith(
        numberTrivia: NumberTriviaModel.initial(),
        processingState: ProcessingState.loading,
      ),
    );

    final inputEither = inputConverter.stringToInt(event.numberString);

    await inputEither.fold((failure) {
      emit(state.copyWith(
        numberTrivia: NumberTriviaModel.initial(),
        processingState: ProcessingState.error,
        errorMsg: ErrorMsg.INPUT_CONVERTER_ERROR_MSG,
      ));
    }, (integer) async {
      final response = await getConcreteNumberTrivia.call(
        Params(number: integer),
      );

      response.fold((failure) {
        emit(state.copyWith(
          numberTrivia: NumberTriviaModel.initial(),
          processingState: ProcessingState.error,
          errorMsg: ErrorMsg.SERVER_ERROR_MSG,
        ));
      }, (numberTrivia) {
        emit(state.copyWith(
          // numberTrivia: NumberTriviaModel.initial(), // for test to pass
          numberTrivia: numberTrivia,
          processingState: ProcessingState.success,
        ));
      });
    });
  }

  Future<void> fetchRandomNumberTrivia(
    GetRandomNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(
      state.copyWith(
        numberTrivia: NumberTriviaModel.initial(),
        processingState: ProcessingState.loading,
      ),
    );

    final response = await getRandomNumberTrivia.call(
      NoParams(),
    );

    response.fold((failure) {
      emit(state.copyWith(
        numberTrivia: NumberTriviaModel.initial(),
        processingState: ProcessingState.error,
        errorMsg: ErrorMsg.CACHE_ERROR_MSG,
      ));
    }, (numberTrivia) {
      emit(state.copyWith(
        // numberTrivia: NumberTriviaModel.initial(), // for test to pass
        numberTrivia: numberTrivia,
        processingState: ProcessingState.success,
      ));
    });
  }
}
