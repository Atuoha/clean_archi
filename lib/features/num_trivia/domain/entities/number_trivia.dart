import 'package:equatable/equatable.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;
  final bool found;

  const NumberTrivia({
    required this.text,
    required this.number,
    required this.found,
  });

  factory NumberTrivia.initial() => const NumberTrivia(
        text: 'Lorem',
        number: 1,
        found: false,
      );

  @override
  List<Object> get props => [text, number, found];

  NumberTrivia copyWith({
    String? text,
    int? number,
    bool? found,
  }) {
    return NumberTrivia(
      text: text ?? this.text,
      number: number ?? this.number,
      found: found ?? this.found,
    );
  }

  @override
  String toString() {
    return 'NumberTrivia{text: $text, number: $number, found: $found}';
  }
}
