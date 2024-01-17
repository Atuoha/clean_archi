import 'package:clean_archi/core/utils/input_converter.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_archi/features/num_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:clean_archi/features/num_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/num_trivia/data/data_sources/number_trivia_local_data_source.dart';
import '../../features/num_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import '../../features/num_trivia/data/repositories/number_trivia_repository_impl.dart';
import '../../features/num_trivia/domain/repositories/number_trivia_repository.dart';
import '../platform/network_info.dart';

final getIt = GetIt.instance;

void init() {
  // Features------
  // number trivia bloc
  getIt.registerFactory(
    () => NumberTriviaBloc(
      inputConverter: getIt(),
      getConcreteNumberTrivia: getIt(),
      getRandomNumberTrivia: getIt(),
    ),
  );

  // Use cases------
  // get concrete number trivia
  getIt.registerLazySingleton(
    () => GetConcreteNumberTrivia(
      numberTriviaRepository: getIt(),
    ),
  );

  // get random number trivia
  getIt.registerLazySingleton(
    () => GetRandomNumberTrivia(
      numberTriviaRepository: getIt(),
    ),
  );

  // Repository------

  // number trivia repo
  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      networkInfo: getIt(),
      numberTriviaLocalDataSource: getIt(),
      numberTriviaRemoteDataSource: getIt(),
    ),
  );

  // Core-----
  // input converter
  getIt.registerLazySingleton(
    () => InputConverter(),
  );

  // network info
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  // Data Source------
  //number trivia local data soucre
  getIt.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: getIt(),
    ),
  );

  // number trivia remote data source
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: getIt(),
    ),
  );

  //External-----
  // http client
  getIt.registerLazySingleton<Client>(
    () => Client(),
  );

  // connectivity
  getIt.registerLazySingleton(
    () => Connectivity(),
  );

  // shared preferences
  getIt.registerLazySingleton(
    () => SharedPreferences.getInstance(),
  );

  // internet connection checker
  getIt.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
