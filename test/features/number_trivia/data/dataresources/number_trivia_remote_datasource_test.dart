import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
@GenerateNiceMocks([MockSpec<http.Client>(as: #MockHttp)])
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_readers.dart';
import 'number_trivia_remote_datasource_test.mocks.dart';

void main(){
  late NumberTriviaRemoteDatasourceImpl numberTriviaRemoteDatasourceImpl;
  late MockHttp mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttp();
    numberTriviaRemoteDatasourceImpl = NumberTriviaRemoteDatasourceImpl(httpClient: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    final NumberTriviaModel tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    const tNumber = 1;
    test('''should check if the http request is made with number
     being the endpoint & application/json being the header''', () async{
    //  arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_)=>Future.value(http.Response(fixture('trivia.json'), 200)));
    //  act
      final result = await numberTriviaRemoteDatasourceImpl.getConcreteNumberTrivia(tNumber);
    //  assert
      /// verifying if the api call is with the proper api endpoint & json conversion content-type header
      verify(mockHttpClient.get(
          Uri.parse('$urlNumberTrivia/$tNumber'),
          headers: {
            'Content-Type' : 'application/json'
          }));
    });

    test('''should return NumberTriviaModel when the response code is 200(successful)''', () async{
      //  arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async=> http.Response(fixture('trivia.json'), 200));
      //  act
      final result = await numberTriviaRemoteDatasourceImpl.getConcreteNumberTrivia(tNumber);
      //  assert
      /// verifying if the api call is with the proper api endpoint & json conversion content-type header
      verify(mockHttpClient.get(
          Uri.parse('$urlNumberTrivia/$tNumber'),
          headers: {
            'Content-Type' : 'application/json'
          }));
      expect(result, tNumberTriviaModel);
    });

    test('''should throw ServerException when the response code is not 200(unsuccessful)''', () async{
      //  arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('No data found', 404));
      //  act
      final call = numberTriviaRemoteDatasourceImpl.getConcreteNumberTrivia(tNumber);
      //  assert
      /// verifying if the api call is with the proper api endpoint & json conversion content-type header
      verify(mockHttpClient.get(
          Uri.parse('$urlNumberTrivia/$tNumber'),
          headers: {
            'Content-Type' : 'application/json'
          }));
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}