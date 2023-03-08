import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/platform/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDatasource{}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDatasource{}

class MockNetworkInfo extends Mock implements NetworkInfo{}

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

      group(
          'Device is online',
          () {
            setUp((){
              when(mockNetworkInfo.isConnected).thenAnswer((_) async=> true);
            });
            test(
              'should return remote data when the call to the remote data source is successful',
                  () async {
                ///  arrange
                when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async=> numberTriviaModel);
                /// act
                final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
                ///  assert
                //Verifies if the function is called with the specified input or not.
                // verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
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
                // verify(repositoryImpl.getConcreteNumberTrivia(tNumber));
                verify(mockLocalDataSource.cacheNumberTriviaModel(numberTriviaModel));
              },
            );
          },
      );

      group(
        'Device is offline',
            () {
          setUp((){
            when(mockNetworkInfo.isConnected).thenAnswer((_) async=> false);
          });
          test(
            'should return remote data when the call to the remote data source is not successful',
                () {
              //  arrange
              when(mockLocalDataSource.getLastNumberTriviaModel()).thenAnswer((_) async=> numberTriviaModel);
              //  act
              final result = repositoryImpl.getConcreteNumberTrivia(tNumber);
              //  assert
              expect(result, numberTriviaModel);
            },
          );
        },
      );
    },
  );
}