
import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/platform/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../models/number_trivia_model.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository{
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl({required this.remoteDatasource, required this.localDatasource, required this.networkInfo}):super();

  @override
  Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(int number) async{
    networkInfo.isConnected;
    // TODO: implement getConcreteNumberTrivia
    NumberTriviaModel trivia =  await remoteDatasource.getConcreteNumberTrivia(number) ?? const NumberTriviaModel(text: 'sample test', number: 1);
    await localDatasource.cacheNumberTriviaModel(trivia);
    return  Right(trivia);
    // return Future.delayed(const Duration(seconds: 1), ()=>const Right(NumberTriviaModel(text: 'sample test', number: 1)));
  }

  @override
  Future<Either<Failures, NumberTrivia>?>? getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];


}