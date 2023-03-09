@GenerateMocks([], customMocks: [MockSpec<DataConnectionChecker>(as: #MockDataConnectionChecker)])
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'network_info_test.mocks.dart';

void main(){
  late MockDataConnectionChecker dataConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(dataConnectionChecker: dataConnectionChecker);
  });
  group('is connected', () {
    test(
      'should pass the call to the DataConnectionChecker.hasConnection',
      () async {
      //  arrange
        final tConnectionStatus = Future.value(false);
        when(dataConnectionChecker.hasConnection).thenAnswer((realInvocation) => tConnectionStatus);
      //  act
        final result = networkInfoImpl.isConnected;
      //  assert
        verify(dataConnectionChecker.hasConnection);
        expect(result, tConnectionStatus);
      },
    );

  });
}