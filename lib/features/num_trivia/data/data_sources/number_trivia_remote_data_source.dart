import 'dart:convert';

import 'package:clean_archi/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/string_constants.dart';
import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as httpUtil;

abstract class NumberTriviaRemoteDataSource {
  // concrete number trivia
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  // random number trivia
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final httpUtil.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getNumberTrivia(
        url: '${AppString.URL}/$number',
      );

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getNumberTrivia(url: '${AppString.URL}/random');



  // get number trivia fnc for both random and concrete
  Future<NumberTriviaModel> _getNumberTrivia({required String url}) async {
    final response = await client.get(
      Uri.parse(url),
      headers: AppString.headers,
    );
    if (response.statusCode == 200) {
      NumberTriviaModel numberTriviaModel = NumberTriviaModel.fromJson(
        jsonDecode(response.body),
      );

      // PRINTING
      if (kDebugMode) {
        print(
          'DATA: text- ${numberTriviaModel.text}, number: ${numberTriviaModel.number}',
        );
      }
      return numberTriviaModel;
    }
    throw const ServerException();
  }
}


