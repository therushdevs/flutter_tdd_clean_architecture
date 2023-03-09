@GenerateNiceMocks([MockSpec<SharedPreferences>(as: #MockSharedPreferances)])
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_readers.dart';
import 'number_trivia_local_datasource_test.mocks.dart';

void main(){
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;
  late MockSharedPreferances mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferances();
    numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(pref: mockSharedPreferences);
  });

  group('getLastNumberTriviaModel', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test('should return NumberTrivia from shared preferences when theres one in the cache',() async{
    //  arrange
      ///when user calls the getString() methode of sharedPrefs then it should return the data in json format.
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('trivia_cached.json'));
    //  act
      final result = await numberTriviaLocalDataSourceImpl.getLastNumberTriviaModel();
    //  assert
      verify(mockSharedPreferences.getString('cached_number_trivia'));
      expect(result, tNumberTriviaModel);
    });

    test('should throw a CachedException when theres no data in the shared preferences',() async{
      //  arrange
      ///when user calls the getString() methode of sharedPrefs then it should return the data in json format.
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //  act
      final result =  numberTriviaLocalDataSourceImpl.getLastNumberTriviaModel();
      //  assert
      verify(mockSharedPreferences.getString('cached_number_trivia'));
      expect(()=> result, throwsA( const TypeMatcher<CachedException>()));
    });

  });

  group('cacheNumberTrivia', () {
    final numberTriviaModel = NumberTriviaModel(text: 'sample test', number: 1);
    test('should cache the NumberTriviaModel to the local data source', () {
    //  arrange
    //   when(mockSharedPreferences.setString('cached_number_trivia', any));
    //  act
      numberTriviaLocalDataSourceImpl.cacheNumberTriviaModel(numberTriviaModel);
    //  assert
      verify(mockSharedPreferences.setString('cached_number_trivia', json.encode(numberTriviaModel.toJson())));
    });
  });
}