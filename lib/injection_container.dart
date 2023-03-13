import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia_clean_architecture/core/network/network_info.dart';
import 'package:number_trivia_clean_architecture/core/utils/imput_converter.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async{
  /// Features: NumberTrivia
  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(
    concreteNumberTrivia: sl(),
    randomNumberTrivia: sl(),
    inputConverter: sl()));
  // Usecases
  sl.registerFactory(() => GetConcreteNumberTrivia(repository: sl()));
  sl.registerFactory(() => GetConcreteNumberTrivia(repository: sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
    remoteDatasource: sl(),
    localDatasource: sl(),
    networkInfo: sl()));

  // datasource
  sl.registerLazySingleton<NumberTriviaRemoteDatasource>(() => NumberTriviaRemoteDatasourceImpl(httpClient: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDatasource>(() => NumberTriviaLocalDataSourceImpl(pref: sl()));



  /// Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(()=>NetworkInfoImpl(dataConnectionChecker: sl()));


  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);
  sl.registerFactory(() => http.Client());
  sl.registerFactory(() => DataConnectionChecker());
}