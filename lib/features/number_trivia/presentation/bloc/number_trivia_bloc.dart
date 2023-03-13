
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import '../../../../core/utils/imput_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'server failure';
const String CACHE_FAILURE_MESSAGE = 'cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'invalid input';

///<inputs an event, outputs the state> => <NumberTriviaEvent, NumberTriviaState>
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concreteNumberTrivia;
  final GetRandomNumberTrivia randomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.concreteNumberTrivia,
      required this.randomNumberTrivia,
      required this.inputConverter}) : super(EmptyState()) {
    on<NumberTriviaEvent>((event, emit) async{

      // Concrete Number Trivia
        if(event is GetTriviaForConcreteNumber){
          final input = inputConverter.stringToUnsignedInteger(event.numberString);
          // emits the failure-success of input conversion
          input.fold((lFailure){
             emit( const ErrorState(errorMessage: INVALID_INPUT_FAILURE_MESSAGE));
          }, (rSuccess) async{
            emit(LoadingState());
            final result = await concreteNumberTrivia(Params(number: rSuccess));
            // emits the failure-success of getConcreteNumber use case
            result.fold((lResult) {
              switch (lResult.runtimeType){
                case ServerFailure:
                 emit(const ErrorState(errorMessage: SERVER_FAILURE_MESSAGE));
                 break;
                case CachedFailure:
                 emit(const ErrorState(errorMessage: CACHE_FAILURE_MESSAGE));
                 break;
                default:
                emit(const ErrorState(errorMessage: 'Unexpected Error!'));
              }
          
            }, (rResult) {
              emit(LoadedState(numberTrivia: rResult));
            });
          });
        }else if(event is GetTriviaForRandomNumber){
          emit(LoadingState());
          final result = await randomNumberTrivia(NoParams());
            // emits the failure-success of getConcreteNumber use case
            result.fold((lResult) {
              switch (lResult.runtimeType){
                case ServerFailure:
                 emit(const ErrorState(errorMessage: SERVER_FAILURE_MESSAGE));
                 break;
                case CachedFailure:
                 emit(const ErrorState(errorMessage: CACHE_FAILURE_MESSAGE));
                 break;
                default:
                emit(const ErrorState(errorMessage: 'Unexpected Error!'));
              }
            }, (rResult) {
              emit(LoadedState(numberTrivia: rResult));
            });
        }
    });
  }
}
