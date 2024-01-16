part of 'number_trivia_bloc.dart';

class NumberTriviaState extends Equatable {
  final NumberTrivia numberTrivia;
  final ProcessingState processingState;
  final String errorMsg;

  const NumberTriviaState({
    required this.numberTrivia,
    required this.processingState,
    this.errorMsg = '',
  });

  factory NumberTriviaState.initial() => NumberTriviaState(
        numberTrivia: NumberTrivia.initial(),
        processingState: ProcessingState.initial,
        errorMsg: '',
      );

  @override
  List<Object> get props => [numberTrivia, processingState, errorMsg];

  NumberTriviaState copyWith({
    NumberTrivia? numberTrivia,
    ProcessingState? processingState,
    String? errorMsg,
  }) {
    return NumberTriviaState(
      numberTrivia: numberTrivia ?? this.numberTrivia,
      processingState: processingState ?? this.processingState,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  String toString() {
    return 'NumberTriviaState{numberTrivia: $numberTrivia, processingState: $processingState,errorMsg:$errorMsg}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is NumberTriviaState &&
          runtimeType == other.runtimeType &&
          numberTrivia == other.numberTrivia &&
          processingState == other.processingState &&
          errorMsg == other.errorMsg;

  @override
  int get hashCode =>
      super.hashCode ^
      numberTrivia.hashCode ^
      processingState.hashCode ^
      errorMsg.hashCode;
}
