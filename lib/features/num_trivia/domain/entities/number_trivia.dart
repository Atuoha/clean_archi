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
        text: '',
        number: 0,
        found: false,
      );

  @override
  List<Object> get props => [text, number, found];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
      'found': found,
    };
  }

  factory NumberTrivia.fromJson(Map<String, dynamic> json) {
    return NumberTrivia(
      text: json['text'] as String,
      number: json['number'] as int,
      found: json['found'] as bool,
    );
  }

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
