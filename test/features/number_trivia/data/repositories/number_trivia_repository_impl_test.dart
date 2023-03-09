@GenerateNiceMocks([MockSpec<NumberTriviaRemoteDatasource>(as: #MockRemoteDataSource)])
@GenerateNiceMocks([MockSpec<NumberTriviaLocalDatasource>(as: #MockLocalDataSource)])
@GenerateNiceMocks([MockSpec<NetworkInfo>(as: #MockNetworkInfo)])
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/network/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';


void main(){
  late NumberTriviaRepositoryImpl repositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDatasource: mockRemoteDataSource,
      localDatasource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  deviceIsOnline(Function body){
    group(
      'Device is online',
          () {
        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async=> true);
        });
        body();
      });
  }

  deviceIsOffline(Function body){
    group(
        'Device is offline',
            () {
          setUp((){
            when(mockNetworkInfo.isConnected).thenAnswer((_) async=> false);
          });
          body();
        });
  }

  group(
    'getConcreteNumberTrivia',
    () {
      const tNumber = 1;
      const NumberTriviaModel numberTriviaModel= NumberTriviaModel(text: 'sample test', number: 1);
      //the model class instance is type-casted to be of the entity type as it extends the entity class.
      const NumberTrivia numberTrivia = numberTriviaModel;
      test(
         'should check if the device is online',
            () {
            //  arrange
              when(mockNetworkInfo.isConnected).thenAnswer((_) async=> true);
            //  act
              repositoryImpl.getConcreteNumberTrivia(tNumber);
            //  assert
              verify(mockNetworkInfo.isConnected);
            },
         );

      deviceIsOnline(
          () {
            test(
              'should return remote data when the call to the remote data source is successful',
                  () async {
                ///  arrange
                when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async=> numberTriviaModel);
                /// act
                final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
                ///  assert
                //Verifies if the function is called with the specified input or not.
                verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
                expect(result,  equals(const Right(numberTriviaModel)));
              },
            );

            test(
              'should cache the data locally when the call to the remote data source is successful',
                  () async {
                ///  arrange
                when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async=> numberTriviaModel);
                /// act
                await repositoryImpl.getConcreteNumberTrivia(tNumber);
                ///  assert
                //Verifies if the function is called with the specified input or not.
                verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
                verify(mockLocalDataSource.cacheNumberTriviaModel(numberTriviaModel));
              },
            );

            test(
              'should return server failure when the call to the remote data source is Unsuccessful',
                  () async {
                ///  arrange
                when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenThrow(ServerException());
                /// act
                final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
                ///  assert
                //Verifies if the function is called with the specified input or not.
                // verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
                //to ensure no calls are made on the localDataSource instance.
                verifyZeroInteractions(mockLocalDataSource);
                expect(result,  equals(Left(ServerFailure())));
              },
            );
          },
      );

      deviceIsOffline(
            () {
          test(
            'should return the most recent cached data when the cached data is present',
                () async{
              //  arrange
              when(mockLocalDataSource.getLastNumberTriviaModel()).thenAnswer((_) async=> numberTriviaModel);
              //  act
              final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
              //  assert
              verifyZeroInteractions(mockRemoteDataSource);
              verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
              expect(result, equals(const Right(numberTriviaModel)));
            },
          );

          test(
            'should return cached failure when the call to the local data source is Unsuccessful',
                () async {
              ///  arrange
              when(mockLocalDataSource.getLastNumberTriviaModel()).thenThrow(CachedException());
              /// act
              final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
              ///  assert
              verifyZeroInteractions(mockRemoteDataSource);
              //Verifies if the function is called with the specified input or not.
              verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
              expect(result,  equals(Left(CachedFailure())));
            },
          );
        },
      );
    },
  );

  group(
    'getRandomNumberTrivia',
        () {
      const tNumber = 1;
      const NumberTriviaModel numberTriviaModel= NumberTriviaModel(text: 'sample test', number: 1);
      //the model class instance is type-casted to be of the entity type as it extends the entity class.
      const NumberTrivia numberTrivia = numberTriviaModel;
      test(
        'should check if the device is online',
            () {
          //  arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async=> true);
          //  act
          repositoryImpl.getRandomNumberTrivia();
          //  assert
          verify(mockNetworkInfo.isConnected);
        },
      );

      deviceIsOnline(
            () {
          test(
            'should return remote data when the call to the remote data source is successful',
                () async {
              ///  arrange
              when(mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async=> numberTriviaModel);
              /// act
              final result = await repositoryImpl.getRandomNumberTrivia();
              ///  assert
              //Verifies if the function is called with the specified input or not.
              verify(repositoryImpl.getRandomNumberTrivia());
              expect(result,  equals(const Right(numberTriviaModel)));
            },
          );

          test(
            'should cache the data locally when the call to the remote data source is successful',
                () async {
              ///  arrange
              when(mockRemoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async=> numberTriviaModel);
              /// act
              await repositoryImpl.getRandomNumberTrivia();
              ///  assert
              //Verifies if the function is called with the specified input or not.
              verify(repositoryImpl.getRandomNumberTrivia());
              verify(mockLocalDataSource.cacheNumberTriviaModel(numberTriviaModel));
            },
          );

          test(
            'should return server failure when the call to the remote data source is Unsuccessful',
                () async {
              ///  arrange
              when(mockRemoteDataSource.getRandomNumberTrivia()).thenThrow(ServerException());
              /// act
              final result = await repositoryImpl.getRandomNumberTrivia();
              ///  assert
              //Verifies if the function is called with the specified input or not.
              // verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
              //to ensure no calls are made on the localDataSource instance.
              verifyZeroInteractions(mockLocalDataSource);
              expect(result,  equals(Left(ServerFailure())));
            },
          );
        },
      );

      deviceIsOffline(
            () {
          test(
            'should return the most recent cached data when the cached data is present',
                () async{
              //  arrange
              when(mockLocalDataSource.getLastNumberTriviaModel()).thenAnswer((_) async=> numberTriviaModel);
              //  act
              final result = await repositoryImpl.getRandomNumberTrivia();
              //  assert
              verifyZeroInteractions(mockRemoteDataSource);
              verify(repositoryImpl.getRandomNumberTrivia());
              expect(result, equals(const Right(numberTriviaModel)));
            },
          );

          test(
            'should return cached failure when the call to the local data source is Unsuccessful',
                () async {
              ///  arrange
              when(mockLocalDataSource.getLastNumberTriviaModel()).thenThrow(CachedException());
              /// act
              final result = await repositoryImpl.getRandomNumberTrivia();
              ///  assert
              verifyZeroInteractions(mockRemoteDataSource);
              //Verifies if the function is called with the specified input or not.
              verify(repositoryImpl.getRandomNumberTrivia());
              expect(result,  equals(Left(CachedFailure())));
            },
          );
        },
      );
    },
  );
}