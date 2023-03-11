///To Generate Mocks use the command "flutter pub run build_runner build"
@GenerateNiceMocks([MockSpec<GetConcreteNumberTrivia>(as: #MockGetConcreteNumberTrivia)])
@GenerateNiceMocks([MockSpec<GetRandomNumberTrivia>(as: #MockGetRandomNumberTrivia)])
@GenerateNiceMocks([MockSpec<InputConverter>(as: #MockInputConverter)])

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/core/utils/imput_converter.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:bloc/bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

void main(){
  late MockGetConcreteNumberTrivia concreteNumberTrivia;
  late MockGetRandomNumberTrivia randomNumberTrivia;
  late MockInputConverter inputConverter;
  late NumberTriviaBloc bloc;

  setUp(() {
    concreteNumberTrivia = MockGetConcreteNumberTrivia();
    randomNumberTrivia = MockGetRandomNumberTrivia();
    inputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        concreteNumberTrivia: concreteNumberTrivia,
        randomNumberTrivia: randomNumberTrivia,
        inputConverter: inputConverter,
    );
  });


  group('GetTriviaForConcreteNumber', () {
    const String tNumberString = '1';
    const int tNumber = 1;
    //as the bloc outputs a state so we will need the parse the NumberTrivia instance inside the state while returning
    const numberTrivia = NumberTrivia(text: 'sample test', number: tNumber);
    test('should call the input_converter to convert the data dispatched through the event', () async{
    //  arrange
      when(inputConverter.stringToUnsignedInteger(any))
          .thenAnswer((realInvocation) => const Right(tNumber));
      when(concreteNumberTrivia(any)).thenAnswer((_) async=> const Right(numberTrivia));
    //  act
      bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
      /// As bloc is built on top of streams, so, the dispatch/add events are sinked in to the stream & handled at the outer
      /// end one by one, so to await until the dispatch method is listened, we need to await the call, eventually we use the
      /// untilCalled() of mockito to let the assertion suspended until the result comes in.
      await untilCalled(inputConverter.stringToUnsignedInteger(any));
    //  assert
      verify(inputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when theres an invalid input', () {
      //  arrange
      when(inputConverter.stringToUnsignedInteger(any))
          .thenAnswer((realInvocation) => Left(InvalidInputFailure()));

      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
          const ErrorState(errorMessage: INVALID_INPUT_FAILURE_MESSAGE)
          ]));

      //  act
      bloc.add(const GetTriviaForConcreteNumber(numberString: 'abc'));
    });

    test('should get data from the concrete usecase', () {
      //  arrange
      when(inputConverter.stringToUnsignedInteger(any))
          .thenAnswer((realInvocation) =>const Right(tNumber));
      when(concreteNumberTrivia(any)).thenAnswer((_) async=> const Right(numberTrivia));
      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
           const LoadedState(numberTrivia: numberTrivia)
          ]));

      //  act
      bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
    });

     test('should return ServerFailure when theres problem with the remote data source', () {
      //  arrange
      when(inputConverter.stringToUnsignedInteger(any))
          .thenAnswer((_) =>const Right(tNumber));
      when(concreteNumberTrivia(any)).thenAnswer((_) async=> Left(ServerFailure()));
      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
           const ErrorState(errorMessage: SERVER_FAILURE_MESSAGE)
          ]));

      //  act
      bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
    });

    test('should return CachedFailure when theres problem with the local data source', () {
      //  arrange
      when(inputConverter.stringToUnsignedInteger(any))
          .thenAnswer((_) =>const Right(tNumber));
      when(concreteNumberTrivia(any)).thenAnswer((_) async=> Left(CachedFailure()));
      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
           const ErrorState(errorMessage: CACHE_FAILURE_MESSAGE)
          ]));

      //  act
      bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString));
    });
  });

 group('GetTriviaForRandomNumber', () {
    const int tNumber = 1;
    //as the bloc outputs a state so we will need the parse the NumberTrivia instance inside the state while returning
    const numberTrivia = NumberTrivia(text: 'sample test', number: tNumber);
    test('should call the randomNumberTrivia use case', () async{
    //  arrange
      when(randomNumberTrivia(any)).thenAnswer((_) async=> const Right(numberTrivia));
    //  act
      bloc.add(GetTriviaForRandomNumber());
      /// As bloc is built on top of streams, so, the dispatch/add events are sinked in to the stream & handled at the outer
      /// end one by one, so to await until the dispatch method is listened, we need to await the call, eventually we use the
      /// untilCalled() of mockito to let the assertion suspended until the result comes in.
      await untilCalled(randomNumberTrivia(any));
    //  assert
      verify(randomNumberTrivia(NoParams()));
    });

    test('should get data from the random usecase', () {
      //  arrange
      when(randomNumberTrivia(any)).thenAnswer((_) async=> const Right(numberTrivia));
      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
           const LoadedState(numberTrivia: numberTrivia)
          ]));

      //  act
      bloc.add(GetTriviaForRandomNumber());
    });

     test('should return ServerFailure when theres problem with the remote data source', () {
      //  arrange
      when(randomNumberTrivia(any)).thenAnswer((_) async=> Left(ServerFailure()));
      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
           const ErrorState(errorMessage: SERVER_FAILURE_MESSAGE)
          ]));

      //  act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('should return CachedFailure when theres problem with the local data source', () {
      //  arrange
      when(inputConverter.stringToUnsignedInteger(any))
          .thenAnswer((_) =>const Right(tNumber));
      when(randomNumberTrivia(any)).thenAnswer((_) async=> Left(CachedFailure()));
      //  assert Later
      /// As we will be checking if the emit contains the expected result, we will use expectLater() method in test
      /// which puts the particular test on hold until the data is been emitted(upper limit 30 seconds) & then applies the checks
      expectLater(
        bloc.stream,
        emitsInOrder([
           const ErrorState(errorMessage: CACHE_FAILURE_MESSAGE)
          ]));
      //  act
      bloc.add(GetTriviaForRandomNumber());
    });
  });

}