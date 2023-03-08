
import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/platform/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

import '../models/number_trivia_model.dart';

typedef Future<NumberTriviaModel?> _concreteOrRandomChooser();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository{
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl({required this.remoteDatasource, required this.localDatasource, required this.networkInfo}):super();

  @override
  Future<Either<Failures, NumberTrivia?>?>? getConcreteNumberTrivia(int number) async{
    return await _getRemoteData(() async => await remoteDatasource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failures, NumberTrivia?>?>? getRandomNumberTrivia() async{
    return await _getRemoteData(() async => await remoteDatasource.getRandomNumberTrivia());
  }

  Future<Either<Failures, NumberTrivia?>?>? _getRemoteData( _concreteOrRandomChooser getRandomOrConcrete) async{
    try {
      final isConnected = await networkInfo.isConnected;
      if (isConnected ?? false){
        final trivia =  await getRandomOrConcrete();
        await localDatasource.cacheNumberTriviaModel(trivia);
        return  Right(trivia);
      }else{
        final trivia = await localDatasource.getLastNumberTriviaModel();
        return Right(trivia);
      }
    } on ServerException{
      return Left(ServerFailure());
    } on CachedException{
      return Left(CachedFailure());
    }
  }


  @override
  // TODO: implement props
  List<Object?> get props => [];


}