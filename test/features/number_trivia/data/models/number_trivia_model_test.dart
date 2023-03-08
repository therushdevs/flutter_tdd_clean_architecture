import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_readers.dart';

void main(){
  final tNumberTrivia = NumberTriviaModel(number: 1, text: 'sample test');
  
  test(
      'should be a subclass of NumberTrivia entity',
      () => {
      //  assert - checking if the model is the subclass of entity or not.
        expect(tNumberTrivia, isA<NumberTrivia>())
      }
  );

//  test: taking the json data as the parameter & returning the instance of the number_trivia_model
//i.e. testing the .fromJson() functionality of model.
group('fromJson', () {
  test(
    'should return a valid model when the json number is an integer',
    () async{
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

    //  act
      final result = NumberTriviaModel.fromJson(jsonMap);
      
    //  assert
      expect(result, tNumberTrivia);
    },
  );

  test(
    'should return a valid model when the json number is double',
        () async{
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));

      //  act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //  assert
      expect(result, tNumberTrivia);
    },
  );
});

group('toJson', () {
  test(
    'should return a json map containing a proper data',
    () {
    //arrange - already arranged data like, final tNumberTrivia = NumberTriviaModel(number: 1, text: 'sample test');

    //act
    final result = tNumberTrivia.toJson(tNumberTrivia);
    //assert
    final expectedMap = {"text": "sample test", "number": 1};
    expect(result, expectedMap);
    },
  );
});

}