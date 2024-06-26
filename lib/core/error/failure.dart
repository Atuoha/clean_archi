import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
   const Failure([List properties = const <dynamic>[]]):super();
}


// general failures

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}


class CacheFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class InvalidInputType extends Failure {
  @override
  List<Object?> get props => [];
}

