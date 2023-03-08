
import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/platform/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl extends NumberTriviaRepository{
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;
  NumberTriviaRepositoryImpl({required this.remoteDatasource, required this.localDatasource, required this.networkInfo}):super();

  @override
  Future<Either<Failures, NumberTrivia>?>? getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
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