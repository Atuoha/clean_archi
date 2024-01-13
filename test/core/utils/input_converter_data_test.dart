import 'package:clean_archi/core/error/failure.dart';
import 'package:clean_archi/core/utils/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';

void main() {
  late InputConverter inputConverter;
  String numberStr = '11';
  String str = 'string';
  String negativeNumberStr = '-11';

  setUp(() {
    inputConverter = InputConverter();
  });

  group('String to unSignedInt', () {
    test('should return an integer when the string represent unsigned int', () {
      final number = inputConverter.stringToInt(numberStr);
      expect(number, equals(const Right(11)));
    });
  });

  test('should return Failure when the string doesn\'t represent unsigned int',
      () {
    final number = inputConverter.stringToInt(str);
    expect(
      number,
      equals(Left(InvalidInputType())),
    );
  });

  test(
      'should return Failure when the string represent negative unsigned int',
      () {
    final number = inputConverter.stringToInt(negativeNumberStr);
    expect(
      number,
      equals(Left(InvalidInputType())),
    );
  });
}
