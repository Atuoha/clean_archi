part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class NumberTriviaInitial extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  final ProcessingState processingState;

  const NumberTriviaInitial({
    required this.numberTrivia,
    required this.processingState,
  });

  factory NumberTriviaInitial.initial() => NumberTriviaInitial(
        numberTrivia: NumberTrivia.initial(),
        processingState: ProcessingState.initial,
      );

  @override
  List<Object> get props => [numberTrivia, processingState];

  NumberTriviaInitial copyWith({
    NumberTrivia? numberTrivia,
    ProcessingState? processingState,
  }) {
    return NumberTriviaInitial(
      numberTrivia: numberTrivia ?? this.numberTrivia,
      processingState: processingState ?? this.processingState,
    );
  }

  @override
  String toString() {
    return 'NumberTriviaInitial{numberTrivia: $numberTrivia, processingState: $processingState}';
  }
}
