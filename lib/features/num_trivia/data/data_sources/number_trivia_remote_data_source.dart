import 'dart:convert';

import 'package:clean_archi/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as httpUtil;

abstract class NumberTriviaRemoteDataSource {
  // concrete number trivia
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  // random number trivia
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const URL = 'http://numbersapi.com';
const headers = {'Content-Type': 'application/json'};

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final httpUtil.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    print('concrete called');
    return await getNumberTrivia(
      url: '$URL/$number',
    );
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    print('random called');
    return await getNumberTrivia(
      url: '$URL/random',
    );
  }

  // get number trivia fnc for both random and concrete
  Future<NumberTriviaModel> getNumberTrivia({required String url}) async {
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
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
