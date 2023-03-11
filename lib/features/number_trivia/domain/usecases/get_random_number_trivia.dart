import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements Usecases<NumberTrivia, NoParams>{
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia({required this.repository});

  @override
  Future<Either<Failures, NumberTrivia>> call(NoParams params) async{
    return await repository.getRandomNumberTrivia();
  }
}


