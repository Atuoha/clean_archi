import 'dart:convert';
import 'package:clean_archi/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/string_constants.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> get getNumberTriviaLocalData;

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}


class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) async {
    await sharedPreferences.setString(
      AppString.CACHED_NUMBER_TRIVIA,
      jsonEncode(
        numberTriviaModel.toJson(),
      ),
    );
  }

  @override
  Future<NumberTriviaModel> get getNumberTriviaLocalData {
    final jsonString = sharedPreferences.getString(AppString.CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(
        NumberTriviaModel.fromJson(
          jsonDecode(jsonString),
        ),
      );
    }

    throw const CacheException();
  }
}
