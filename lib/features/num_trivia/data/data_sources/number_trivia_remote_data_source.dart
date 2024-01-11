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

// get number trivia type
enum GetNumberTriviaType { concrete, random }

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final httpUtil.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    print('concrete called');
    return await getNumberTrivia(
      number: number,
      getNumberTriviaType: GetNumberTriviaType.concrete,
    );
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    print('random called');
    return await getNumberTrivia(
      getNumberTriviaType: GetNumberTriviaType.random,
    );
  }

  // get number trivia fnc for both random and concrete
  Future<NumberTriviaModel> getNumberTrivia({
    int number = 0,
    required GetNumberTriviaType getNumberTriviaType,
  }) async {
    final response = await client.get(
      Uri.parse(
        '$URL/${getNumberTriviaType == GetNumberTriviaType.random ? 'random' : number}',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      NumberTriviaModel numberTriviaModel = NumberTriviaModel.fromJson(
        jsonDecode(response.body),
      );

      // PRINTING
      if (kDebugMode) {
        print(
          getNumberTriviaType == GetNumberTriviaType.random
              ? 'RANDOM: text- ${numberTriviaModel.text}, number: ${numberTriviaModel.number}'
              : 'CONCRETE: text- ${numberTriviaModel.text}, number: ${numberTriviaModel.number}',
        );
      }
      return numberTriviaModel;
    }
    throw const ServerException();
  }
}
