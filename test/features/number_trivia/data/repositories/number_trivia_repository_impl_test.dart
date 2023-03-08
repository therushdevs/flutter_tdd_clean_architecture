import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/platform/network_info.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

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
}