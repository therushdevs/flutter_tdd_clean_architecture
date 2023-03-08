

import 'package:equatable/equatable.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

/// The contract is written in here with the help of abstract classes,
/// implementation of which can be found in the repositories of the data layer.

abstract class NumberTriviaRepository extends Equatable{
  // Either<L,R> L- is the failure returned & R- is the success call output gotten from the future.
  Future<Either<Failures, NumberTrivia>?>? getConcreteNumberTrivia(int number);
  Future<Either<Failures, NumberTrivia>?>? getRandomNumberTrivia();
}