import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> get getNumberTriviaLocalData;

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA ='CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) async {
    await sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      numberTriviaModel.toJson().toString(),
    );
  }

  @override
  Future<NumberTriviaModel> get getNumberTriviaLocalData {
    final jsonString =
        sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    return Future.value(
      NumberTriviaModel.fromJson(
        jsonDecode(jsonString!),
      ),
    );
  }
}
