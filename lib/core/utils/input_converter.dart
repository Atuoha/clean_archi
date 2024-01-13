import 'package:clean_archi/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringToInt(String str) {
    try {
      int number = int.parse(str);
      if (number < 0) throw const FormatException();

      return Right(number);
    } on FormatException {
      return Left(InvalidInputType());
    }
  }
}


